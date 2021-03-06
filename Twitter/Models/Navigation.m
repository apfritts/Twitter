//
//  Navigation.m
//  Twitter
//
//  Created by AP Fritts on 3/2/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "Navigation.h"
#import "HamburgerViewController.h"
#import "LoginViewController.h"
#import "TimelineViewController.h"
#import "ProfileViewController.h"
#import "TwitterClient.h"

@implementation Navigation

+(void)navigateToHome {
    TimelineViewController *timeline = [[TimelineViewController alloc] init];
    [timeline setLoadTweetsHandler:^(id<TimelineViewControllerDelegate> delegate) {
        [[TwitterClient sharedInstance] loadTimelineSinceId:nil withCompletion:^(NSArray *tweets, NSError *error) {
            [delegate loadTweets:tweets];
        }];
    }];
    timeline.title = @"Timeline";
    [[HamburgerViewController instance] displayChildViewController:timeline];
}

+(void)navigateToProfile:(User *)user {
    ProfileViewController *profileViewController = [[ProfileViewController alloc] init];
    if (user == nil) {
        user = [User currentUser];
    }
    [profileViewController updateViewWithUser:user];
    [[HamburgerViewController instance] displayChildViewController:profileViewController];
}

+(void)navigateToLogin {
    [User setCurrentUser:nil];
    //[[HamburgerViewController instance].parentViewController presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
    UIWindow *app = [[UIApplication sharedApplication] keyWindow];
    NSArray *subviews = [app subviews];
    LoginViewController *login = [[LoginViewController alloc] init];
    login.view.frame = app.frame;
    app.rootViewController = login;
    [app addSubview:login.view];
    [HamburgerViewController reset];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
}

+(void)navigateToMentions {
    TimelineViewController *timeline = [[TimelineViewController alloc] init];
    [timeline setLoadTweetsHandler:^(id<TimelineViewControllerDelegate> delegate) {
        [[User currentUser] loadMentionsWithCompletion:^(NSArray *tweets, NSError *error) {
            [delegate loadTweets:tweets];
        }];
    }];
    timeline.title = @"Mentions";
    [[HamburgerViewController instance] displayChildViewController:timeline];
}

@end
