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
@property (weak, nonatomic) IBOutlet UITextField *postText;
@property (strong, nonatomic) UILabel *barButtonCount;
- (IBAction)textChanged:(id)sender;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Post Tweet";
    [self.profilePic setImageWithURL:[NSURL URLWithString:[User currentUser].profile_image_url]];
    self.userName.text = [NSString stringWithFormat:@"%@ says:", [User currentUser].name];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(onPost)];
    //self.barButtonCount = [[UILabel alloc] init];
    self.barButtonCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    UIView *barButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)  ];
    [barButtonView addSubview:self.barButtonCount];
    [self textChanged:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButtonView];
}

-(void)onPost {
    if (self.postText.text.length > 140) {
        // flash the barButtonItem
        return;
    }
    Tweet *tweet = [[Tweet alloc] init];
    tweet.user = [User currentUser];
    tweet.text = self.postText.text;
    [[TwitterClient sharedInstance] postTweet:tweet];
    [self.navigationController popViewControllerAnimated:YES];
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

@end
