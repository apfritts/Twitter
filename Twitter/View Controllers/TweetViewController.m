//
//  TweetViewController.m
//  Twitter
//
//  Created by AP Fritts on 2/23/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "TweetViewController.h"
#import "TweetCell.h"
#import "ComposeViewController.h"

@interface TweetViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Tweet";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(onReplyTap)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell updateViewWithTweet:self.tweet];
    return cell;
}

-(void)onReplyTap {
    ComposeViewController *post = [[ComposeViewController alloc] init];
    [post replyToTweet:self.tweet];
    [post showPopupInViewController:self.parentViewController];
}

@end
