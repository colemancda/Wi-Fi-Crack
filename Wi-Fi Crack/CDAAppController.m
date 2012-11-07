//
//  CDAAppController.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/4/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAAppController.h"
#import "CDASecurityType.h"

@implementation CDAAppController

- (id)init
{
    self = [super init];
    if (self) {
        [self refreshInterfaces];
    }
    return self;
}

-(void)refreshInterfaces
{
    [self arrayOfInterfaces];
}

-(void)refreshNetworks
{
    if ([self selectedInterface]) {
        // start the UI for refreshing
        [self setNetworkProgressIndicator:YES];
        
        NSError *error;
        [[self selectedInterface] scanForNetworksWithName:nil error:&error];
        
        if (error) {
            [self setNetworkProgressIndicator:NO];
            NSLog(@"%@", [error debugDescription]);
        }
        else
        {
            [[self networksArrayController] setContent:[self arrayOfNetworks]];
            
            // end UI indicator
            [self setNetworkProgressIndicator:NO];
        }
    }
    
    if (![self selectedInterface])
    {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Select interface"
                                         defaultButton:@"OK"
                                       alternateButton:nil
                                           otherButton:nil
                             informativeTextWithFormat:@"No interface was selected, select an interface."];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert beginSheetModalForWindow:[NSApp mainWindow]
                          modalDelegate:nil
                         didEndSelector:nil
                            contextInfo:nil];
    }
}

-(void)startCapturing
{
    if ([self selectedInterface] && [self selectedNetwork]) {
        
        // launch 'airport' UNIX app in terminal
        NSString *script = [NSString stringWithFormat:
                            @"tell application \"Terminal\"\n activate \ndo script \"sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport %@ sniff %ld\"\n end tell",
                            [[self selectedInterface] interfaceName],
                            [[[self selectedNetwork] wlanChannel] channelNumber]];
        
        NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
        [appleScript executeAndReturnError:nil];
    }
    
    // display alert sheet
    else {
        
        NSAlert *alert = [NSAlert alertWithMessageText:@"Select interface and network"
                                         defaultButton:@"OK"
                                       alternateButton:nil
                                           otherButton:nil
                             informativeTextWithFormat:@"No interface or network was selected, select an interface and a network."];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert beginSheetModalForWindow:[NSApp mainWindow]
                          modalDelegate:nil
                         didEndSelector:nil
                            contextInfo:nil];  
    }
}

-(void)startCracking
{
    if ([self selectedInterface] && [self selectedNetwork])
    {
        // get the security type
        CDASecurityType *securityType = [[CDASecurityType alloc] init];
        int security = [securityType securityForNetwork:[self selectedNetwork]];
        
        // continue if its a supported security
        if (security == 1 || security == 2)
        {
            
            // get the path
            NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"aircrack-ng"];
            
            // destination network values
            NSString *targetBSSID = [[self selectedNetwork] bssid];
            
            // launch 'aircrack-ng' UNIX app in terminal
            NSString *script = [NSString stringWithFormat:
                                @"tell application \"Terminal\"\n activate \ndo script \"\\\"%@\\\" -a %d -b %@ /private/tmp/airportSniff*.cap\"\n end tell", path, security, targetBSSID];
            
            NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
            [appleScript executeAndReturnError:nil];
        }
    }
    
    // display alert sheet
    else {
        
        NSAlert *alert = [NSAlert alertWithMessageText:@"Select interface and network"
                                         defaultButton:@"OK"
                                       alternateButton:nil
                                           otherButton:nil
                             informativeTextWithFormat:@"No interface or network was selected, select an interface and a network."];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert beginSheetModalForWindow:[NSApp mainWindow]
                          modalDelegate:nil
                         didEndSelector:nil
                            contextInfo:nil];
    }
}

#pragma mark Properties

-(NSArray *)arrayOfInterfaces
{
    NSSet *setOfInterfaceNames = [CWInterface interfaceNames];
    NSMutableArray *arrayOfInterfaces = [[NSMutableArray alloc] init];
    for (NSString *interfaceName in setOfInterfaceNames) {
        CWInterface *interface = [CWInterface interfaceWithName:interfaceName];
        [arrayOfInterfaces addObject:interface];
    }
    return arrayOfInterfaces;
}

-(NSArray *)arrayOfNetworks
{
    if ([self selectedInterface]) {
        NSSet *setOfNetworks = [[self selectedInterface] cachedScanResults];
        NSMutableArray *arrayOfNetworks = [[NSMutableArray alloc] init];
        for (CWNetwork *network in setOfNetworks) {
            [arrayOfNetworks addObject:network];
        }
        return [NSArray arrayWithArray:arrayOfNetworks];
    }
    else return nil;
}

-(CWInterface *)selectedInterface
{
    // set selected interface
    NSUInteger interfaceRow = [[self interfacesArrayController] selectionIndex];
    if (interfaceRow != NSNotFound) {
        CWInterface *interface = [[[self interfacesArrayController] content] objectAtIndex:interfaceRow];
        return interface;
    }
    else return nil;
}

-(CWNetwork *)selectedNetwork
{
    // set selected network
    NSUInteger networkRow = [[self networksArrayController] selectionIndex];
    if (networkRow != NSNotFound) {
        CWNetwork *network = [[[self networksArrayController] content] objectAtIndex:networkRow];
        return network;
    }
    else return nil;
}

-(BOOL)networkProgressIndicator
{
    return _networkProgressIndicator;
}

-(void)setNetworkProgressIndicator:(BOOL)b
{
    _networkProgressIndicator = b;
    
    // set UI
    if (_networkProgressIndicator) {
        [NSApp beginSheet:_networkProgressIndicatorWindow
           modalForWindow:[NSApp mainWindow]
            modalDelegate:self
           didEndSelector:nil
              contextInfo:nil];
    }
    if (!_networkProgressIndicator) {
        [NSApp endSheet:_networkProgressIndicatorWindow];
        [_networkProgressIndicatorWindow orderOut:nil];
    }
}


#pragma mark Action Button methods

- (IBAction)refreshInterfacesButton:(id)sender {
    [self refreshInterfaces];
    [[self interfacesTableView] reloadData];
    
}

- (IBAction)refreshNetworksButton:(id)sender {
    [self refreshNetworks];
    [[self networksTableView] reloadData];
}

- (IBAction)captureButton:(id)sender {
    [self startCapturing];
}

- (IBAction)crackButton:(id)sender {
    [self startCracking];
}


@end
