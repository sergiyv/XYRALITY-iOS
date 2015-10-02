//
//  XYHttpClient.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface XYHttpClient : AFHTTPRequestOperationManager

XY_SHARED_INSTANCE_DECLARATION

- (RACSignal *)sendRequestWithParams:(NSDictionary *)params;

@end
