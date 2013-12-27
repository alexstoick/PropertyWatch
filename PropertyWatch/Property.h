//
//  Property.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Property : NSObject

@property (strong,nonatomic) NSString  * address;
@property (strong,nonatomic) NSString  * thumbnail_url;
@property (strong,nonatomic) NSString  * description;
@property (assign,nonatomic) NSInteger   rent_a_week;
@property (assign,nonatomic) NSInteger   number_of_bedrooms;
@property (strong,nonatomic) NSString  * short_description;
@property (strong,nonatomic) NSString  * image_url ;
@property (strong,nonatomic) NSString  * details_url ;
@property (strong,nonatomic) NSString  * street_name ;
@property (assign,nonatomic) NSInteger   number_of_bathrooms;

@end
