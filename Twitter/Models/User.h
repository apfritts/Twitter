//
//  User.h
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screen_name;
@property (nonatomic, strong) NSString *profile_image_url;
@property (nonatomic, strong) NSString *background_image_url;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, assign) NSInteger followers_count;
@property (nonatomic, assign) NSInteger following_count;
@property (nonatomic, assign) NSInteger tweets_count;

-(id)initWithDictionary:(NSDictionary *)dictionary;

+(User *)currentUser;
+(void)setCurrentUser:(User *)user;

@end
