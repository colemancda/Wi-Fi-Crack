//
//  WFCNetworkSelectionViewController.h
//  Wi-FI Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WFCProceedViewController.h"
#import <CoreWLAN/CoreWLAN.h>

@interface WFCNetworkSelectionViewController : WFCProceedViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (readonly) NSArray *networks;

@property (readonly) CWNetwork *selectedNetwork;

-(IBAction)scan:(id)sender;

#pragma mark - UI

@property (weak) IBOutlet NSTableView *tableView;

@property (weak) IBOutlet NSButton *scanButton;

@property (weak) IBOutlet NSProgressIndicator *progressIndicator;

@end
