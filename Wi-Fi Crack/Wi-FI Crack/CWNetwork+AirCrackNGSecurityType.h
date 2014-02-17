//
//  CWNetwork+AirCrackNGSecurityType.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/17/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import <CoreWLAN/CoreWLAN.h>

typedef NS_ENUM(NSUInteger, WFCAirCrackNGSecurityType) {
    
    WFCAirCrackNGSecurityTypeNone,
    WFCAirCrackNGSecurityTypeWEP,
    WFCAirCrackNGSecurityTypeWPA
};

@interface CWNetwork (AirCrackNGSecurityType)

@property (readonly) WFCAirCrackNGSecurityType aircrackSecurityType;

@end
