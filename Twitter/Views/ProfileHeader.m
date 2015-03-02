//
//  ProfileHeader.m
//  Twitter
//
//  Created by AP Fritts on 3/2/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "ProfileHeader.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ProfileHeader()

@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;

@end

@implementation ProfileHeader

- (void)awakeFromNib {
    User *user = [User currentUser];
    
    [self.profileBackgroundImage setImageWithURL:[NSURL URLWithString:user.background_image_url]];
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profile_image_url]];
    self.nameLabel.text = user.name;
    self.followersLabel.text = [NSString stringWithFormat:@"%ld followers", user.followers_count];
    self.followingLabel.text = [NSString stringWithFormat:@"Following %ld", user.following_count];
    self.tweetsLabel.text = [NSString stringWithFormat:@"%ld tweets", user.tweets_count];
}

@end
