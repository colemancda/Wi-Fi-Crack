//
//  WFCStore.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import "WFCStore.h"

@implementation WFCStore

+ (instancetype)sharedStore
{
    static WFCStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

#pragma mark - Transient Properties

-(NSArray *)allInterfaces
{
    NSMutableArray *interfaces = [[NSMutableArray alloc] init];
    
    CWInterface *defaultInterface = [CWInterface interface];
    
    [interfaces addObject:defaultInterface];
    
    for (CWInterface *interface in [CWInterface interfaceNames]) {
        
        // add other interfaces
        
        if (![interface.interfaceName isEqualToString:defaultInterface.interfaceName]) {
            
            [interfaces addObject:interface];
        }
    }
    
    return interfaces;
}

#pragma mark

-(NSArray *)allNetworks:(NSError *__autoreleasing *)error
{
    NSAssert(self.selectedInterface, @"Must have an interface to scan WLAN");
    
    NSSet *networks = [self.selectedInterface scanForNetworksWithName:nil
                                                                error:error];
    
    if (error) {
        
        return nil;
    }
    
    return networks.allObjects;
}

@end
