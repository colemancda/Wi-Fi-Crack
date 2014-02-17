//
//  WFCInterfaceSelectionViewController.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WFCProceedViewController.h"
@class CWInterface;

@interface WFCInterfaceSelectionViewController : WFCProceedViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (readonly) NSArray *interfaces;

@property (readonly) CWInterface *selectedInterface;

-(IBAction)refresh:(id)sender;

#pragma mark - UI

@property (weak) IBOutlet NSButton *refreshButton;

@property (weak) IBOutlet NSTableView *tableView;

@end
