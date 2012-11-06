//
//  CWNetwork+channel.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/6/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CWNetwork+channel.h"

@implementation CWNetwork (channel)

-(NSUInteger)channel
{
    return [[self wlanChannel] channelNumber];
}

@end
