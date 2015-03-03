//
//  TweetCell.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "TweetCell.h"
#import "TwitterClient.h"
#import <FontAwesome+iOS/NSString+FontAwesome.h>
#import <AFNetworking/UIButton+AFNetworking.h>

@interface TweetCell()

@property (weak, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIView *tweetCardView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
- (IBAction)retweetTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
- (IBAction)likeTap:(id)sender;
- (IBAction)replyTap:(id)sender;
- (IBAction)userTap:(id)sender;

@end

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tweetCardView.layer.cornerRadius = 4;
    self.profileImage.layer.cornerRadius = 2;
    self.tweetText.preferredMaxLayoutWidth = self.tweetCardView.frame.size.width;
}

-(void)updateViewWithTweet:(Tweet *)tweet {
    self.tweet = tweet;
    
    NSURL *url = [NSURL URLWithString:tweet.user.profile_image_url];
    [self.profileImage setImageForState:0 withURL:url];
    self.userName.text = [NSString stringWithFormat:@"%@ at %@", tweet.user.screen_name, tweet.created];
    self.tweetText.text = tweet.text;
    [self.tweetText sizeToFit];
    
    if (self.tweet.favorited) {
        [self.likeButton setTitleColor:[UIColor colorWithRed:(0/255.0) green:(128/255.0) blue:(64/255.0) alpha:1.0] forState:UIControlStateNormal];
    } else {
        [self.likeButton setTitleColor:[UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1.0] forState:UIControlStateNormal];
    }
    
    if (self.tweet.retweeted) {
        [self.retweetButton setTitleColor:[UIColor colorWithRed:(0/255.0) green:(128/255.0) blue:(64/255.0) alpha:1.0] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setTitleColor:[UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1.0] forState:UIControlStateNormal];
    }
    
    [self.replyButton setTitleColor:[UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1.0] forState:UIControlStateNormal];
    
    [self.retweetButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconRetweet] forState:UIControlStateNormal];
    [self.likeButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconThumbsUp] forState:UIControlStateNormal];
    [self.replyButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconReply] forState:UIControlStateNormal];
}

-(Tweet *)getTweet {
    return self.tweet;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.tweetText.preferredMaxLayoutWidth = self.tweetCardView.frame.size.width;
}

- (IBAction)userTap:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTapUser:)]) {
        [self.delegate didTapUser:self.tweet];
    }
}

- (IBAction)retweetTap:(id)sender {
    self.tweet.retweeted = !self.tweet.retweeted;
    if (self.tweet.retweeted) {
        [self.retweetButton setTitleColor:[UIColor colorWithRed:(0/255.0) green:(128/255.0) blue:(64/255.0) alpha:1.0] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setTitleColor:[UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1.0] forState:UIControlStateNormal];
    }
    [[TwitterClient sharedInstance] reTweet:self.tweet withCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (IBAction)likeTap:(id)sender {
    self.tweet.favorited = !self.tweet.favorited;
    if (self.tweet.favorited) {
        [self.likeButton setTitleColor:[UIColor colorWithRed:(0/255.0) green:(128/255.0) blue:(64/255.0) alpha:1.0] forState:UIControlStateNormal];
    } else {
        [self.likeButton setTitleColor:[UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1.0] forState:UIControlStateNormal];
    }
    [[TwitterClient sharedInstance] favoriteTweet:self.tweet withCompletion:nil];
}

- (IBAction)replyTap:(id)sender {
    if ([self.delegate respondsToSelector:@selector(replyToTweet:)]) {
        [self.delegate replyToTweet:self.tweet];
    }
}

@end
