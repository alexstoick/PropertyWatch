//
//  PropertyTableViewCell.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/27/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "PropertyTableViewCell.h"
#import "CMPopTipView.h"

@interface PropertyTableViewCell()

@property (strong,nonatomic) CMPopTipView * popTipView;

@end

@implementation PropertyTableViewCell

- (IBAction)informationButtonPressed:(id)sender {
    
    self.popTipView = [[CMPopTipView alloc] initWithMessage:@"My message"];
    self.popTipView.animation = CMPopTipAnimationPop;
    [self.popTipView presentPointingAtView:self.detailButton inView:self.superview animated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(dismissTooltip:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void) dismissTooltip:(NSTimer*)timer
{
    [self.popTipView dismissAnimated:YES];
}

@end
