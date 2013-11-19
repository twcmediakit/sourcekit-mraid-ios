//
//  BannerViewController.h
//  MRAIDDemo
//
//  Created by Muthu on 9/25/13.
//  Copyright (c) 2013 Nexage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerViewController : UIViewController

@property (nonatomic, retain) NSString *titleText;
@property (nonatomic, retain) NSString *htmlFile;
@property (weak, nonatomic) IBOutlet UITextView *additionalInfo;

- (void)loadCreativeOnABanner;

@end
