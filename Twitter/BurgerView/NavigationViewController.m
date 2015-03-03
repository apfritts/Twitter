//
//  NavigationViewController.m
//  Twitter
//
//  Created by AP Fritts on 3/1/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "NavigationViewController.h"
#import "HamburgerViewController.h"
#import "NavigationCell.h"
#import "Navigation.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <FontAwesome+iOS/NSString+FontAwesome.h>

@interface NavigationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = [User currentUser];
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", user.screen_name];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"NavigationCell" bundle:nil] forCellReuseIdentifier:@"NavigationCell"];
    self.tableView.rowHeight = 60.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NavigationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NavigationCell"];
    switch (indexPath.row) {
        case 0:
            [cell setItemIcon:FAIconHome andTitle:@"Home"];
            break;
        case 1:
            [cell setItemIcon:FAIconUser andTitle:@"Profile"];
            break;
        case 2:
            [cell setItemIcon:FAIconMicrophone andTitle:@"Mentions"];
            break;
        case 3:
            [cell setItemIcon:FAIconSignout andTitle:@"Logout"];
            break;
    }
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [Navigation navigateToHome];
            break;
        case 1:
            [Navigation navigateToProfile:nil];
            break;
        case 2: {
            [Navigation navigateToMentions];
            break;
        }
        case 3: {
            [Navigation navigateToLogin];
            return NO;
            break;
        }
    }
    [[HamburgerViewController instance] closeMenu];
    return NO;
}

@end
