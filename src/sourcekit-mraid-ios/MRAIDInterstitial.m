//
//  MRAIDInterstitial.m
//  MRAID
//
//  Created by Jay Tucker on 10/18/13.
//  Copyright (c) 2013 Nexage, Inc. All rights reserved.
//

#import "MRAIDInterstitial.h"
#import "MRAIDView.h"
#import "SourceKitLogger.h"
#import "MRAIDServiceDelegate.h"

@interface MRAIDInterstitial () <MRAIDViewDelegate, MRAIDServiceDelegate>
{
    BOOL isReady;
    MRAIDView *mraidView;
    NSArray* supportedFeatures;
}

@end

@interface MRAIDView()

- (id)initWithFrame:(CGRect)frame
       withHtmlData:(NSString*)htmlData
        withBaseURL:(NSURL*)bsURL
     asInterstitial:(BOOL)isInter
  supportedFeatures:(NSArray *)features
           delegate:(id<MRAIDViewDelegate>)delegate
   serviceDelegate:(id<MRAIDServiceDelegate>)serviceDelegate
 rootViewController:(UIViewController *)rootViewController;

@end

@implementation MRAIDInterstitial

@synthesize isViewable=_isViewable;

- (id)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for the class MRAIDInterstitial"
                                 userInfo:nil];
    return nil;
}

// designated initializer
- (id)initWithSupportedFeatures:(NSArray *)features
                   withHtmlData:(NSString*)htmlData
                    withBaseURL:(NSURL*)bsURL
                       delegate:(id<MRAIDInterstitialDelegate>)delegate
               serviceDelegate:(id<MRAIDServiceDelegate>)serviceDelegate
             rootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self) {
        supportedFeatures = features;
        _delegate = delegate;
        _serviceDelegate = serviceDelegate;
        _rootViewController = rootViewController;
        
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        mraidView = [[MRAIDView alloc] initWithFrame:screenRect
                                        withHtmlData:htmlData
                                         withBaseURL:bsURL
                                      asInterstitial:YES
                                   supportedFeatures:supportedFeatures
                                            delegate:self
                                    serviceDelegate:self
                                  rootViewController:self.rootViewController];
        _isViewable = NO;
        isReady = NO;
    }
    return self;
}

- (void)show
{
    if (!isReady) {
        [SourceKitLogger warning:@"interstitial is not ready to show"];
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [mraidView performSelector:@selector(showAsInterstitial)];
#pragma clang diagnostic pop
}

-(void)setIsViewable:(BOOL)newIsViewable
{
    [SourceKitLogger debug:[NSString stringWithFormat: @"%@ %@", [self.class description], NSStringFromSelector(_cmd)]];
    mraidView.isViewable=newIsViewable;
}

-(BOOL)isViewable
{
    [SourceKitLogger debug:[NSString stringWithFormat: @"%@ %@", [self.class description], NSStringFromSelector(_cmd)]];
    return _isViewable;
}

#pragma mark - MRAIDViewDelegate

- (void)mraidViewAdReady:(MRAIDView *)mraidView
{
    NSLog(@"%@ MRAIDViewDelegate %@", [[self class] description], NSStringFromSelector(_cmd));
    isReady = YES;
    if ([self.delegate respondsToSelector:@selector(mraidInterstitialAdReady:)]) {
        [self.delegate mraidInterstitialAdReady:self];
    }
}

- (void)mraidViewAdFailed:(MRAIDView *)mraidView
{
    NSLog(@"%@ MRAIDViewDelegate %@", [[self class] description], NSStringFromSelector(_cmd));
    isReady = YES;
    if ([self.delegate respondsToSelector:@selector(mraidInterstitialAdFailed:)]) {
        [self.delegate mraidInterstitialAdFailed:self];
    }
}

- (void)mraidViewWillExpand:(MRAIDView *)mraidView
{
    NSLog(@"%@ MRAIDViewDelegate %@", [[self class] description], NSStringFromSelector(_cmd));
    if ([self.delegate respondsToSelector:@selector(mraidInterstitialWillShow:)]) {
        [self.delegate mraidInterstitialWillShow:self];
    }
}

- (void)mraidViewDidClose:(MRAIDView *)mv
{
    NSLog(@"%@ MRAIDViewDelegate %@", [[self class] description], NSStringFromSelector(_cmd));
    if ([self.delegate respondsToSelector:@selector(mraidInterstitialDidHide:)]) {
        [self.delegate mraidInterstitialDidHide:self];
    }
    mraidView.delegate = nil;
    mraidView.rootViewController = nil;
    mraidView = nil;
    isReady = NO;
}

#pragma mark - MRAIDServiceDelegate callbacks

- (void)mraidServiceCallTelWithUrlString:(NSString *)urlString
{
    if ([self.serviceDelegate respondsToSelector:@selector(mraidServiceCallTelWithUrlString:)]) {
        [self.serviceDelegate mraidServiceCallTelWithUrlString:urlString];
    }
}

- (void)mraidServiceCreateCalendarEventWithEventJSON:(NSString *)eventJSON
{
    if ([self.serviceDelegate respondsToSelector:@selector(mraidServiceCreateCalendarEventWithEventJSON:)]) {
        [self.serviceDelegate mraidServiceCreateCalendarEventWithEventJSON:eventJSON];
    }
}

- (void)mraidServicePlayVideoWithUrlString:(NSString *)urlString
{
    if ([self.serviceDelegate respondsToSelector:@selector(mraidServicePlayVideoWithUrlString:)]) {
        [self.serviceDelegate mraidServicePlayVideoWithUrlString:urlString];
    }
}

- (void)mraidServiceOpenBrowserWithUrlString:(NSString *)urlString
{
    if ([self.serviceDelegate respondsToSelector:@selector(mraidServiceOpenBrowserWithUrlString:)]) {
        [self.serviceDelegate mraidServiceOpenBrowserWithUrlString:urlString];
    }
}

- (void)mraidServiceStorePictureWithUrlString:(NSString *)urlString
{
    if ([self.serviceDelegate respondsToSelector:@selector(mraidServiceStorePictureWithUrlString:)]) {
        [self.serviceDelegate mraidServiceStorePictureWithUrlString:urlString];
    }
}

- (void)mraidServiceSendSmsWithUrlString:(NSString *)urlString
{
    if ([self.serviceDelegate respondsToSelector:@selector(mraidServiceSendSmsWithUrlString:)]) {
        [self.serviceDelegate mraidServiceSendSmsWithUrlString:urlString];
    }
}


@end
