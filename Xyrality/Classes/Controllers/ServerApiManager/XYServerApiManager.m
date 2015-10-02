//
//  XYServerApiManager.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYServerApiManager.h"
#import "XYHTTPClient.h"
#import "XYDataManager.h"

@implementation XYServerApiManager

XY_SHARED_INSTANCE_IMPLEMENTATION

#pragma mark - Supplier requests

- (RACSignal *)apiWorldsWithParams:(NSDictionary *)params {
    
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    [[[[XYHttpClient sharedInstance] sendRequestWithParams:params
        ] flattenMap:^RACStream *(NSDictionary *response) {
        
        return [[XYDataManager sharedInstance] acquireWorldsFromArray:
                    [response objectForKey:@"allAvailableWorlds"]
                ];
    }] subscribe:subject];
    
    return subject;
}

@end
