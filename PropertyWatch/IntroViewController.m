//
//  IntroViewController.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "IntroViewController.h"
#import "PropertyDataSource.h"

@interface IntroViewController()

@property (weak, nonatomic) IBOutlet UIButton *nextScreenButton;


@end

@implementation IntroViewController

-(void)viewDidLoad
{
    [[PropertyDataSource getInstance] parsePropertyListWithCompletion:^(BOOL success) {
        NSLog ( @"got list of properties" ) ;
    }];
}

- (IBAction)submitButtonTouchDown:(id)sender {
    
    [self performSegueWithIdentifier:@"transitionToPropertyList" sender:self] ;
    
}

@end
