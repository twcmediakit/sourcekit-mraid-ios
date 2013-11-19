//
//  InterstitialViewController.m
//  MRAIDDemo
//
//  Created by Muthu on 10/18/13.
//  Copyright (c) 2013 Nexage. All rights reserved.
//

#import "InterstitialViewController.h"

#import "MRAIDServiceDelegate.h"
#import "MRAIDInterstitial.h"
#import <AudioToolbox/AudioToolbox.h>

@interface InterstitialViewController () <MRAIDInterstitialDelegate, MRAIDServiceDelegate>
{
    MRAIDInterstitial *interstitial;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *creativeLabel;

@end

@implementation InterstitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
 
    // Make sure that you fill properties needed to identify creative
    self.titleLabel.text = self.titleText;
    self.creativeLabel.text = [NSString stringWithFormat:@"Ad: %@.html", self.htmlFile];
    self.displayInterButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fetchInterstitial:(id)sender
{
    
    // Type 1
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:self.htmlFile ofType:@"html"];
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString* htmlData = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    // Type 2
    //    NSString* htmlData = @"<html><body align='center'>Hello World<br/><button type='button' onclick='alert(mraid.getVersion());'>Get Version</button></body></html>";
    
    // Type 3 - If you want to point to a URL
    //    NSString* htmlData = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://iab.net/ad.html"] encoding:NSUTF8StringEncoding error:nil];
    

    // Initialize and load the interstitial creative
    interstitial = [[MRAIDInterstitial alloc] initWithSupportedFeatures:@[MRAIDSupportsSMS, MRAIDSupportsTel, MRAIDSupportsCalendar, MRAIDSupportsStorePicture, MRAIDSupportsInlineVideo]
                                                           withHtmlData:htmlData
                                                            withBaseURL:bundleUrl
                                                               delegate:self
                                                       serviceDelegate:self
                                                     rootViewController:self];
}

- (IBAction)displayInterstitial:(id)sender
{
    NSLog(@"displayInterstitial");
    [interstitial show];
}

#pragma mark - MRAIDInterstitialDelegate

- (void)mraidInterstitialAdReady:(MRAIDInterstitial *)mraidInterstitial
{
    NSLog(@"%@ MRAIDInterstitialDelegate %@", [[self class] description], NSStringFromSelector(_cmd));
    [self.statusLabel setText:@"Status: Ready"];
    self.fetchInterButton.enabled = NO;
    self.displayInterButton.enabled = YES;
}

- (void)mraidInterstitialAdFailed:(MRAIDInterstitial *)mraidInterstitial
{
    NSLog(@"%@ MRAIDInterstitialDelegate %@", [[self class] description], NSStringFromSelector(_cmd));
}

- (void)mraidInterstitialWillShow:(MRAIDInterstitial *)mraidInterstitial
{
    NSLog(@"%@ MRAIDInterstitialDelegate %@", [[self class] description], NSStringFromSelector(_cmd));
}

- (void)mraidInterstitialDidHide:(MRAIDInterstitial *)mraidInterstitial
{
    NSLog(@"%@ MRAIDInterstitialDelegate %@", [[self class] description], NSStringFromSelector(_cmd));
    [self.statusLabel setText:@"Status: Not Ready"];
    self.fetchInterButton.enabled = YES;
    self.displayInterButton.enabled = NO;
}

#pragma mark - MRAIDServiceDelegate

- (void)mraidServiceCallTelWithUrlString:(NSString *)urlString
{
    NSLog(@"%@ MRAIDServiceDelegate %@%@", [[self class] description], NSStringFromSelector(_cmd), urlString);
}

- (void)mraidServiceCreateCalendarEventWithEventJSON:(NSString *)eventJSON
{
    NSLog(@"%@ MRAIDServiceDelegate %@%@", [[self class] description], NSStringFromSelector(_cmd), eventJSON);
}

- (void)mraidServiceOpenBrowserWithUrlString:(NSString *)urlString
{
    NSLog(@"%@ MRAIDServiceDelegate %@%@", [[self class] description], NSStringFromSelector(_cmd), urlString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)mraidServicePlayVideoWithUrlString:(NSString *)urlString
{
    NSLog(@"%@ MRAIDServiceDelegate %@%@", [[self class] description], NSStringFromSelector(_cmd), urlString);
    NSURL *videoUrl = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:videoUrl];
}

- (void)mraidServiceSendSmsWithUrlString:(NSString *)urlString
{
    NSLog(@"%@ MRAIDServiceDelegate %@%@", [[self class] description], NSStringFromSelector(_cmd), urlString);
}

- (void)mraidServiceStorePictureWithUrlString:(NSString *)urlString
{
    NSLog(@"%@ MRAIDServiceDelegate %@%@", [[self class] description], NSStringFromSelector(_cmd), urlString);
}

#pragma mark - handle isViewable events

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%@ %@", [[self class] description], NSStringFromSelector(_cmd));
    interstitial.isViewable=NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@ %@", [[self class] description], NSStringFromSelector(_cmd));
    interstitial.isViewable=YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"%@ %@", [[self class] description], NSStringFromSelector(_cmd));
    interstitial.isViewable=NO;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"%@ %@", [[self class] description], NSStringFromSelector(_cmd));
    interstitial.isViewable=YES;
}

@end
