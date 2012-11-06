//
//  CDAAppController.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/4/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>

@interface CDAAppController : NSObject
{
    BOOL _networkProgressIndicator;
}

@property (readonly) CWInterface *selectedInterface;
@property (readonly) CWNetwork *selectedNetwork;

@property (readonly) NSArray *arrayOfInterfaces;
@property (readonly) NSArray *arrayOfNetworks;

@property (weak) IBOutlet NSArrayController *interfacesArrayController;
@property (weak) IBOutlet NSArrayController *networksArrayController;

@property (weak) IBOutlet NSTableView *interfacesTableView;
@property (weak) IBOutlet NSTableView *networksTableView;

@property BOOL networkProgressIndicator;
@property (weak) IBOutlet NSWindow *networkProgressIndicatorWindow;

-(void)refreshInterfaces;
-(void)refreshNetworks;

- (IBAction)refreshInterfacesButton:(id)sender;
- (IBAction)refreshNetworksButton:(id)sender;

@end
