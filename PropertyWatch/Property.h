//
//  Property.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Property : NSObject

@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *thumbnail;
@property (strong,nonatomic) NSString *description;

@end
