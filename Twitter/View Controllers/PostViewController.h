//
//  PostViewController.h
//  Twitter
//
//  Created by AP Fritts on 2/22/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface PostViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;

-(void)showInView:(UIView *)parentView animated:(BOOL)animated;
-(void)showAnimate;
-(void)removeAnimate;
-(void)replyToTweet:(Tweet *)tweet;

@end
