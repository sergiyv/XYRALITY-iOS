//
//  UIView+FindFirstResponder.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "UIView+FindFirstResponder.h"

@implementation UIView (FindFirstResponder)

- (UIView *)findFirstResponder {
    
    __block UIView *result = nil;
    
    if (self.isFirstResponder) {
        
        result = self;
    } else {
        
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            result = [((UIView *)obj) findFirstResponder];
            if (result) {
                
                *stop = YES;
            }
        }];
    }

    return result;
}

@end
