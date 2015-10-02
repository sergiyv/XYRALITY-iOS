//
//  XYWorldCell.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYCellWithObjectDelegate.h"

@class XYWorld;

@interface XYWorldCell : UITableViewCell <XYCellWithObjectDelegate>

// XYCellWithObjectDelegate
@property (nonatomic) XYWorld *object;

@end
