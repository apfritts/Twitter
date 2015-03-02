//
//  NavigationCell.h
//  Twitter
//
//  Created by AP Fritts on 2/28/15.
//  Copyright (c) 2015 AP Fritts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FontAwesome+iOS/NSString+FontAwesome.h>

@interface NavigationCell : UITableViewCell

-(void)setItemIcon:(FAIcon)icon andTitle:(NSString *)title;

@end
