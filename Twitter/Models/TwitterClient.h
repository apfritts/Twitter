//
//  TwitterClient.h
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//
#import <BDBOAuth1RequestOperationManager.h>
#import "Tweet.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+(TwitterClient *)sharedInstance;

-(void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
-(void)openURL:(NSURL *)url;
-(void)loadTimelineSinceId:(NSNumber *)sinceId withCompletion:(void (^)(NSArray *tweets, NSError *error))completion;
-(void)postTweet:(Tweet *)tweet withCompletion:(void (^)(NSError *error))completion;

@end
