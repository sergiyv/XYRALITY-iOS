//
//  XYDataManager.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYDataManager : NSObject

XY_SHARED_INSTANCE_DECLARATION

@property (nonatomic, readonly) NSMutableArray *worlds;

- (RACSignal *)acquireWorldsFromArray:(NSArray *)array;

@end
