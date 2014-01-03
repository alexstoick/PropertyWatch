//
//  ZoneDataSource.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/30/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "ZoneDataSource.h"
#import "Zone.h"
#import "AFNetworking.h"
#import "ProgressHUD.h"

static ZoneDataSource * _zoneDataSource ;

@interface ZoneDataSource()

@property (strong,nonatomic) AFHTTPRequestOperationManager * manager ;

@end

@implementation ZoneDataSource

+(ZoneDataSource *) getInstance {
    
    if ( ! _zoneDataSource )
    {
        _zoneDataSource = [[ZoneDataSource alloc] init];
    }
    return _zoneDataSource ;
    
}

-(AFHTTPRequestOperationManager * ) manager {
    if ( ! _manager )
    {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager ;
}

-(void) parseZoneListWithCompletion:(void (^)(BOOL))completionBlock
{
    
    NSString * url = @"http://propertywatch.fwd.wf/user/1" ;
    
    [self.manager GET:url
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {

                  self.zones = [self transformJSONObjectToArray:[responseObject valueForKey:@"zones" ]];
                  
                  completionBlock(YES);
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog ( @"Failure in getting the user's info" );
                  completionBlock(NO);
              }
     ] ;

}

-(NSArray *) transformJSONObjectToArray:(NSArray *)zonesFromJSON
{
    NSMutableArray * zonesArray = [[NSMutableArray alloc] init];

    for ( NSDictionary * zone in zonesFromJSON ) {

        Zone * currentZone = [[Zone alloc] init];

        currentZone.id = [[zone valueForKey:@"id"] integerValue];
        currentZone.postcode = [zone valueForKey:@"postcode"] ;
        [zonesArray addObject:currentZone ] ;
    }

    return zonesArray;
}

- (void)addZone:(Zone *)newZone withCompletionBlock:(void (^)(BOOL))completionBlock {

    [ProgressHUD show:@"Sending your data over ..."];

    NSString * url = @"http://propertywatch.fwd.wf/user/1" ;

    NSDictionary * params = [NSDictionary dictionaryWithObject:newZone.postcode forKey:@"zone"] ;

    [self.manager PATCH:url
             parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    self.zones = [self transformJSONObjectToArray:[responseObject valueForKey:@"zones"] ];
                    [ProgressHUD showSuccess:@"Request completed!"];
                    completionBlock(YES);
             }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [ProgressHUD showError:@"There was an errow with the request"];
                    completionBlock(NO);
             }
    ] ;
}

- (void)deleteZoneAtIndex:(Zone *)zone withCompletionBlock:(void (^)(BOOL))completionBlock {

    NSString * url = @"http://propertywatch.fwd.wf/user/1" ;

    NSArray * keys = [ NSArray arrayWithObjects:@"zone",@"minBedrooms",@"maxBedrooms",@"minRent",@"maxRent", nil] ;
    NSArray * values = [NSArray arrayWithObjects:[NSNumber numberWithInteger:zone.id],
                         zone.min_bedrooms, zone.max_bedrooms , zone.min_rent, zone.max_rent , nil ] ;
    NSDictionary * params = [NSDictionary dictionaryWithObject:values forKey:keys] ;

    [ProgressHUD show:@"Sending your data over ..."];

    [self.manager DELETE:url
              parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     self.zones = [self transformJSONObjectToArray:[responseObject valueForKey:@"zones"]];
                     [ProgressHUD showSuccess:@"Request completed!"];
                     completionBlock(YES);
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     [ProgressHUD showError:@"There was an errow with the request"];
                     completionBlock(NO);
                 }
    ];
}
@end
