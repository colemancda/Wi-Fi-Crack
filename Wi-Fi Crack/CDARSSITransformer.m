//
//  CDARSSITransformer.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/6/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDARSSITransformer.h"

@implementation CDARSSITransformer

+(Class)transformedValueClass
{
    return [NSNumber class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

-(id)transformedValue:(id)NSNumberValue
{
    NSNumber *number = NSNumberValue;
    NSInteger integer = [number integerValue];
    integer = 100 + integer;
    return [NSNumber numberWithInteger:integer];
}

@end
