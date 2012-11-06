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
        NSError *error;
        [[self selectedInterface] scanForNetworksWithName:nil error:&error];
        if (error) {
            NSLog(@"%@", [error debugDescription]);
        }
    }
    [self arrayOfNetworks];
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
        NSLog(@"%@", [NSArray arrayWithArray:arrayOfNetworks]);
        return [NSArray arrayWithArray:arrayOfNetworks];
    }
    else return nil;
}

-(CWNetwork *)selectedNetwork
{
    return [[self networksArrayController] selection];
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
