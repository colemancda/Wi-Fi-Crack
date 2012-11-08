//
//  CDAAppController.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/4/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAAppController.h"
#import "CDASecurityType.h"
#import "CDACrackWEPOptionsController.h"
#import "CDACrackWPAOptionsController.h"

@implementation CDAAppController

- (id)init
{
    self = [super init];
    if (self) {
        [self refreshInterfaces];
        _wepOptions = [[CDACrackWEPOptionsController alloc] initWithWindowNibName:@"WEPOptions"];
        _wpaOptions = [[CDACrackWPAOptionsController alloc] initWithWindowNibName:@"WPAOptions"];
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
            // show error sheet
            NSAlert *alert = [NSAlert alertWithMessageText:@"Error"
                                             defaultButton:@"OK"
                                           alternateButton:nil
                                               otherButton:nil
                                 informativeTextWithFormat:@"%@", [error localizedDescription]];
            [alert setAlertStyle:NSWarningAlertStyle];
            [alert beginSheetModalForWindow:[NSApp mainWindow]
                              modalDelegate:nil
                             didEndSelector:nil
                                contextInfo:nil];
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
    if ([self selectedNetwork])
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
            
            NSMutableString *extraOptions = [[NSMutableString alloc] initWithFormat:@""];
            
            // get extra options if WEP
            if (security == 1) {
                // dictionary options
                NSString *dictionaryArg = @"";
                if ([[self wepOptions] isDictionaryFile]) {
                    NSString *dictionaryPath = [[[self wepOptions] dictionaryFile] substringFromIndex:16];
                    dictionaryArg = [[NSString alloc] initWithFormat:@" -w %@", dictionaryPath];
                    [extraOptions appendString:dictionaryArg];
                }
                // save file options
                NSString *saveFileArg = @"";
                if ([[self wepOptions] isSaveFile]) {
                    NSString *saveFilePath = [[[self wepOptions] saveFile] substringFromIndex:16];
                    saveFileArg = [[NSString alloc] initWithFormat:@" -l %@", saveFilePath];
                    [extraOptions appendString:saveFileArg];
                }
                // disable korek attack options
                NSString *korekAttack = @"";
                if ([[self wepOptions] isKorekAttack]) {
                    NSNumber *attack = [[self wepOptions] korekAttack];
                    korekAttack = [[NSString alloc] initWithFormat:@" -k %@", attack];
                    [extraOptions appendString:korekAttack];
                }
                
            }
            
            // get extra options if WPA
            if (security == 2) {
                // dictionary options (obligatory for WPA)
                NSString *dictionaryArg = @"";
                NSString *dictionaryPath = [[[self wpaOptions] dictionaryFile] substringFromIndex:16];
                dictionaryArg = [[NSString alloc] initWithFormat:@"-w %@", dictionaryPath];
                [extraOptions appendString:dictionaryArg];
                
                // save file options
                NSString *saveFileArg = @"";
                if ([[self wpaOptions] isSaveFile]) {
                    NSString *saveFilePath = [[[self wpaOptions] saveFile] substringFromIndex:16];
                    saveFileArg = [[NSString alloc] initWithFormat:@" -l %@", saveFilePath];
                    [extraOptions appendString:saveFilePath];
                }
            }
            
            // launch 'aircrack-ng' UNIX app in terminal
            NSString *script = [NSString stringWithFormat:
                                @"tell application \"Terminal\"\n activate \ndo script \"\\\"%@\\\" -a %d -b %@ /private/tmp/airportSniff*.cap %@\"\n end tell", path, security, targetBSSID, extraOptions];
            
            NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
            [appleScript executeAndReturnError:nil];
        }
    }
    
    // display alert sheet
    else {
        
        NSAlert *alert = [NSAlert alertWithMessageText:@"Select network"
                                         defaultButton:@"OK"
                                       alternateButton:nil
                                           otherButton:nil
                             informativeTextWithFormat:@"No network was selected, select a network."];
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

- (IBAction)crackOptionsButton:(id)sender {
    
    // if a network was selected
    if ([self selectedNetwork]) {
        CDASecurityType *securityType = [[CDASecurityType alloc] init];
        int security = [securityType securityForNetwork:[self selectedNetwork]];
        // wep panel
        if (security == 1) {
            if ([[[self wpaOptions] window] isVisible]) {
                [[[self wpaOptions] window] close];
            }
            [[[self wepOptions] window] makeKeyAndOrderFront:nil];
        }
        // wpa panel
        if (security == 2) {
            if ([[[self wepOptions] window] isVisible]) {
                [[[self wepOptions] window] close];
            }
            [[[self wpaOptions] window] makeKeyAndOrderFront:nil];
        }
    }
    
    // if no network was selected
    if (![self selectedNetwork]) {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Select network"
                                         defaultButton:@"OK"
                                       alternateButton:nil
                                           otherButton:nil
                             informativeTextWithFormat:@"No network was selected, select a network."];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert beginSheetModalForWindow:[NSApp mainWindow]
                          modalDelegate:nil
                         didEndSelector:nil
                            contextInfo:nil];
    }
}


#pragma mark tableView delegate methods

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    // close open panel if selected network conflicts with open panel
    CDASecurityType *securityType = [[CDASecurityType alloc] init];
    int security = [securityType securityForNetwork:[self selectedNetwork]];
    if (security == 1 && [[[self wpaOptions] window] isVisible]) {
        [[[self wpaOptions] window] close];
        [[[self wepOptions] window] makeKeyAndOrderFront:nil];
    }
    if (security == 2 && [[[self wepOptions] window] isVisible]) {
        [[[self wepOptions] window] close];
        [[[self wpaOptions] window] makeKeyAndOrderFront:nil];
    }
}


@end
