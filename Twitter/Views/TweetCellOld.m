//
//  TweetCell.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "TweetCellOld.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface TweetCellOld()

@property (weak, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIView *tweetCardView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@end

@implementation TweetCellOld

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tweetText.preferredMaxLayoutWidth = self.tweetCardView.frame.size.width;
    self.tweetCardView.clipsToBounds = YES;
}

-(void)updateViewWithTweet:(Tweet *)tweet {
    self.tweet = tweet;
    
    NSURL *url = [NSURL URLWithString:tweet.user.profile_image_url];
    [self.profileImage setImageWithURL:url];
    self.userName.text = [NSString stringWithFormat:@"%@ at %@", tweet.user.screen_name, tweet.created];
    self.tweetText.text = tweet.text;
    [self.tweetText sizeToFit];
}

-(void)sizeToFit {
    [self.tweetText sizeToFit];
    [self.tweetCardView sizeToFit];
    [super sizeToFit];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.tweetText.preferredMaxLayoutWidth = self.tweetCardView.frame.size.width;
}

@end
