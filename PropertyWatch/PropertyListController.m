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
#import "CMPopTipView.h"
#import "PropertyTableViewCell.h"

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
    [cell.detailButton addTarget:self action:@selector(didSelectInformationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    Property * currentProperty = [[PropertyDataSource getInstance].propertyList objectAtIndex:indexPath.row] ;
    
    cell.textLabel.text = currentProperty.address;
    [cell.detailButton setTitle:@"i" forState:UIControlStateNormal] ;
    
    return cell ;
}

- (void)didSelectInformationButton:(UIButton *)detailButton
{
    
    CGPoint buttonPosition = [detailButton convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    Property * currentProperty = [[PropertyDataSource getInstance].propertyList objectAtIndex:indexPath.row] ;
    CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:currentProperty.address];
    popTipView.animation = CMPopTipAnimationPop;
    
    [popTipView presentPointingAtView:detailButton inView:self.view animated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(dismissTooltip:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void) dismissTooltip:(NSTimer*)timer
{
   // [self.popTipView dismissAnimated:YES];
}


@end
