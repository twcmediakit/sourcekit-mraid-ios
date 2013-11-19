//
//  InterstitialViewController.h
//  MRAIDDemo
//
//  Created by Muthu on 10/18/13.
//  Copyright (c) 2013 Nexage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterstitialViewController : UIViewController

@property (nonatomic, retain) NSString *titleText;
@property (nonatomic, retain) NSString *htmlFile;
@property (weak, nonatomic) IBOutlet UIButton *fetchInterButton;
@property (weak, nonatomic) IBOutlet UIButton *displayInterButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
