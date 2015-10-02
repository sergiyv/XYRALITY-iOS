//
//  XYSharedInstanceMacros.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XY_SHARED_INSTANCE_DECLARATION    \
    + (instancetype)sharedInstance;

#define XY_SHARED_INSTANCE_IMPLEMENTATION \
    + (instancetype)sharedInstance {      \
                                          \
        static id sharedInstance;         \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{      \
                                          \
            sharedInstance = [self new];  \
                                                                                        \
_Pragma ("clang diagnostic push")                                                       \
_Pragma ("clang diagnostic ignored \"-Wundeclared-selector\"")                          \
            if ([sharedInstance respondsToSelector:@selector(initializeInstance)]) {    \
                                                                                        \
                [sharedInstance performSelector:@selector(initializeInstance)];         \
            }                                                                           \
_Pragma ("clang diagnostic pop")                                                        \
                                                                                        \
        });                               \
        return sharedInstance;            \
    }
