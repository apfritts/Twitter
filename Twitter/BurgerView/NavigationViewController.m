//
//  NavigationViewController.m
//  Twitter
//
//  Created by AP Fritts on 3/1/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "NavigationViewController.h"
#import "User.h"
#import "NavigationCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface NavigationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = [User currentUser];
    
    [self.backgroundImage setImageWithURL:[NSURL URLWithString:user.profile_image_url]];
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profile_image_url]];
    self.nameLabel.text = user.name;
    self.followersLabel.text = [NSString stringWithFormat:@"%ld followers", (long)user.followers_count];
    self.followingLabel.text = [NSString stringWithFormat:@"following %ld", (long)user.following_count];
    self.tweetsLabel.text = [NSString stringWithFormat:@"%ld tweets", (long)user.tweets_count];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"NavigationCell" bundle:nil] forCellReuseIdentifier:@"NavigationCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = self.tableHeaderView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NavigationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NavigationCell"];
    switch (indexPath.row) {
        case 0:
            [cell setItemIcon:@"fa-settings" andTitle:@"Settings"];
            break;
        case 1:
            [cell setItemIcon:@"fa-settings" andTitle:@"Settings"];
            break;
        case 2:
            [cell setItemIcon:@"fa-settings" andTitle:@"Settings"];
            break;
        case 3:
            [cell setItemIcon:@"fa-settings" andTitle:@"Settings"];
            break;
    }
    return cell;
}

@end
