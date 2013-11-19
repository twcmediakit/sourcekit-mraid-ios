//
//  MRAIDResizeProperties.h
//  MRAID
//
//  Created by Jay Tucker on 9/16/13.
//  Copyright (c) 2013 Nexage, Inc. All Rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MRAIDCustomClosePositionTopLeft,
    MRAIDCustomClosePositionTopCenter,
    MRAIDCustomClosePositionTopRight,
    MRAIDCustomClosePositionCenter,
    MRAIDCustomClosePositionBottomLeft,
    MRAIDCustomClosePositionBottomCenter,
    MRAIDCustomClosePositionBottomRight
} MRAIDCustomClosePosition;

@interface MRAIDResizeProperties : NSObject

@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) int offsetX;
@property (nonatomic, assign) int offsetY;
@property (nonatomic, assign) MRAIDCustomClosePosition customClosePosition;
@property (nonatomic, assign) BOOL allowOffscreen;

+ (MRAIDCustomClosePosition)MRAIDCustomClosePositionFromString:(NSString *)s;

@end
