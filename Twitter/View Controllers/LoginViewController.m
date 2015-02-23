//
//  LoginViewController.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TwitterViewController.h"

@interface LoginViewController ()

- (IBAction)loginTap:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginTap:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            TwitterViewController *twitter = [[TwitterViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:twitter];
            [self showViewController:nav sender:self];
        } else {
            // Error
        }
    }];
}

@end
