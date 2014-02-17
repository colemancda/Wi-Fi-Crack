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
    
    for (NSString *interfaceName in [CWInterface interfaceNames]) {
        
        // add other interfaces
        
        if (![interfaceName isEqualToString:defaultInterface.interfaceName]) {
            
            [interfaces addObject:[CWInterface interfaceWithName:interfaceName]];
        }
    }
    
    return interfaces;
}

#pragma mark

-(NSArray *)allNetworks:(NSError *__autoreleasing *)error
{
    NSAssert(self.selectedInterface, @"Must have an interface to scan WLAN");
    
    NSSet *networkSet = [self.selectedInterface scanForNetworksWithName:nil
                                                                error:error];
    
    if (*error) {
        
        return nil;
    }
    
    NSMutableArray *wepNetworks = [[NSMutableArray alloc] init];
    
    for (CWNetwork *network in networkSet) {
        
        if ([network supportsSecurity:kCWSecurityWEP]) {
            
            [wepNetworks addObject:network];
        }
    }
    
    return [NSArray arrayWithArray:wepNetworks];
}

@end
