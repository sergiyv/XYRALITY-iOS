//
//  XYWorld.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYWorld.h"

static NSString* const kXYWorldsName = @"name";

@implementation XYWorld

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        
        _worldName = [dictionary objectForKey:kXYWorldsName];
    }
    return self;
}

#pragma mark -

- (NSString *)description {
    
    return [NSString stringWithFormat:
            @"\n========== World =========="
            "\nName: %@",
            _worldName
            ];
}

@end
