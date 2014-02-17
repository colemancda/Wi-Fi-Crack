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
    
    if (defaultInterface) {
        
        [interfaces addObject:defaultInterface];
    }
    
    for (NSString *interfaceName in [CWInterface interfaceNames]) {
        
        // add other interfaces
        
        if (defaultInterface) {
            
            if (![interfaceName isEqualToString:defaultInterface.interfaceName]) {
                
                [interfaces addObject:[CWInterface interfaceWithName:interfaceName]];
            }
        }
        
        else {
            
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
    
    /*
     
    // Only WEP networks
    
    NSMutableArray *wepNetworks = [[NSMutableArray alloc] init];
    
    for (CWNetwork *network in networkSet) {
        
        if ([network supportsSecurity:kCWSecurityWEP] ||
            [network supportsSecurity:kCWSecurityDynamicWEP] ||
            [network supportsSecurity:kCWSecurityUnknown]) {
            
            [wepNetworks addObject:network];
        }
    }
    
    return [NSArray arrayWithArray:wepNetworks];
     
     */
    
    return networkSet.allObjects;
}

-(void)startCapture
{
    if (!self.selectedInterface || self.selectedNetwork) {
        
        [NSException raise:NSInternalInconsistencyException
                    format:@"Must have an interface and network to capture packets"];
    }
    
    // launch 'airport' in terminal
    NSString *script = [NSString stringWithFormat:
                        @"tell application \"Terminal\"\n activate \ndo script \"sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport %@ sniff %ld\"\n end tell",
                        self.selectedInterface.interfaceName,
                        self.selectedNetwork.wlanChannel.channelNumber];
    
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
    
    [appleScript executeAndReturnError:nil];
}

-(void)startCrack
{
    
    
}

@end
