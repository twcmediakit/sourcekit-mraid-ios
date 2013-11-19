//
//  MRAIDTestAdsViewController.m
//  MRAIDDemo
//
//  Created by Muthu on 9/25/13.
//  Copyright (c) 2013 Nexage. All rights reserved.
//

#import "BannerAdListTVC.h"
#import "BannerViewController.h"

@implementation BannerAdListTVC

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"BANNER" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set the values before the transition
    BannerViewController *controller = [segue destinationViewController];
    
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selected];
    if (cell) {
        controller.titleText = cell.textLabel.text;
        controller.htmlFile = cell.detailTextLabel.text;
        
        [controller loadCreativeOnABanner];
    }
}

@end
