//
//  XYServerApiManager.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYServerApiManager : NSObject

XY_SHARED_INSTANCE_DECLARATION

- (RACSignal *)apiWorldsWithParams:(NSDictionary *)params;

@end
