//
//  MRAIDModalViewController.h
//  MRAID
//
//  Created by Jay Tucker on 9/20/13.
//  Copyright (c) 2013 Nexage, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRAIDModalViewController;
@class MRAIDOrientationProperties;

@protocol MRAIDModalViewControllerDelegate <NSObject>

- (void)mraidModalViewControllerDidRotate:(MRAIDModalViewController *)modalViewController;

@end

@interface MRAIDModalViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<MRAIDModalViewControllerDelegate> delegate;

- (id)initWithOrientationProperties:(MRAIDOrientationProperties *)orientationProperties;
- (void)forceToOrientation:(MRAIDOrientationProperties *)orientationProperties;

@end
