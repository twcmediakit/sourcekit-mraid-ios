//
//  MRAIDParser.h
//  MRAID
//
//  Created by Jay Tucker on 9/13/13.
//  Copyright (c) 2013 Nexage, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRAIDView;

// A parser class which validates MRAID commands passed from the creative to the native methods.
// This takes a commandUrl of type "mraid://command?param1=val1&param2=val2&..." and return a
// dictionary of key/value pairs which include command name and all the parameters. It checks
// if the command itself is a valid MRAID command and also a simpler parameters validation.
@interface MRAIDParser : NSObject

- (NSDictionary *)parseCommandUrl:(NSString *)commandUrl;

@end
