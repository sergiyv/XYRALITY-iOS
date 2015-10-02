//
//  XYHttpClient.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYHttpClient.h"
#import "XYApiUrls.h"

@implementation XYHttpClient

XY_SHARED_INSTANCE_IMPLEMENTATION

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL: (url ? : [NSURL URLWithString:XYApiUrls.baseUrl])];
    if (self) {
        
        [self.operationQueue setMaxConcurrentOperationCount:2];
        self.responseSerializer =
            (AFHTTPResponseSerializer<AFURLResponseSerialization> *)[AFPropertyListResponseSerializer serializer];
        [self.securityPolicy setAllowInvalidCertificates:YES];
    }
    return self;
}

#pragma mark - Private methods

- (RACSignal *)sendRequestWithParams:(NSDictionary *)params {
    
    RACReplaySubject *subject = [RACReplaySubject replaySubjectWithCapacity:1];
    
    NSError *error;
    
    NSMutableURLRequest *request =
        [self.requestSerializer requestWithMethod:@"POST"
                                        URLString:XYApiUrls.baseUrl
                                       parameters:params
                                            error:&error
         ];
    if (error) {
        
        [subject sendError:error];
    } else {
        
        request.timeoutInterval = 20.;
        
        AFHTTPRequestOperation *operation =
            [self HTTPRequestOperationWithRequest:request
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {}
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {}
             ];
        
        [[self rac_enqueueHTTPRequestOperation:operation] subscribeNext:^(id response) {
            
            DLog(@"%@", response);
            
            if (!response) {
                
                NSError *error = [NSError errorWithDomain:XY_ERROR_DOMAIN
                                                     code:kXYErrorCode_SendRequest_NoData
                                                 userInfo:@{ NSLocalizedDescriptionKey:
                                                                 NSLocalizedString(@"Response is empty.", nil) }];
                [subject sendError:error];
            } else {
                
                [subject sendNext:response];
                [subject sendCompleted];
            }
        } error:^(NSError *error) {
            
            [subject sendError:error];
        }];
    }
    
    return subject;
}

- (RACSignal *)checkReachability {
    
    RACReplaySubject *subject = [RACReplaySubject replaySubjectWithCapacity:1];
    
    [self.networkReachabilityStatusSignal subscribeNext:^(NSNumber *status) {
        AFNetworkReachabilityStatus networkStatus = [status intValue];
        switch (networkStatus) {
//            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable: {
                
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain
                                                     code:kXYErrorCode_Reachability
                                                 userInfo:@{ NSLocalizedDescriptionKey:
                                                                 NSLocalizedString(@"Server is not reachable.", nil) }];
                [subject sendError:error];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                
                BOOL isWiFi = networkStatus == AFNetworkReachabilityStatusReachableViaWiFi;
                [subject sendNext:@(isWiFi)];
                [subject sendCompleted];
            }
                break;
                
            default:
                [subject sendNext:nil];
                [subject sendCompleted];
                break;
        }
    }];
    
    return subject;
}

@end
