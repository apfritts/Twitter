//
//  TweetViewController.m
//  Twitter
//
//  Created by AP Fritts on 2/23/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "TweetViewController.h"
#import "TweetCell.h"

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
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell updateViewWithTweet:self.tweet];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // @TODO: This needs to NOT be here!
    return 150.0f;
}

@end
