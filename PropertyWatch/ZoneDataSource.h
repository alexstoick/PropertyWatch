//
//  ZoneDataSource.h
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/30/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Zone.h"

@interface ZoneDataSource : NSObject

@property (strong,nonatomic) NSArray * zones ;

+(ZoneDataSource *) getInstance ;
-(void) parseZoneListWithCompletion:(void (^)(BOOL))completionBlock;
-(void) addZone:(Zone *) newZone withCompletionBlock:(void(^)(BOOL))completionBlock;
-(void) deleteZoneAtIndex:(Zone *) zone withCompletionBlock:(void(^)(BOOL))completionBlock;
@end
