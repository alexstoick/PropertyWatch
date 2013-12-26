//
//  PropertyListController.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "PropertyListController.h"
#import "PropertyDataSource.h"

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

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"pubListTableCell";
//    PubTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    Pub * currentPub = [PubListDataSource getInstance].pubList[indexPath.row] ;
//    
//    cell.titleLabel.text = currentPub.name ;
//    
//    return cell;
//}

@end
