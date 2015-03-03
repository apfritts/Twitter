//
//  HamburgerViewController.m
//  Twitter
//
//  Created by AP Fritts on 2/28/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "HamburgerViewController.h"
#import "NavigationViewController.h"
#import "Navigation.h"
#import "TimelineViewController.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <FontAwesome+iOS/NSString+FontAwesome.h>

@interface HamburgerViewController ()

@property (weak, nonatomic) IBOutlet UIView *childView;
@property (strong, nonatomic) UINavigationController *childViewController;

@property (strong, nonatomic) UIViewController *navigationViewController;

@property (assign, nonatomic) CGFloat startX;
@property (assign, nonatomic) CGRect openPosition;
@property (assign, nonatomic) CGRect closePosition;

@end

@implementation HamburgerViewController
static HamburgerViewController *_instance = nil;

+(instancetype)instance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            [HamburgerViewController reset];
        }
    });
    return _instance;
}

+(void)reset {
    _instance = [[HamburgerViewController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat menuWidth = screenSize.width * 0.65;
    NSLog(@"%f", menuWidth);
    
    self.openPosition = CGRectMake(0, 0, menuWidth, screenSize.height);
    self.closePosition = CGRectMake(0 - menuWidth, 0, menuWidth, screenSize.height);
    self.navigationViewController = [[NavigationViewController alloc] init];
    
    // Add the hamburger menu
    [self addChildViewController:self.navigationViewController];
    self.navigationViewController.view.frame = self.closePosition;
    [self.view addSubview:self.navigationViewController.view];
    [self.navigationViewController didMoveToParentViewController:self];
    
    // create the navigation controller
    self.childViewController = [[UINavigationController alloc] init];
    [self addChildViewController:self.childViewController];
    self.childViewController.view.frame = self.childView.frame;
    [self.childView addSubview:self.childViewController.view];
    [self.childViewController didMoveToParentViewController:self];
    
    // go home
    [Navigation navigateToHome];
}

-(void)displayChildViewController:(UIViewController *)controller {
    [self.childViewController setViewControllers:@[controller] animated:YES];
    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(openMenu)];
}

# pragma mark - Pull out menu

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // bounce the menu
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:0 animations:^{
        self.navigationViewController.view.frame = self.closePosition;
    } completion:^(BOOL finished) {
        NSLog(@"%f, %f  %f x %f", self.navigationViewController.view.frame.origin.x, self.navigationViewController.view.frame.origin.y, self.navigationViewController.view.frame.size.width, self.navigationViewController.view.frame.size.height);
    }];
}

- (IBAction)onEdgePan:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.startX = self.navigationViewController.view.frame.origin.x;
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
                self.navigationViewController.view.frame = newPosition;
                NSLog(@"%f, %f  %f x %f", self.navigationViewController.view.frame.origin.x, self.navigationViewController.view.frame.origin.y, self.navigationViewController.view.frame.size.width, self.navigationViewController.view.frame.size.height);
            }];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if ([sender velocityInView:self.view].x > 0) {
                // opening
                [UIView animateWithDuration:0.5 animations:^{
                    self.navigationViewController.view.frame = self.openPosition;
                }];
            } else {
                // closing
                [UIView animateWithDuration:0.5 animations:^{
                    self.navigationViewController.view.frame = self.closePosition;
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

-(void)openMenu {
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationViewController.view.frame = self.openPosition;
    }];
}

-(void)closeMenu {
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationViewController.view.frame = self.closePosition;
    }];
}

@end
