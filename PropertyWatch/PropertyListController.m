//
//  PropertyListController.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "PropertyListController.h"
#import "PropertyDataSource.h"
#import "Property.h"
#import "PropertyTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface PropertyListController()

@end

@implementation PropertyListController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog ( @"COUNT : %d" , [[PropertyDataSource getInstance].propertyList count] ) ;
    return [[PropertyDataSource getInstance].propertyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyTableViewCell * cell ;
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"PropertyTableCell" forIndexPath:indexPath];
    
    Property * currentProperty = [[PropertyDataSource getInstance].propertyList objectAtIndex:indexPath.row] ;
    
    cell.titleLabel.text = currentProperty.street_name;
    cell.priceLabel.text = [NSString stringWithFormat:@"%d£" , currentProperty.rent_a_week ];
    
    cell.numberOfBedsLabel.text = [NSString stringWithFormat:@"%d" , currentProperty.number_of_bedrooms] ;
    cell.adressLabel.text = currentProperty.address;
    if ( currentProperty.number_of_bathrooms != 0 )
        cell.numberOfBathroomsLabel.text = [NSString stringWithFormat:@"%d" , currentProperty.number_of_bathrooms];
    else
    {
        cell.bathroomImage.hidden=YES;
        cell.numberOfBathroomsLabel.hidden=YES;
    }

    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:currentProperty.image_url]];
    
    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Accept"];
    
    [cell.thumbnailView setImageWithURLRequest:request
                     placeholderImage:[UIImage imageNamed:@"blank"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                  cell.thumbnailView.image = image;
                              }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                  NSLog(@"Error for image processing: %@" , error);
                              }];
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
