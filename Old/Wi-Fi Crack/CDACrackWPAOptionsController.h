//
//  CDACrackWPAOptionsController.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/7/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CDACrackWPAOptionsController : NSWindowController

@property BOOL isSaveFile;

@property NSString *dictionaryFile;
@property NSString *saveFile;

- (IBAction)openFileButton:(id)sender;
- (IBAction)saveAsButton:(id)sender;

@end
