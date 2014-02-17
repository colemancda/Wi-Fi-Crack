//
//  CWNetwork+AirCrackNGSecurityType.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/17/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import "CWNetwork+AirCrackNGSecurityType.h"

@implementation CWNetwork (AirCrackNGSecurityType)

-(WFCAirCrackNGSecurityType)aircrackSecurityType
{
    // if WEP network
    if ([self supportsSecurity:kCWSecurityWEP]) {
        return 1;
    }
    // if Dynamic WEP
    if ([self supportsSecurity:kCWSecurityDynamicWEP]) {
        return 1;
    }
    // if no security
    if ([self supportsSecurity:kCWSecurityNone]) {
        return 0;
    }
    // if WPA Personal
    if ([self supportsSecurity:kCWSecurityWPAPersonal]) {
        return 2;
    }
    // if WPA2 Personal
    if ([self supportsSecurity:kCWSecurityWPA2Personal]) {
        return 2;
    }
    // if WPA Enterprise
    if ([self supportsSecurity:kCWSecurityWPA2Enterprise]) {
        return 2;
    }
    // if WPA2 Enterprise
    if ([self supportsSecurity:kCWSecurityWPA2Enterprise]) {
        return 2;
    }
    // if WPA Personal Mixed
    if ([self supportsSecurity:kCWSecurityWPAPersonalMixed]) {
        return 2;
    }
    // if WPA Enterprise Mixed
    if ([self supportsSecurity:kCWSecurityWPAEnterpriseMixed]) {
        return 2;
    }
    // if Uknown
    if ([self supportsSecurity:kCWSecurityUnknown]) {
        return 0;
    }
    
    else return 0;
}

@end
