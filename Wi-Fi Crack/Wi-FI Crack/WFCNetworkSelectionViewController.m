//
//  WFCNetworkSelectionViewController.m
//  Wi-FI Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import "WFCNetworkSelectionViewController.h"

@interface WFCNetworkSelectionViewController ()

@property NSArray *networks;

@property CWNetwork *selectedNetwork;

@end

@implementation WFCNetworkSelectionViewController

- (id)init
{
    self = [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        
        self.title = NSLocalizedString(@"Network Selection", @"Network Selection");
        
    }
    return self;
}

#pragma mark - Actions

-(void)scan:(id)sender
{
    
    
}

#pragma mark



@end
