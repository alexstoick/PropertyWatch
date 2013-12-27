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
    UITableViewCell * cell ;
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"PropertyTableCell" forIndexPath:indexPath];
    
    Property * currentProperty = [[PropertyDataSource getInstance].propertyList objectAtIndex:indexPath.row] ;
    
    cell.textLabel.text = currentProperty.address;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    UIView * accesoryView = [self.tableView cellForRowAtIndexPath:indexPath].accessoryView ;
    [[self.tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor greenColor]];
    
    CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:@"My message"];
    popTipView.animation = CMPopTipAnimationPop;
    [popTipView presentPointingAtView:accesoryView inView:self.view animated:YES];
}
@end
