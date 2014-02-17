//
//  WFCInterfaceSelectionViewController.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import "WFCInterfaceSelectionViewController.h"
#import "WFCStore.h"

@interface WFCInterfaceSelectionViewController ()

@property NSArray *interfaces;

@end

@implementation WFCInterfaceSelectionViewController

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
        
        
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    [self refresh:nil];
}

#pragma mark - Actions

-(void)refresh:(id)sender
{
    // show progress indicator
    
    self.progressIndicator.hidden = NO;
    
    [self.progressIndicator startAnimation:nil];
    
    self.refreshButton.enabled = NO;
    
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        self.interfaces = [[WFCStore sharedStore] allInterfaces];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self.progressIndicator stopAnimation:nil];
            
            self.progressIndicator.hidden = YES;
           
            [self.tableView reloadData];
            
            self.refreshButton.enabled = YES;
            
        }];
        
    }];
    
}

#pragma mark - Table View Data Source



@end
