//
//  Tweet.h
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *id_str;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL retweeted;
@property (nonatomic, strong) NSString *in_reply_to_status_id;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(NSArray *)tweetsWithArray:(NSArray *)dictionaries;

@end
