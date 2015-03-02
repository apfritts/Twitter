//
//  NavigationCell.m
//  Twitter
//
//  Created by AP Fritts on 2/28/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import "NavigationCell.h"

@interface NavigationCell()

@property (weak, nonatomic) IBOutlet UILabel *itemIcon;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

@end

@implementation NavigationCell

-(void)setItemIcon:(FAIcon)icon andTitle:(NSString *)title {
    self.itemIcon.font = [UIFont fontWithName:@"FontAwesome" size:20];
    self.itemIcon.text = [NSString fontAwesomeIconStringForEnum:icon];
    self.itemLabel.text = title;
}

@end
