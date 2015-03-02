//
//  HamburgerViewController.m
//  Twitter
//
//  Created by AP Fritts on 2/28/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "HamburgerViewController.h"
#import "NavigationViewController.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface HamburgerViewController ()

@property (weak, nonatomic) IBOutlet UIView *childView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;

@property (assign, nonatomic) CGFloat startX;
@property (assign, nonatomic) CGRect openPosition;
@property (assign, nonatomic) CGRect closePosition;

@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat menuWidth = screenSize.width * 0.7;
    NSLog(@"%f", menuWidth);
    
    self.openPosition = CGRectMake(0, 0, menuWidth, screenSize.height);
    self.closePosition = CGRectMake(0 - menuWidth, 0, menuWidth, screenSize.height);
    self.navigationView.frame = self.closePosition;
    
    [self setViewController:[[NavigationViewController alloc] init] asChildToParentViewController:self];
}

-(void)setChildViewController:(UIViewController *)controller {
    [self setViewController:controller asChildToParentViewController:self];
}

-(void)setViewController:(UIViewController *)childController asChildToParentViewController:(UIViewController *)parentController {
    [parentController addChildViewController:childController];
    childController.view.frame = parentController.view.frame;
    [parentController.view addSubview:childController.view];
    [childController didMoveToParentViewController:parentController];
}

# pragma mark - Pull out menu

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // bounce the menu
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:0 animations:^{
        self.navigationView.frame = self.closePosition;
    } completion:^(BOOL finished) {
        NSLog(@"%f, %f  %f x %f", self.navigationView.frame.origin.x, self.navigationView.frame.origin.y, self.navigationView.frame.size.width, self.navigationView.frame.size.height);
    }];
}

- (IBAction)onEdgePan:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.startX = self.navigationView.frame.origin.x;
            break;
        case UIGestureRecognizerStateChanged: {
            [UIView animateWithDuration:0.05 animations:^{
                CGFloat x = self.startX + [sender translationInView:self.view].x;
                CGRect newPosition;
                if (x > 0) {
                    newPosition = CGRectMake(0.0f, self.closePosition.origin.y, self.closePosition.size.width + x, self.closePosition.size.height);
                } else {
                    newPosition = CGRectMake(x, self.closePosition.origin.y, self.closePosition.size.width, self.closePosition.size.height);
                }
                self.navigationView.frame = newPosition;
                NSLog(@"%f, %f  %f x %f", self.navigationView.frame.origin.x, self.navigationView.frame.origin.y, self.navigationView.frame.size.width, self.navigationView.frame.size.height);
            }];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if ([sender velocityInView:self.view].x > 0) {
                // opening
                [UIView animateWithDuration:0.5 animations:^{
                    self.navigationView.frame = self.openPosition;
                }];
            } else {
                // closing
                [UIView animateWithDuration:0.5 animations:^{
                    self.navigationView.frame = self.closePosition;
                }];
            }
            break;
        }
        default:
            // Do nothing
            NSLog(@"Default %f, %f", [sender locationInView:self.view].x, [sender locationInView:self.view].y);
            break;
    }
}

-(void)constrainNavigationMenuToNavigationView {
    // figure out how to programatically constrain objects
}

@end
