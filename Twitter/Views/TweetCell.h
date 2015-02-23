//
//  TweetCell.h
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetCell;

@protocol TweetCellDelegate <NSObject>

-(void)replyToTweet:(Tweet *)tweet;

@end

@interface TweetCell : UITableViewCell

-(void)updateViewWithTweet:(Tweet *)tweet;
@property (weak, nonatomic) id<TweetCellDelegate> delegate;

@end
