//
//  XYWorldCell.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYWorldCell.h"
#import "XYWorld.h"

@implementation XYWorldCell

- (void)setObject:(XYWorld *)object {
    
    _object = object;
    
    self.textLabel.text = object.worldName;
}

@end
