//
//  CDASecurityType.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/2/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>

@interface CDASecurityType : NSObject

/* Returns 1 for WEP and 2 for WPA. Returns 0 for no security */

-(int)securityForNetwork:(CWNetwork *)network;

@end
