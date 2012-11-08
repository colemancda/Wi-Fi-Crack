//
//  CDACrackWEPOptionsController.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/7/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CDACrackWEPOptionsController : NSWindowController

@property BOOL isDictionaryFile;
@property BOOL isKorekAttack;
@property BOOL isSaveFile;

@property NSString *dictionaryFile;
@property NSNumber *korekAttack;
@property NSString *saveFile;

- (IBAction)openFileButton:(id)sender;
- (IBAction)saveAsButton:(id)sender;

@end
