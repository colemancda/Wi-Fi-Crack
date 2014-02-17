//
//  CDASecurityType.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/2/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDASecurityType.h"

@implementation CDASecurityType

-(int)securityForNetwork:(CWNetwork *)network
{
    // if WEP network
    if ([network supportsSecurity:kCWSecurityWEP]) {
        return 1;
    }
    // if Dynamic WEP
    if ([network supportsSecurity:kCWSecurityDynamicWEP]) {
        return 1;
    }
    // if no security
    if ([network supportsSecurity:kCWSecurityNone]) {
        return 0;
    }
    // if WPA Personal
    if ([network supportsSecurity:kCWSecurityWPAPersonal]) {
        return 2;
    }
    // if WPA2 Personal
    if ([network supportsSecurity:kCWSecurityWPA2Personal]) {
        return 2;
    }
    // if WPA Enterprise
    if ([network supportsSecurity:kCWSecurityWPA2Enterprise]) {
        return 2;
    }
    // if WPA2 Enterprise
    if ([network supportsSecurity:kCWSecurityWPA2Enterprise]) {
        return 2;
    }
    // if WPA Personal Mixed
    if ([network supportsSecurity:kCWSecurityWPAPersonalMixed]) {
        return 2;
    }
    // if WPA Enterprise Mixed
    if ([network supportsSecurity:kCWSecurityWPAEnterpriseMixed]) {
        return 2;
    }
    // if Uknown
    if ([network supportsSecurity:kCWSecurityUnknown]) {
        return 0;
    }
    
    else return 0;
}


@end
