//
//  TwitterClient.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"Otb0dVWBKhkHk59z2VKuzYhDI";
NSString * const kTwitterConsumerSecret = @"i2GtRrhXj6YPQdzjyVdOLUgQNjijcPNAwPv92miZWqIC9IVHuB";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+(TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

-(void)loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;

    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"got the request token!");
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the request token: %@", error);
        self.loginCompletion(nil, error);
    }];
}

-(void)openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        // Save the access token
        [self.requestSerializer saveAccessToken:accessToken];
        
        // Save the user
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Current user: %@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to retrieve current user object: %@", error);
            self.loginCompletion(nil, error);
        }];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the access token: %@", error);
        self.loginCompletion(nil, error);
    }];
}

-(NSArray *)loadInAir {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"inAir"];
    if (data != nil) {
        return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    }
    return nil;
}

-(void)loadTimelineSinceId:(NSNumber *)sinceId withCompletion:(void (^)(NSArray *tweets, NSError *error))completion {
    completion([Tweet tweetsWithArray:[self loadInAir]], nil);
    return;
    NSDictionary *params = nil;
    if (sinceId != nil) {
        params = @{@"since_id": sinceId, @"count": @"20"};
    } else {
        params = @{@"count": @"20"};
    }
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:NULL];
        //[[NSUserDefaults standardUserDefaults] setObject:data forKey:@"inAir"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        NSArray *tweets = nil;
        NSError *error = nil;
        @try {
            tweets = [Tweet tweetsWithArray:responseObject];
        }
        @catch (NSError *e) {
            error = e;
        }
        @finally {
            completion(tweets, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to retrieve timeline: %@", error);
        completion(nil, error);
    }];
}

-(void)postTweet:(Tweet *)tweet {
    NSDictionary *params = @{
                             @"tweet": tweet.text
                             };
    [self POST:@"1.1/statuses/update" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // yay
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

@end
