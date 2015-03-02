//
//  ProfileViewController.h
//  Twitter
//
//  Created by AP Fritts on 3/1/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController

-(void)updateViewWithUser:(User *)user;

@end
