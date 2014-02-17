//
//  CWNetwork+SecurityDescription.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import "CWNetwork+SecurityDescription.h"

@implementation CWNetwork (SecurityDescription)

-(NSString *)securityDescription
{
    // if WPA Personal
    if ([self supportsSecurity:kCWSecurityWPAPersonal]) {
        return @"WPA Personal";
    }
    // if WPA2 Personal
    if ([self supportsSecurity:kCWSecurityWPA2Personal]) {
        return @"WPA2 Personal";
    }
    // if WPA Enterprise
    if ([self supportsSecurity:kCWSecurityWPA2Enterprise]) {
        return @"WPA Enterprise";
    }
    // if WPA2 Enterprise
    if ([self supportsSecurity:kCWSecurityWPA2Enterprise]) {
        return @"WPA2 Enterprise";
    }
    // if WPA Personal Mixed
    if ([self supportsSecurity:kCWSecurityWPAPersonalMixed]) {
        return @"WPA Personal Mixed";
    }
    // if WPA Enterprise Mixed
    if ([self supportsSecurity:kCWSecurityWPAEnterpriseMixed]) {
        return @"Enterprise Mixed";
    }
    // if WEP network
    if ([self supportsSecurity:kCWSecurityWEP]) {
        return @"WEP";
    }
    // if Dynamic WEP
    if ([self supportsSecurity:kCWSecurityDynamicWEP]) {
        return @"Dynamic WEP";
    }
    // if no security
    if ([self supportsSecurity:kCWSecurityNone]) {
        return @"None";
    }
    // if Uknown
    if ([self supportsSecurity:kCWSecurityUnknown]) {
        return @"Unknown";
    }
    
    else return @"?";
    
}

@end
