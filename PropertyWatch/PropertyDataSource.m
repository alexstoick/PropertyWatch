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

    [self.manager GET:url parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
                  NSMutableArray * listings = [NSMutableArray arrayWithArray:
                                               [responseObject valueForKey:@"listing"]] ;
                  
                  NSMutableArray * propertyArray = [[NSMutableArray alloc] init];
                  
                  for ( NSDictionary * property in listings) {
                      
                      Property * currentProperty = [[Property alloc] init];
                      currentProperty.thumbnail = [property valueForKey:@"thumbnail_url"];
                      currentProperty.address = [property valueForKey:@"displayable_address"] ;
                      currentProperty.description = [property valueForKey:@"description"];
                      NSDictionary * rentalPrices = [property valueForKey:@"rentalPrices" ];
                      
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


