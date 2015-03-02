//
//  User.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "User.h"

@interface User()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation User

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screen_name = dictionary[@"screen_name"];
        self.profile_image_url = dictionary[@"profile_image_url"];
        self.background_image_url = dictionary[@"profile_background_image_url"];
        self.bio = dictionary[@"description"];
        self.followers_count = [dictionary[@"followers_count"] integerValue];
        self.following_count = [dictionary[@"following_count"] integerValue];
        self.tweets_count = [dictionary[@"tweets_count"] integerValue];
    }
    return self;
}


# pragma mark - Static Methods

static User *_currentUser = nil;
NSString * const kCurrentUserKey = @"kCurrentUserKey";

+(User *)currentUser {
    if (_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if (data != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }

    return _currentUser;
}

+(void)setCurrentUser:(User *)user {
    _currentUser = user;
    
    if (_currentUser == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserKey];
    } else {
        NSData *data = [NSJSONSerialization dataWithJSONObject:_currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
