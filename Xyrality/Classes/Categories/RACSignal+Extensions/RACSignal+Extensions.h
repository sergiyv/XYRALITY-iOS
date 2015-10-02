//
//  RACSignal+Extensions.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "RACSignal.h"

@interface RACSignal (Extensions)

- (RACDisposable *)subscribeAny:(void (^)(id x))anyResultBlock;

@end
