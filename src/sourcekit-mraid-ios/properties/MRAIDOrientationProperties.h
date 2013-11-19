//
//  MRAIDOrientationProperties.h
//  MRAID
//
//  Created by Jay Tucker on 9/16/13.
//  Copyright (c) 2013 Nexage, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MRAIDForceOrientationPortrait,
    MRAIDForceOrientationLandscape,
    MRAIDForceOrientationNone
} MRAIDForceOrientation;

@interface MRAIDOrientationProperties : NSObject

@property (nonatomic, assign) BOOL allowOrientationChange;
@property (nonatomic, assign) MRAIDForceOrientation forceOrientation;

+ (MRAIDForceOrientation)MRAIDForceOrientationFromString:(NSString *)s;

@end
