//
//  CDAAppController.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/4/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAAppController.h"

@implementation CDAAppController

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
    NSInteger row = [_interfacesTable selectedRow];
    if (row != -1) {
        return [[self arrayOfInterfaces] objectAtIndex:row];
    }
    else
    {
        return nil;
    }
}

-(NSArray *)arrayOfNetworks
{
    NSSet *setOfNetworks = [[self selectedInterface] cachedScanResults];
    return [setOfNetworks allObjects];
}

-(CWNetwork *)selectedNetwork
{
    NSInteger row = [_networksTable selectedRow];
    return [[self arrayOfNetworks] objectAtIndex:row];
}


#pragma mark Action Button methods

- (IBAction)refreshInterfacesButton:(id)sender {
    NSLog(@"interfaces: %@", [self arrayOfInterfaces]);
    
}

- (IBAction)refreshNetworksButton:(id)sender {
    CWInterface *interface = [self selectedInterface];
    NSError *error;
    [interface scanForNetworksWithName:nil
                                 error:&error];
    if (error) {
        NSRunAlertPanel(@"Scanning Error", @"scanning error: %@", [error debugDescription], @"OK", nil, nil);
        NSLog(@"scanning error: %@", error);
    }
    else NSLog(@"networks: %@", [self arrayOfNetworks]);
}



@end
