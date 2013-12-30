//
//  Zone.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/29/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Zone : NSObject

@property (assign,nonatomic) NSInteger id ;
@property (strong,nonatomic) NSString * postcode ;
@property (assign,nonatomic) NSInteger min_bedrooms ;
@property (assign,nonatomic) NSInteger max_bedrooms ;
@property (assign,nonatomic) NSInteger min_rent ;
@property (assign,nonatomic) NSInteger max_rent ;

@end
