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

@property (strong,nonatomic) NSIndexPath * selectedRow ;

@end

@implementation PropertyListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedRow = nil ;
}

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
//    [cell.detailButton addTarget:self action:@selector(didSelectInformationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    Property * currentProperty = [[PropertyDataSource getInstance].propertyList objectAtIndex:indexPath.row] ;
    
    cell.textLabel.text = currentProperty.address;
    cell.descriptionLabel.text = currentProperty.rent_a_week;
    [cell.detailButton setTitle:@"i" forState:UIControlStateNormal] ;
    return cell ;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = nil ;
    PropertyTableViewCell * cell = (PropertyTableViewCell* )[tableView cellForRowAtIndexPath:indexPath] ;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    cell.descriptionLabel.hidden = YES ;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( self.selectedRow && self.selectedRow.row == indexPath.row)
    {
        //actually need to hide
        NSLog(@"uat");
        PropertyTableViewCell * cell = (PropertyTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] ;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        cell.descriptionLabel.hidden=YES;
        self.selectedRow = nil ;
        [self.tableView reloadData];
        return ;
    }
    self.selectedRow = indexPath ;
    PropertyTableViewCell * cell = (PropertyTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] ;
    cell.descriptionLabel.hidden = NO;

    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( self.selectedRow && indexPath.row == self.selectedRow.row )
    {
        return 75;
    }
    return 40 ;
}

@end
