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

@interface IntroViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) AFHTTPRequestOperationManager * manager ;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) NSArray * zones ;

@end

@implementation IntroViewController

-(AFHTTPRequestOperationManager * ) manager {
    if ( ! _manager )
    {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager ;
}

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
    
    //load zones
    
    NSString * url = @"http://propertywatch.fwd.wf/user/1" ;
    
    [self.manager GET:url
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  NSArray * zonesFromJson = [responseObject valueForKey:@"zones" ];
                  NSMutableArray * zonesArray = [[NSMutableArray alloc] init];
                  
                  for ( NSDictionary * zone in zonesFromJson ) {
                      
                      Zone * currentZone = [[Zone alloc] init];
                      
                      currentZone.id = [[zone valueForKey:@"id"] integerValue];
                      currentZone.postcode = [zone valueForKey:@"postcode"] ;
                      
                      [zonesArray addObject:currentZone ] ;
                  }
                  
                  self.zones = zonesArray ;
                  [self.tableView reloadData];
                  [self.activityIndicator stopAnimating];
                  
                  NSLog ( @"Loaded the user's info" );
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog ( @"Failure in getting the user's info" );
              }
     ] ;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.zones count] ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"basicTableCell" ] ;
    
    Zone * currentZone = [self.zones objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentZone.postcode ;
    return cell ;
    
}

@end
