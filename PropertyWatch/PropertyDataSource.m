//
//  PropertyDataSource.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "PropertyDataSource.h"
#import "AFNetworking.h"
#import "Property.h"
#import "Zone.h"

static PropertyDataSource * _propertyDataSource;
static NSString const *RailsBaseUrl = @"http://146.185.140.148";

@interface PropertyDataSource()

@property (strong,nonatomic) AFHTTPRequestOperationManager * manager ;
@property (assign,nonatomic) NSInteger dataForZone ;

@end

@implementation PropertyDataSource

+(PropertyDataSource*)getInstance
{
    if ( !_propertyDataSource )
    {
        _propertyDataSource = [[PropertyDataSource alloc] init];
    }
    
    return _propertyDataSource ;
    
}

-(AFHTTPRequestOperationManager*) manager {
    if ( ! _manager )
    {
        _manager = [AFHTTPRequestOperationManager manager] ;
    }
    return _manager ;
}

-(void)parsePropertyListForZone:(Zone *) zone WithCompletion:(void (^)(BOOL))completionBlock
{
    
    if ( self.dataForZone == zone.identifier)
    {
        completionBlock(YES);
        return;
    }

    self.dataForZone = zone.identifier;
    
    NSArray * keys = [NSArray arrayWithObjects: @"postcode" ,
                      @"api_key", @"listing_status" , @"page_size" , nil];
    NSArray * values = [NSArray arrayWithObjects: @"WC1", @"4axhtay3kpj7y4397k2nb6a4" ,
                        @"rent" , @"10" , nil] ;
    NSDictionary * params = [NSDictionary dictionaryWithObjects:values forKeys:keys];

    NSString * url = [NSString stringWithFormat:@"%@/zone/%d/properties",
                                                RailsBaseUrl , zone.identifier ];

    NSLog ( @"%@" , url ) ;
    self.propertyList = nil ;
    [self.manager GET:url parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
                  NSMutableArray * listings = [NSMutableArray arrayWithArray:
                                               [responseObject valueForKey:@"properties"]] ;
                  
                  NSMutableArray * propertyArray = [[NSMutableArray alloc] init];
                  
                  for ( NSDictionary * property in listings) {
                      
                      Property * currentProperty = [[Property alloc] init];
                      /* Images */
                      currentProperty.thumbnail_url = [property valueForKey:@"thumbnailUrl"];
                      currentProperty.image_url = [property valueForKey:@"imageUrl"];

                      /* Address info */
                      currentProperty.address = [property valueForKey:@"address"] ;
                      currentProperty.street_name = [property valueForKey:@"streetName"];

                      /* Description */
                      currentProperty.description = [property valueForKey:@"description"];
                      currentProperty.short_description = [property valueForKey:@"shortDescription"];

                      /* Agent info */
                      currentProperty.agentName = [property valueForKey:@"agentName"];
                      currentProperty.agentPhoneNo = [property valueForKey:@"agentPhoneNo"];

                      /* House info */
                      currentProperty.number_of_bedrooms = [[property valueForKey:@"number_of_bedrooms"] integerValue];
                      currentProperty.number_of_bathrooms = [[property valueForKey:@"number_of_bathrooms"] integerValue];
                      currentProperty.rent_a_week = [[property valueForKey:@"rent_a_week"] integerValue];

                      /* Location info */
                      currentProperty.longitude = [[property valueForKey:@"longtitude"] floatValue] ;
                      currentProperty.latitude = [[property valueForKey:@"latitude"] floatValue];

                      /* Additional info */
                      currentProperty.details_url = [property valueForKey:@"detailsUrl"];

                      [propertyArray addObject:currentProperty];
                  }
                  
                  self.propertyList = propertyArray;
                  completionBlock(YES);
                  
           }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog ( @"Error : %@" , error ) ;
                  NSLog ( @"%@" , operation ) ;
                  completionBlock(NO);
           }
     ] ;
}

@end


