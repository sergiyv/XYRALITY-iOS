//
//  RACSignal+Extensions.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "RACSignal+Extensions.h"

@implementation RACSignal (Extensions)

- (RACDisposable *)subscribeAny:(void (^)(id x))anyResultBlock {
	
	NSCParameterAssert(anyResultBlock != NULL);
	
	return [self subscribeNext:anyResultBlock error:anyResultBlock];
}

@end
