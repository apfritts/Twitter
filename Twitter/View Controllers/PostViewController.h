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

-(void)showPopupInViewController:(UIViewController *)parentViewController;
-(void)closePopup;
-(void)replyToTweet:(Tweet *)tweet;

@end
