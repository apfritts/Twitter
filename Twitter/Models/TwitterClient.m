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

@end
