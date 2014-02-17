//
//  CWNetwork+SecurityDescription.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import <CoreWLAN/CoreWLAN.h>

@interface CWNetwork (SecurityDescription)

@property (readonly) NSString *securityDescription;

@end
