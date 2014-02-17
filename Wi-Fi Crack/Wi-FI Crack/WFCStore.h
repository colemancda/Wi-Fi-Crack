//
//  WFCStore.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>

@interface WFCStore : NSObject

+ (instancetype)sharedStore;

@property CWInterface *selectedInterface;

@property CWNetwork *selectedNetwork;

@property (readonly) NSArray *allInterfaces;

-(NSArray *)allNetworks:(NSError **)error;

#pragma mark

-(void)startCapture;

-(void)startCrack;

@end
