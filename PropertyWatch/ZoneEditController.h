//
//  ZoneEditController.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/29/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"

@interface ZoneEditController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NMRangeSlider *bedroomSlider;
@property (weak, nonatomic) IBOutlet UILabel *bedroomLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentLabel;
@property (weak, nonatomic) IBOutlet NMRangeSlider *rentSlider;
@property (weak, nonatomic) IBOutlet UITextField *postcodeTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitButton;

@end
