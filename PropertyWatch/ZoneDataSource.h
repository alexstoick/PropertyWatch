//
//  ZoneDataSource.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/30/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZoneDataSource : NSObject

@property (strong,nonatomic) NSArray * zones ;

+(ZoneDataSource *) getInstance ;
-(void) parseZoneListWithCompletion:(void (^)(BOOL))completionBlock;

@end
