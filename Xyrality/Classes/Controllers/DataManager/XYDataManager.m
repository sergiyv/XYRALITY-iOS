//
//  XYDataManager.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYDataManager.h"
#import "XYWorld.h"

@interface XYDataManager ()

@property (nonatomic) NSMutableArray *worlds;

@end

@implementation XYDataManager

XY_SHARED_INSTANCE_IMPLEMENTATION

- (RACSignal *)acquireWorldsFromArray:(NSArray *)array {
    
    RACReplaySubject *subject = [RACReplaySubject replaySubjectWithCapacity:1];
    
    self.worlds = nil;
    
    if (array.count) {
        
        self.worlds = [[NSMutableArray alloc] initWithCapacity:array.count];
        
        __block BOOL stopped = NO;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            if ([obj isKindOfClass:[NSDictionary class]] == NO) {
                
                *stop = YES;
                stopped = YES;
            } else {
                
                XYWorld *world = [[XYWorld alloc] initWithDictionary:obj];
                [self.worlds addObject:world];
            }
        }];
        
        if (stopped) {
            
            NSError *error = [NSError errorWithDomain:XY_ERROR_DOMAIN
                                                 code:kXYErrorCode_SendRequest_Serialization
                                             userInfo:@{ NSLocalizedDescriptionKey:
                                                             NSLocalizedString(@"Corrupted data", nil) }
                              ];
            [subject sendError:error];
        } else {
            
            [subject sendNext:self.worlds];
            [subject sendCompleted];
        }
    } else {
        
        NSError *error = [NSError errorWithDomain:XY_ERROR_DOMAIN
                                             code:kXYErrorCode_SendRequest_NoData
                                         userInfo:@{ NSLocalizedDescriptionKey:
                                                         NSLocalizedString(@"No data", nil) }
                          ];
        [subject sendError:error];
    }
    
    return subject;
}

@end
