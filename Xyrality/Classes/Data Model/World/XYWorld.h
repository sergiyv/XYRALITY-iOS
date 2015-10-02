//
//  XYWorld.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYWorld : NSObject

@property (nonatomic, retain) NSString *worldName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
