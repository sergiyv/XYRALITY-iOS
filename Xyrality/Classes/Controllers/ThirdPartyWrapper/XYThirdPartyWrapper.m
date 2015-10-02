//
//  XYThirdPartyWrapper.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYThirdPartyWrapper.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@interface XYThirdPartyWrapper ()

- (void)initiateAFNetworking;

@end

@implementation XYThirdPartyWrapper

XY_SHARED_INSTANCE_IMPLEMENTATION

- (RACSignal *)initializeFrameworks {
	
	RACReplaySubject *subject = [RACReplaySubject replaySubjectWithCapacity:1];
	
	[self initiateAFNetworking];
	
	return subject;
}

- (void)initiateAFNetworking {
	
	// Enable AFNetworkActivityIndicatorManager
	AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
}

@end
