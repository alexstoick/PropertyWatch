//
//  IntroViewController.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "IntroViewController.h"
#import "PropertyDataSource.h"
#import "AFNetworking.h"
#import "Zone.h"
#import "ZoneDataSource.h"

@interface IntroViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (assign,nonatomic) BOOL connectionProblem ;

@end

@implementation IntroViewController



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setToolbarHidden:NO animated:NO];
}

-(void)viewDidLoad
{
    
    [[PropertyDataSource getInstance] parsePropertyListWithCompletion:^(BOOL success) {
        NSLog ( @"got list of properties" ) ;
    }];
    
    [[ZoneDataSource getInstance] parseZoneListWithCompletion:^(BOOL success) {
        self.connectionProblem = ! success;
        [self.tableView reloadData];
        [self.activityIndicator stopAnimating];
    }];
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( self.connectionProblem )
        return 1;
    return [[ZoneDataSource getInstance].zones count] ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( self.connectionProblem )
    {
        UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"connectionProblemTableCell"] ;
        return cell ;
    }
    
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"basicTableCell" ] ;
    
    Zone * currentZone = [[ZoneDataSource getInstance].zones objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentZone.postcode ;
    return cell ;
    
}

@end
