//
//  TwitterViewController.h
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetCell.h"

@class TimelineViewController;

@protocol TimelineViewControllerDelegate <NSObject>

-(void)loadTweets:(NSArray *)tweets;

@end

@interface TimelineViewController : UIViewController

@property (strong, nonatomic) void (^loadTweetsHandler)(id<TimelineViewControllerDelegate> delegate);

@end
