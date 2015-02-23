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
#import "PostPopup.h"
#import "PostViewController.h"

@interface TwitterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;

@end

@implementation TwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Twitter";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(onCompose)];
    
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

/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}
 */

-(void)loadTweets {
    [[TwitterClient sharedInstance] loadTimelineSinceId:nil withCompletion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections)] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

-(void)onLogout {
    //[User setCurrentUser:nil];
    //[self.navigationController presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
}

-(void)onCompose {
    //PostPopup *popup = [[PostPopup alloc] init];
    [self.navigationController pushViewController:[[PostViewController alloc] init] animated:YES];
    //PostViewController *post = [[PostViewController alloc] init];
    //[post.view setBounds:[[UIScreen mainScreen] bounds]];
    //[post showInView:self.view animated:YES];
}

@end
