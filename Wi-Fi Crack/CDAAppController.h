//
//  CDAAppController.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/4/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>
@class CDACrackWEPOptionsController, CDACrackWPAOptionsController;

@interface CDAAppController : NSObject <NSTableViewDelegate>
{
    BOOL _networkProgressIndicator;
}

@property (readonly) CWInterface *selectedInterface;
@property (readonly) CWNetwork *selectedNetwork;

@property (readonly) NSArray *arrayOfInterfaces;
@property (readonly) NSArray *arrayOfNetworks;

@property (weak) IBOutlet NSArrayController *interfacesArrayController;
@property (weak) IBOutlet NSArrayController *networksArrayController;

@property IBOutlet NSTableView *interfacesTableView;
@property IBOutlet NSTableView *networksTableView;

// progress indicator
@property BOOL networkProgressIndicator;
@property (weak) IBOutlet NSWindow *networkProgressIndicatorWindow;

// cracking options
@property CDACrackWEPOptionsController *wepOptions;
@property CDACrackWPAOptionsController *wpaOptions;

-(void)refreshInterfaces;
-(void)refreshNetworks;
-(void)startCapturing;
-(void)startCracking;

// action methods
- (IBAction)refreshInterfacesButton:(id)sender;
- (IBAction)refreshNetworksButton:(id)sender;
- (IBAction)captureButton:(id)sender;
- (IBAction)crackButton:(id)sender;
- (IBAction)crackOptionsButton:(id)sender;


@end
