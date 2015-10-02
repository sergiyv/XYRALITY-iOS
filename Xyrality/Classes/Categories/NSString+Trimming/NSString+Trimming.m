//
//  NSString+Trimming.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "NSString+Trimming.h"

@implementation NSString (Trimming)

#pragma mark - Trimming

- (NSString *)trim {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimCharactersInString:(NSString *)string {
    
    return [self stringByTrimmingCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:string]];
}

#pragma mark - Trimming trailing characters

- (NSString *)trimTrailing {
    
    return [self trimTrailingUsingCharset:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimTrailingCharactersInString:(NSString *)string {
    
    return [self trimTrailingUsingCharset:[NSCharacterSet characterSetWithCharactersInString:string]];
}

#pragma mark - Private methods

- (NSString *)trimTrailingUsingCharset:(NSCharacterSet *)charset {
    
    NSUInteger location = 0;
    
    unichar charBuffer[self.length];
    [self getCharacters:charBuffer];
    
    NSUInteger i = self.length;
    while (i > 0 && [charset characterIsMember:charBuffer[i - 1]]) {
        
        i--;
    }
    
    return [self substringWithRange:NSMakeRange(location, i  - location)];
}

@end
