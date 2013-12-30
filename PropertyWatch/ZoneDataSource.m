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

    NSString * url = @"http://propertywatch.fwd.wf/user/1" ;

    NSDictionary * params = [NSDictionary dictionaryWithObject:newZone.postcode forKey:@"zone"] ;

    [self.manager PATCH:url
             parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    self.zones = [self transformJSONObjectToArray:[responseObject valueForKey:@"zones"] ];
                    completionBlock(YES);
             }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    completionBlock(NO);
             }
    ] ;

}
@end
