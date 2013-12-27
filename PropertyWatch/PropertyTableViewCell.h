//
//  PropertyTableViewCell.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/27/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

