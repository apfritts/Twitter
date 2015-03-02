//
//  Navigation.h
//  Twitter
//
//  Created by AP Fritts on 3/2/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Navigation : NSObject

+(void)navigateToHome;
+(void)navigateToProfile:(User *)user;
+(void)navigateToLogin;
+(void)navigateToMentions;

@end
