//
//  LoginViewController.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TimelineViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *twitterLogo;
- (IBAction)loginTap:(id)sender;

@end

@implementation LoginViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // @TODO: Add FontAwesome font here
    self.errorLabel.text = @"! Network Error\nCheck your connection and try again.";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        CGPoint logoCenter = self.twitterLogo.center;
        CGPoint labelCenter = self.instructionLabel.center;
        logoCenter.y += -100.0f;
        labelCenter.y += -100.0f;
        self.twitterLogo.center = logoCenter;
        self.instructionLabel.center = labelCenter;
        self.twitterLogo.alpha = 1.0f;
        self.instructionLabel.alpha = 1.0f;
    }];
}

- (IBAction)loginTap:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            TimelineViewController *twitter = [[TimelineViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:twitter];
            [self showViewController:nav sender:self];
        } else {
            [UIView animateWithDuration:0.5f animations:^{
                self.errorLabel.alpha = 1.0f;
                CGPoint errorCenter = self.errorLabel.center;
                errorCenter.y += 50.0f;
                self.errorLabel.center = errorCenter;
            }];
        }
    }];
}

@end
