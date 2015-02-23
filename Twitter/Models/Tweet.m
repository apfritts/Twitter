//
//  Tweet.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "Tweet.h"

@interface Tweet()

@end

@implementation Tweet

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id_str = dictionary[@"id"];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.created = [formatter dateFromString:dictionary[@"created_at"]];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweeted = dictionary[@"retweeted_status"] != nil;
        self.in_reply_to_status_id = dictionary[@"in_reply_to_status_id"];
    }
    return self;
}

+(NSArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    return tweets;
}

@end
