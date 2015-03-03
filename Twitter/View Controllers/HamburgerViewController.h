//
//  HamburgerViewController.h
//  Twitter
//
//  Created by AP Fritts on 2/28/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HamburgerViewController : UIViewController

+(instancetype)instance;
+(void)reset;
-(void)displayChildViewController:(UIViewController *)controller;
-(void)openMenu;
-(void)closeMenu;

@end
