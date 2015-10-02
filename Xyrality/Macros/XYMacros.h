//
//  XYMacros.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#define XYKeypathString(...) \
	[NSString stringWithUTF8String:keypath(__VA_ARGS__)]

// Errors
#define XY_ERROR_DOMAIN @"com.brightgrove.Xyrality"
