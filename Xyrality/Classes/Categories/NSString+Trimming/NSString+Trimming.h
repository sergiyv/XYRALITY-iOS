//
//  NSString+Trimming.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trimming)

- (NSString *)trim;
- (NSString *)trimCharactersInString:(NSString *)string;

- (NSString *)trimTrailing;
- (NSString *)trimTrailingCharactersInString:(NSString *)string;

@end
