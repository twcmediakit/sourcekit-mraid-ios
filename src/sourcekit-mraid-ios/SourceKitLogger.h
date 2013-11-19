//
//  SourceKitLogger.h
//  SourceKit
//
//  Created by Tom Poland on 9/24/13.
//  Copyright 2013 Nexage Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SourceKitLogLevelNone,
    SourceKitLogLevelError,
    SourceKitLogLevelWarning,
    SourceKitLogLevelInfo,
    SourceKitLogLevelDebug,
} SourceKitLogLevel;

// A simple logger enable you to see different levels of logging.
// Use logLevel as a filter to see the messages for the specific level.
//
@interface SourceKitLogger : NSObject

// Method to filter logging with the level passed as the paramter
+ (void)setLogLevel:(SourceKitLogLevel)logLevel;

+ (void)error:(NSString *)message;
+ (void)warning:(NSString *)message;
+ (void)info:(NSString *)message;
+ (void)debug:(NSString *)message;

@end
