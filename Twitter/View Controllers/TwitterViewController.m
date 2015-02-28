//
//  TwitterViewController.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "TwitterViewController.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetCell.h"
#import "PostViewController.h"
#import "TweetViewController.h"
#import <FontAwesome+iOS/UIImage+FontAwesome.h>

@interface TwitterViewController () <UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIView *worstInternetBackground;
@property (weak, nonatomic) IBOutlet UIView *worstInternetForeground;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *worstInternetFinding;

@end

@implementation TwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.worstInternetForeground.layer.cornerRadius = 5;
    
    self.title = @"Twitter";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(onCompose)];
    UIImage *tweetIcon = [UIImage imageWithIcon:@"twitter" backgroundColor:[UIColor colorWithWhite:1 alpha:0] iconColor:[UIColor colorWithRed:85 green:172 blue:238 alpha:1.0f] iconScale:1.0f andSize:CGSizeMake(30.0f, 30.0f)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:tweetIcon style:UIBarButtonItemStylePlain target:self action:@selector(onCompose)];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    [self loadTweets];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell updateViewWithTweet:self.tweets[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetViewController *tvc = [[TweetViewController alloc] init];
    TweetCell *cell = (TweetCell *)[tableView cellForRowAtIndexPath:indexPath];
    tvc.tweet = [cell getTweet];
    [self.navigationController pushViewController:tvc animated:YES];
}

-(void)loadTweets {
    [[TwitterClient sharedInstance] loadTimelineSinceId:nil withCompletion:^(NSArray *tweets, NSError *error) {
        [self.refreshControl endRefreshing];
        if (error) {
            self.worstInternetBackground.hidden = NO;
            self.worstInternetForeground.hidden = NO;
            [self.worstInternetFinding startAnimating];
            [UIView animateWithDuration:0.25 animations:^{
                self.tableView.alpha = 0.25f;
                self.worstInternetBackground.alpha = 0.25f;
                self.worstInternetForeground.alpha = 1.0f;
            }];
        } else {
        self.tweets = tweets;
            [self.tableView reloadData];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections)] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
}

-(void)onLogout {
    [User setCurrentUser:nil];
    [self.navigationController presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
}

-(void)onCompose {
    PostViewController *post = [[PostViewController alloc] init];
    [post showPopupInViewController:self.parentViewController];
}

-(void)replyToTweet:(Tweet *)tweet {
    PostViewController *post = [[PostViewController alloc] init];
    [post replyToTweet:tweet];
    [post showPopupInViewController:self.parentViewController];
}

@end
