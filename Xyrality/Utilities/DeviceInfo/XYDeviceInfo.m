//
//  XYDeviceInfo.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYDeviceInfo.h"

@implementation XYDeviceInfo

+ (NSString *)deviceType {
    
    return
        [NSString stringWithFormat:@"%@ - %@ %@",
            [[UIDevice currentDevice] model        ],
            [[UIDevice currentDevice] systemName   ],
            [[UIDevice currentDevice] systemVersion]
         ];
}

+ (NSString *)deviceId {
    
    NSString *uniqueIdentifier;
    
    if( [UIDevice instancesRespondToSelector:@selector(identifierForVendor)] ) { // iOS version >= 7
        
        uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else {
        
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        uniqueIdentifier = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
        CFRelease(uuid);
    }
    
    return uniqueIdentifier;
}

@end
