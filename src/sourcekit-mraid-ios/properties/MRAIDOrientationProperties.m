//
//  MRAIDOrientationProperties.m
//  MRAID
//
//  Created by Jay Tucker on 9/16/13.
//  Copyright (c) 2013 Nexage, Inc. All rights reserved.
//

#import "MRAIDOrientationProperties.h"

@implementation MRAIDOrientationProperties

- (id)init
{
    self = [super init];
    if (self) {
        _allowOrientationChange = YES;
        _forceOrientation = MRAIDForceOrientationNone;
    }
    return self;
}

+ (MRAIDForceOrientation)MRAIDForceOrientationFromString:(NSString *)s
{
    NSArray *names = @[ @"portrait", @"landscape", @"none" ];
    NSUInteger i = [names indexOfObject:s];
    if (i != NSNotFound) {
        return (MRAIDForceOrientation)i;
    }
    // Use none for the default value
    return MRAIDForceOrientationNone;
}

@end
