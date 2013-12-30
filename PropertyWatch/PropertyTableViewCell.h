//
//  PropertyTableViewCell.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/27/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBedsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBathroomsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bathroomImage;
@property (weak, nonatomic) IBOutlet UIImageView *bedroomImage;


@end

