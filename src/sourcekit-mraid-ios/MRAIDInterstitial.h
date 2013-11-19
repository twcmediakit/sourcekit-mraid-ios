//
//  MRAIDInterstitial.h
//  MRAID
//
//  Created by Jay Tucker on 10/18/13.
//  Copyright (c) 2013 Nexage, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class MRAIDInterstitial;
@protocol MRAIDServiceDelegate;

// A delegate for MRAIDInterstitial to handle callbacks for the interstitial lifecycle.
@protocol MRAIDInterstitialDelegate <NSObject>

@optional

- (void)mraidInterstitialAdReady:(MRAIDInterstitial *)mraidInterstitial;
- (void)mraidInterstitialAdFailed:(MRAIDInterstitial *)mraidInterstitial;
- (void)mraidInterstitialWillShow:(MRAIDInterstitial *)mraidInterstitial;
- (void)mraidInterstitialDidHide:(MRAIDInterstitial *)mraidInterstitial;

@end

// A class which handles interstitials and offers optional callbacks for its states and services (sms, tel, calendar, etc.)
@interface MRAIDInterstitial : NSObject

@property (nonatomic, unsafe_unretained) id<MRAIDInterstitialDelegate> delegate;
@property (nonatomic, unsafe_unretained) id<MRAIDServiceDelegate> serviceDelegate;
@property (nonatomic, unsafe_unretained) UIViewController *rootViewController;
@property (nonatomic, assign, getter = isViewable, setter = setIsViewable:) BOOL isViewable;

// IMPORTANT: This is the only valid initializer for an MRAIDInterstitial; -init will throw an exception
- (id)initWithSupportedFeatures:(NSArray *)features
                   withHtmlData:(NSString*)htmlData
                    withBaseURL:(NSURL*)bsURL
                       delegate:(id<MRAIDInterstitialDelegate>)delegate
               serviceDelegate:(id<MRAIDServiceDelegate>)serviceDelegate
             rootViewController:(UIViewController *)rootViewController;

- (void)show;

@end
