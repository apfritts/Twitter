//
//  PostViewController.m
//  Twitter
//
//  Created by AP Fritts on 2/22/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "PostViewController.h"
#import "TwitterClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PostViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) UILabel *barButtonCount;
@property (weak, nonatomic) IBOutlet UITextView *postText;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@property (weak, nonatomic) UIView *parentView;

@property (weak, nonatomic) Tweet *replyTweet;

@end

@implementation PostViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.popUpView.layer.cornerRadius = 10;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [super viewDidLoad];
    
    self.title = @"Post Tweet";
    [self.profilePic setImageWithURL:[NSURL URLWithString:[User currentUser].profile_image_url]];
    self.userName.text = [NSString stringWithFormat:@"%@ says:", [User currentUser].name];
    
    //[self.postButton actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
    [self.postButton addTarget:self action:@selector(doYourPost) forControlEvents:UIControlEventTouchUpInside];
}

-(void)doYourPost {
    NSLog(@"posting");
}

-(void)showAnimate {
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

-(void)removeAnimate {
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (IBAction)onPostTap:(id)sender {
    NSLog(@"Got the post tap");
    //[self removeAnimate];
    return;
    // @TODO: require reply user name in tweet
    if (self.postText.text.length > 140) {
        // flash the barButtonItem
        return;
    }
    Tweet *tweet = [[Tweet alloc] init];
    if (self.replyTweet) {
        tweet.in_reply_to_status_id = self.replyTweet.id_str;
    }
    tweet.user = [User currentUser];
    tweet.text = self.postText.text;
    [[TwitterClient sharedInstance] postTweet:tweet withCompletion:^(NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Yikes!" message:error.description delegate:nil cancelButtonTitle:@"Try again" otherButtonTitles:nil] show];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (IBAction)textChanged:(id)sender {
    self.barButtonCount.text = [NSString stringWithFormat:@"%lu",(unsigned long) self.postText.text.length];
    if (self.postText.text.length < 100) {
        [self.barButtonCount setTextColor:[UIColor colorWithRed:27 green:222 blue:125 alpha:255]];
    } else if (self.postText.text.length < 130) {
        [self.barButtonCount setTextColor:[UIColor colorWithRed:230 green:146 blue:63 alpha:255]];
    } else {
        [self.barButtonCount setTextColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:255]];
    }
}

- (IBAction)cancelTap:(UIGestureRecognizer *)sender {
    [self removeAnimate];
}

-(void)showInView:(UIView *)parentView animated:(BOOL)animated {
    self.view.frame = parentView.frame;
    [parentView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}

-(void)replyToTweet:(id)tweet {
    self.replyTweet = tweet;
    self.postButton.titleLabel.text = @"Reply";
}

@end
