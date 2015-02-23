//
//  PostPopup.m
//  Twitter
//
//  Created by AP Fritts on 2/22/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "PostPopup.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PostPopup()

@property (strong, nonatomic) UIView *cardView;
@property (strong, nonatomic) UIImageView *profileImage;
@property (strong, nonatomic) UITextField *tweet;
@property (strong, nonatomic) UIButton *post;

@end

@implementation PostPopup

-(instancetype)init {
    self = [super init];
    if (self) {
        self.cardView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, [[UIScreen mainScreen] bounds].size.width - 40, 100)];
        self.cardView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [self addSubview:self.cardView];
    }
    return self;
}

-(CGSize)sizeThatFits:(CGSize)size {
    return [[UIScreen mainScreen] bounds].size;
}

@end
