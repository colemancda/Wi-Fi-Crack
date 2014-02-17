//
//  WFCNetworkSelectionViewController.m
//  Wi-FI Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import "WFCNetworkSelectionViewController.h"
#import "WFCStore.h"
#import "CWNetwork+SecurityDescription.h"

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
        
        self.title = NSLocalizedString(@"Network Selection",
                                       @"Network Selection");
        
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    [self scan:nil];
}

#pragma mark - Actions

-(void)scan:(id)sender
{
    self.progressIndicator.hidden = NO;
    
    [self.progressIndicator startAnimation:nil];
    
    self.scanButton.enabled = NO;
    
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        NSError *error;
       
        self.networks = [[WFCStore sharedStore] allNetworks:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            if (error) {
                
                [NSApp presentError:error];
            }
            
            [self.progressIndicator stopAnimation:nil];
            
            self.progressIndicator.hidden = YES;
            
            self.scanButton.enabled = YES;
            
            [self.tableView reloadData];
            
        }];
    }];
}

#pragma mark - Table View Data Source

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.networks.count;
}

#pragma mark - Table View Delegate

-(NSView *)tableView:(NSTableView *)tableView
  viewForTableColumn:(NSTableColumn *)tableColumn
                 row:(NSInteger)row
{
    // get resusable view
    NSView *view = [self.tableView makeViewWithIdentifier:tableColumn.identifier
                                                    owner:self];
    
    // get model object
    
    CWNetwork *network = self.networks[row];
    
    // setup view
    
    if ([tableColumn.identifier isEqualToString:@"SSID"]) {
        
        NSTableCellView *cellView = (NSTableCellView *)view;
        
        cellView.textField.stringValue = network.ssid;
    }
    
    if ([tableColumn.identifier isEqualToString:@"BSSID"]) {
        
        NSTableCellView *cellView = (NSTableCellView *)view;
        
        cellView.textField.stringValue = network.bssid;
    }
    
    if ([tableColumn.identifier isEqualToString:@"channel"]) {
        
        NSTableCellView *cellView = (NSTableCellView *)view;
        
        cellView.textField.integerValue = network.wlanChannel.channelNumber;
    }
    
    if ([tableColumn.identifier isEqualToString:@"security"]) {
        
        NSTableCellView *cellView = (NSTableCellView *)view;
        
        cellView.textField.stringValue = network.securityDescription;
    }
    
    if ([tableColumn.identifier isEqualToString:@"strength"]) {
        
        NSLevelIndicator *levelIndicator = (NSLevelIndicator *)view;
        
        levelIndicator.integerValue = network.noiseMeasurement + 100;
    }
    
    return view;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    if (self.tableView.selectedRow == -1) {
        
        self.canProceed = NO;
        
    }
    
    else {
        
        // get interface for row...
        
        self.selectedNetwork = _networks[self.tableView.selectedRow];
        
        [WFCStore sharedStore].selectedNetwork = self.selectedNetwork;
        
        self.canProceed = YES;
    }
}

@end
