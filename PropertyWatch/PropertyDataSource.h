//
//  PropertyDataSource.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Zone.h"

@interface PropertyDataSource : NSObject

+(PropertyDataSource*)getInstance;

@property (strong,nonatomic) NSArray * propertyList ;

-(void)parsePropertyListForZone:(Zone *) zone WithCompletion:(void (^)(BOOL))completionBlock;

@end
