//
//  ZoneEditController.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/29/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "ZoneEditController.h"

@implementation ZoneEditController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self configureBedroomSlider];
    [self configureRentSlider] ;
}

-(void) configureRentSlider
{

    [self.rentSlider setMinimumValue:0];
    [self.rentSlider setMaximumValue:5000] ;
    [self.rentSlider setLowerValue:0 upperValue:5000 animated:YES];
}

- (void) configureBedroomSlider
{
    self.bedroomSlider.stepValue = 1;
    self.bedroomSlider.stepValueContinuously = YES;
    [self.bedroomSlider setMaximumValue:10];
    [self.bedroomSlider setMinimumValue:1];
    [self.bedroomSlider setLowerValue:1 upperValue:10 animated:YES] ;
}

- (IBAction)bedroomSliderChanged:(id)sender {
    
    self.bedroomLabel.text = [NSString stringWithFormat:@"Number of bedrooms: %.0f - %.0f" ,
                              [self.bedroomSlider lowerValue] ,
                              [self.bedroomSlider upperValue] ] ;
    NSLog ( @"%f %f" , [self.bedroomSlider lowerValue] , [self.bedroomSlider upperValue] ) ;
    
}
- (IBAction)rentSliderChanged:(id)sender {
    
    self.rentLabel.text = [NSString stringWithFormat:@"Rent a week: %.0f - %.0f" ,
                           [self.rentSlider lowerValue] ,
                           [self.rentSlider upperValue] ] ;
    NSLog ( @"%f %f" , [self.rentSlider lowerValue] , [self.rentSlider upperValue] ) ;
    
}

- (IBAction)submitButtonPressed:(id)sender {
    
    // need to add current values to the zones
    
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                NSLog(@"going back to main view") ;
                             }
     ];
}

@end
