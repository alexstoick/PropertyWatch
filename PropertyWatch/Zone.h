//
//  Zone.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/29/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Zone : NSObject

@property (assign,nonatomic) NSInteger identifier;
@property (strong,nonatomic) NSString * postcode ;
@property (strong,nonatomic) NSNumber * min_bedrooms ;
@property (strong,nonatomic) NSNumber * max_bedrooms ;
@property (strong,nonatomic) NSNumber * min_rent ;
@property (strong,nonatomic) NSNumber * max_rent ;

@end
