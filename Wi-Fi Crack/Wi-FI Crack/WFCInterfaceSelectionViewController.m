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

@property CWInterface *selectedInterface;

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
        
        self.title = NSLocalizedString(@"Interface Selection", @"Interface Selection");
        
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
    self.refreshButton.enabled = NO;
    
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        self.interfaces = [[WFCStore sharedStore] allInterfaces];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
           
            [self.tableView reloadData];
            
            self.refreshButton.enabled = YES;
            
        }];
        
    }];
    
}

#pragma mark - Table View Data Source

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.interfaces.count;
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
    CWInterface *interface = _interfaces[row];
    
    // configure view
    
    if ([tableColumn.identifier isEqualToString:@"name"]) {
        
        NSTableCellView *cellView = (NSTableCellView *)view;
        
        cellView.textField.stringValue = interface.interfaceName;
        
    }
    
    if ([tableColumn.identifier isEqualToString:@"macAddress"]) {
        
        NSTableCellView *cellView = (NSTableCellView *)view;
        
        cellView.textField.stringValue = interface.hardwareAddress;
        
    }
    
    if ([tableColumn.identifier isEqualToString:@"powerOn"]) {
        
        NSButton *checkBox = (NSButton *)view;
        
        checkBox.integerValue = interface.powerOn;
        
    }
    
    if ([tableColumn.identifier isEqualToString:@"hardwareAttached"]) {
        
        NSButton *checkBox = (NSButton *)view;
        
        checkBox.integerValue = interface.deviceAttached;
    }
    
    if ([tableColumn.identifier isEqualToString:@"active"]) {
        
        NSButton *checkBox = (NSButton *)view;
        
        checkBox.integerValue = interface.serviceActive;
    }
    
    return view;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    if (self.tableView.selectedRow != -1) {
        
        // get interface for row...
        
        self.selectedInterface = _interfaces[self.tableView.selectedRow];
    }
}

@end
