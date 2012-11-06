//
//  CDAAppController.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/4/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAAppController.h"

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

-(CWInterface *)selectedInterface
{
    NSInteger row = [[self interfacesTableView] selectedRow];
    if (row != -1) {
        NSArray *array = [[self interfacesArrayController] arrangedObjects];
        CWInterface *interface = [array objectAtIndex:row];
        return interface;
    }
    else return nil;
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

-(CWNetwork *)selectedNetwork
{
    return [[self networksArrayController] selection];
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
}



@end
