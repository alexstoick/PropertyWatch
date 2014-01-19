//
//  IntroViewController.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "SWTableViewCell.h"
#import "IntroViewController.h"
#import "PropertyDataSource.h"
#import "ZoneDataSource.h"
#import "OBAlert.h"
#import "PropertyListController.h"

@interface IntroViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic) BOOL connectionProblem ;
@property (strong,nonatomic) UIRefreshControl * refreshControl ;

@end

@implementation IntroViewController

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getZoneData];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setToolbarHidden:NO animated:NO];
    [self.tableView reloadData];
}

- (void)getZoneData
{
    [[ZoneDataSource getInstance] parseZoneListWithCompletion:^(BOOL success) {
        self.connectionProblem = ! success;
        if ( !self.connectionProblem && [[ZoneDataSource getInstance].zones count] == 0 )
        {
            //most likely a new user
            
            OBAlert *alert = [[OBAlert alloc] initInViewController:self];
            [alert showAlertWithText:@"It appears that you have no zones. Lets start by adding some!"
                           titleText:@"Welcome!"
                          buttonText:@"Add a zone"
                               onTap:^{
                                   [alert removeAlert];
                                   [self performSegueWithIdentifier:@"IntroViewToZoneEdit"
                                                             sender:self];
                               }];
        }
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

-(void)viewDidLoad
{

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl beginRefreshing];

    [self getZoneData];
 
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
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ddd"];
    
    if (cell == nil) {
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:
                                             [UIColor colorWithRed:1.0f
                                                             green:0.231f
                                                              blue:0.188
                                                             alpha:1.0f]
                                                    title:@"Delete"];

        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"ddd"
                                  containingTableView:self.tableView // For row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
    }
    
    Zone * currentZone = [[ZoneDataSource getInstance].zones objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentZone.postcode ;
    cell.detailTextLabel.text = @"33";
    return cell ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Zone * currentZone = [[ZoneDataSource getInstance].zones objectAtIndex:indexPath.row] ;

    [self performSegueWithIdentifier:@"IntroViewToPropertiesView" sender:currentZone];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"IntroViewToPropertiesView"] )
    {
        PropertyListController * propertyListController = [segue destinationViewController] ;
        propertyListController.currentZone = (Zone *) sender ;
        [propertyListController.activityIndicator startAnimating];
        [[PropertyDataSource getInstance] parsePropertyListForZone: propertyListController.currentZone WithCompletion:^(BOOL success) {
            [propertyListController.tableView reloadData];
            [self.refreshControl endRefreshing];

        }];
    }

}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {

    //delete button pressed

    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell] ;

    ZoneDataSource * zoneDataSource = [ZoneDataSource getInstance] ;

    [zoneDataSource deleteZoneAtIndex:[zoneDataSource.zones objectAtIndex:indexPath.row]
                  withCompletionBlock:^(BOOL success) {
                      if ( success )
                      {
                          [self.tableView reloadData];
                      }
                  }
    ];

}

@end
