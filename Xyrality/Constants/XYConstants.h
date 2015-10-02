//
//  XYConstants.h
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

typedef enum {
    
    kXYErrorCode_UNKNOWN,
    
    kXYErrorCode_Reachability,
    kXYErrorCode_SendRequest,
    kXYErrorCode_SendRequest_NoData,
    kXYErrorCode_SendRequest_Serialization,
    kXYErrorCode_FetchData
}   XYErrorCode;
