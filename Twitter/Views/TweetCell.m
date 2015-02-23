//
//  TweetCell.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "TweetCell.h"
#import "TwitterClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface TweetCell()

@property (weak, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIView *tweetCardView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
- (IBAction)retweetTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
- (IBAction)likeTap:(id)sender;
- (IBAction)replyTap:(id)sender;

@end

@implementation TweetCell

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
    
    if (self.tweet.favorited) {
        self.likeButton.hidden = YES;
    } else {
        self.likeLabel.hidden = YES;
    }
    
    if (self.tweet.retweeted) {
        self.retweetButton.hidden = YES;
    } else {
        self.retweetLabel.hidden = YES;
    }
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

- (IBAction)retweetTap:(id)sender {
    [[TwitterClient sharedInstance] reTweet:self.tweet withCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.tweet.retweeted = YES;
            if (self.tweet.retweeted) {
                self.retweetButton.hidden = YES;
            } else {
                self.retweetLabel.hidden = YES;
            }
        }
    }];
}

- (IBAction)likeTap:(id)sender {
    [[TwitterClient sharedInstance] favoriteTweetx  :self.tweet withCompletion:^(NSError *error) {
        if (error) {
            self.tweet.favorited = YES;
            if (self.tweet.favorited) {
                self.likeButton.hidden = YES;
            } else {
                self.likeLabel.hidden = YES;
            }
        }
    }];
}

- (IBAction)replyTap:(id)sender {
    if ([self.delegate respondsToSelector:@selector(replyToTweet:)]) {
        [self.delegate replyToTweet:self.tweet];
    }
}

@end
