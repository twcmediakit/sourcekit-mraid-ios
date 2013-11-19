//
//  InterstitialAdListTVCViewController.m
//  MRAIDDemo
//
//  Created by Muthu on 10/18/13.
//  Copyright (c) 2013 Nexage. All rights reserved.
//

#import "InterstitialAdListTVC.h"
#import "InterstitialViewController.h"

@implementation InterstitialAdListTVC

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"INTERSTITIAL" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set the values before the transition
    InterstitialViewController *controller = [segue destinationViewController];
    
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selected];
    if (cell) {
        controller.titleText = cell.textLabel.text;
        controller.htmlFile = cell.detailTextLabel.text;
    }
}

@end
