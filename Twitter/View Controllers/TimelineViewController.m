//
//  TwitterViewController.m
//  Twitter
//
//  Created by AP Fritts on 2/18/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "ComposeViewController.h"
#import "ProfileViewController.h"
#import "TweetViewController.h"
#import <FontAwesome+iOS/UIImage+FontAwesome.h>

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, TweetCellDelegate, TimelineViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIView *worstInternetBackground;
@property (weak, nonatomic) IBOutlet UIView *worstInternetForeground;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *worstInternetFinding;
@property (strong, nonatomic) id<TimelineViewControllerDelegate> completion;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.worstInternetForeground.layer.cornerRadius = 5;
    
    //self.title = @"Twitter";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(onCompose)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
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
    cell.delegate = self;
    return cell;
}

-(void)loadTweets {
    if (self.loadTweetsHandler != nil) {
        self.loadTweetsHandler(self);
    }
}

-(void)onCompose {
    ComposeViewController *post = [[ComposeViewController alloc] init];
    [post showPopupInViewController:self.parentViewController];
}

-(void)replyToTweet:(Tweet *)tweet {
    ComposeViewController *post = [[ComposeViewController alloc] init];
    [post replyToTweet:tweet];
    [post showPopupInViewController:self.parentViewController];
}

-(void)loadTweets:(NSArray *)tweets {
    [self.refreshControl endRefreshing];
    /*
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
        */
        self.tweets = tweets;
        [self.tableView reloadData];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections)] withRowAnimation:UITableViewRowAnimationAutomatic];
    //}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetViewController *tvc = [[TweetViewController alloc] init];
    TweetCell *cell = (TweetCell *)[tableView cellForRowAtIndexPath:indexPath];
    tvc.tweet = [cell getTweet];
    [self.navigationController pushViewController:tvc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)didTapUser:(Tweet *)tweet {
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [profile updateViewWithUser:tweet.user];
    [self.navigationController pushViewController:profile animated:YES];
}

@end
