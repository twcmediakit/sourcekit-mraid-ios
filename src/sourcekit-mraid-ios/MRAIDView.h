//
//  MRAIDView.h
//  MRAID
//
//  Created by Jay Tucker on 9/13/13.
//  Copyright (c) 2013 Nexage, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRAIDView;
@protocol MRAIDServiceDelegate;

// A delegate for MRAIDView to listen for notification on ad ready or expand related events.
@protocol MRAIDViewDelegate <NSObject>

@optional

// These callbacks are for basic banner ad functionality.
- (void)mraidViewAdReady:(MRAIDView *)mraidView;
- (void)mraidViewAdFailed:(MRAIDView *)mraidView;
- (void)mraidViewWillExpand:(MRAIDView *)mraidView;
- (void)mraidViewDidClose:(MRAIDView *)mraidView;
- (void)mraidViewDidResize:(MRAIDView *)mraidView;

// This callback is to ask permission to resize an ad.
- (BOOL)mraidViewShouldResize:(MRAIDView *)mraidView toPosition:(CGRect)position allowOffscreen:(BOOL)allowOffscreen;

@end

@interface MRAIDView : UIView

@property (nonatomic, unsafe_unretained) id<MRAIDViewDelegate> delegate;
@property (nonatomic, unsafe_unretained) id<MRAIDServiceDelegate> serviceDelegate;
@property (nonatomic, unsafe_unretained) UIViewController *rootViewController;
@property (nonatomic, assign, getter = isViewable, setter = setIsViewable:) BOOL isViewable;

// IMPORTANT: This is the only valid initializer for an MRAIDView; -init and -initWithFrame: will throw exceptions
- (id)initWithFrame:(CGRect)frame
       withHtmlData:(NSString*)htmlData
        withBaseURL:(NSURL*)bsURL
  supportedFeatures:(NSArray *)features
           delegate:(id<MRAIDViewDelegate>)delegate
   serviceDelegate:(id<MRAIDServiceDelegate>)serviceDelegate
 rootViewController:(UIViewController *)rootViewController;

@end
