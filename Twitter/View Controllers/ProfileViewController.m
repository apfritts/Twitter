//
//  ProfileViewController.m
//  Twitter
//
//  Created by AP Fritts on 3/1/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "ProfileViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSArray *tweets;

@end

@implementation ProfileViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.user.name;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.profileBackgroundImage setImageWithURL:[NSURL URLWithString:self.user.background_image_url]];
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.user.profile_image_url]];
    self.nameLabel.text = self.user.name;
    self.followersLabel.text = [NSString stringWithFormat:@"%ld followers", self.user.followers_count];
    [self.followingLabel setText:[NSString stringWithFormat:@"Following %ld", self.user.following_count]];
    self.tweetsLabel.text = [NSString stringWithFormat:@"%ld tweets", self.user.tweets_count];
    [self setTitle:[NSString stringWithFormat:@"@%@", self.user.screen_name]];
}

-(void)updateViewWithUser:(User *)user {
    self.user = user;
    [self.user loadTweetsOlderThanId:nil withCompletion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell updateViewWithTweet:self.tweets[indexPath.row]];
    return cell;
}

@end
