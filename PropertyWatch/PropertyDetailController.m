//
//  PropertyDetailController.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/27/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "PropertyDetailController.h"
#import "UIImageView+AFNetworking.h"
#import "MapViewController.h"

@interface PropertyDetailController()

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *bedroomImage;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBedroomsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bathroomImage;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBathroomsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addressImage;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *priceImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UITableViewCell *descriptionTableCell;
@property (strong, nonatomic) IBOutlet UITableView *detailTable;


@property (weak, nonatomic) IBOutlet UILabel *agentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *agentPhoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;


@end

@implementation PropertyDetailController

-(void)viewDidLoad
{
    
    Property * currentProperty = self.currentProperty;
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:currentProperty.image_url]];
    
    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Accept"];
    
    [self.mainImage setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"blank"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           self.mainImage.image = image;
                                       }
                                       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                           NSLog(@"Error for image processing: %@" , error);
                                       }];
    self.priceLabel.text = [NSString stringWithFormat:@"%d£" , currentProperty.rent_a_week];
    self.addressLabel.text = currentProperty.address;
    self.agentNameLabel.text = currentProperty.agentName ;
    self.agentPhoneLabel.text = currentProperty.agentPhoneNo ;
    
    if ( currentProperty.number_of_bathrooms != 0 )
        self.numberOfBathroomsLabel.text = [NSString stringWithFormat:@"%d" , currentProperty.number_of_bathrooms];
    else
    {
        self.bathroomImage.hidden=YES;
        self.numberOfBathroomsLabel.hidden=YES;
    }
    
    if ( currentProperty.number_of_bedrooms != 0 )
    {
        self.numberOfBedroomsLabel.text = [NSString stringWithFormat:@"%d" , currentProperty.number_of_bedrooms];
    }
    else
    {
        self.bedroomImage.hidden = YES;
        self.numberOfBedroomsLabel.hidden = YES ;
    }
    
    self.descriptionText.text = currentProperty.description ;
    self.descriptionText.scrollEnabled = NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section == 3 && indexPath.row == 1 )
    {
        NSString * phoneNumber =
            [self.currentProperty.agentPhoneNo stringByReplacingOccurrencesOfString:@" " withString:@""];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0: return 231; break ;
        case 1: {
            if ( indexPath.row == 0 )
            {
                //check if the bedroom sign is enabled
                if ( self.bedroomImage.hidden )
                {
                    return 0 ;
                }
            }
            if ( indexPath.row == 1 )
            {
                //check if have the bathroom sign enabled
                if ( self.bathroomImage.hidden )
                {
                    return 0 ;
                }
            }
            if ( indexPath.row == 3 )
            {
                //make it large enough to fit the address bar
                CGSize textViewSize = [self.addressLabel sizeThatFits:CGSizeMake(self.addressLabel.frame.size.width, FLT_MAX)];
                CGRect newFrame = self.addressLabel.frame ;
                newFrame.size = textViewSize ;
                [self.addressLabel setFrame:newFrame];
                if ( textViewSize.height < 44 )
                    return 64 ;
                else
                    return textViewSize.height +20 ;
            }
            return 44 ; break ;

        }
        case 2: {
            CGSize textViewSize = [self.descriptionText sizeThatFits:CGSizeMake(self.descriptionText.frame.size.width, FLT_MAX)];
            CGRect newFrame = self.descriptionText.frame ;
            newFrame.size = textViewSize ;
            [self.descriptionText setFrame:newFrame];
            return textViewSize.height ;
        }
    }
    return 44 ;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"PropertyDetailToMapView" ] )
    {
        MapViewController * mapView = segue.destinationViewController ;
        mapView.currentProperty = self.currentProperty ;
    }
    
}



@end
