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

static PropertyDataSource * _propertyDataSource;

@interface PropertyDataSource()

@property (strong,nonatomic) AFHTTPRequestOperationManager * manager ;

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

-(void)parsePropertyListWithCompletion:(void (^)(BOOL))completionBlock
{
    
    if ( [self.propertyList count] )
    {
        completionBlock(YES);
        return;
    }
    
    NSArray * keys = [NSArray arrayWithObjects: @"postcode" ,
                      @"api_key", @"listing_status" , @"page_size" , nil];
    NSArray * values = [NSArray arrayWithObjects: @"WC1", @"4axhtay3kpj7y4397k2nb6a4" ,
                        @"rent" , @"10" , nil] ;
    NSDictionary * params = [NSDictionary dictionaryWithObjects:values forKeys:keys];

    NSLog ( @"%@" , params ) ;
    
    NSString * url = @"http://api.zoopla.co.uk/api/v1/property_listings.json" ;
    
    url = @"http://localhost/date.json";

    [self.manager GET:url parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
                  NSMutableArray * listings = [NSMutableArray arrayWithArray:
                                               [responseObject valueForKey:@"listing"]] ;
                  
                  NSMutableArray * propertyArray = [[NSMutableArray alloc] init];
                  
                  for ( NSDictionary * property in listings) {
                      
                      Property * currentProperty = [[Property alloc] init];
                      currentProperty.thumbnail_url = [property valueForKey:@"thumbnail_url"];
                      currentProperty.address = [property valueForKey:@"displayable_address"] ;
                      currentProperty.description = [property valueForKey:@"description"];
                      currentProperty.short_description = [property valueForKey:@"short_description"];
                      currentProperty.image_url = [property valueForKey:@"image_url"];
                      currentProperty.number_of_bedrooms = [[property valueForKey:@"num_bedrooms"] integerValue];
                      currentProperty.details_url = [property valueForKey:@"details_url"];
                      currentProperty.street_name = [property valueForKey:@"street_name"];
                      currentProperty.number_of_bathrooms = [[property valueForKey:@"num_bathrooms"] integerValue];
                      
                      NSDictionary * rentalPrices = [property valueForKey:@"rental_prices" ];
                      currentProperty.rent_a_week = [[rentalPrices valueForKey:@"per_week"] integerValue];
                      
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


