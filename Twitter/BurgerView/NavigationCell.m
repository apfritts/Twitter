//
//  NavigationCell.m
//  Twitter
//
//  Created by AP Fritts on 2/28/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "NavigationCell.h"
#import <FontAwesome+iOS/NSString+FontAwesome.h>
#import <FontAwesome+iOS/UIFont+FontAwesome.h>

@interface NavigationCell()

@property (weak, nonatomic) IBOutlet UILabel *itemIcon;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

@end

@implementation NavigationCell

-(void)setItemIcon:(NSString *)icon andTitle:(NSString *)title {
    NSString *faIcon = [NSString fontAwesomeIconStringForIconIdentifier:icon];
    self.itemIcon.font = [UIFont fontWithName:@"FontAwesome" size:20];
    self.itemIcon.text = faIcon;
    self.itemLabel.text = title;
}

@end
