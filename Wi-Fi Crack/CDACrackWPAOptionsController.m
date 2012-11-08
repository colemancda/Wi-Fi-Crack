//
//  CDACrackWPAOptionsController.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 11/7/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDACrackWPAOptionsController.h"

@interface CDACrackWPAOptionsController ()

@end

@implementation CDACrackWPAOptionsController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)openFileButton:(id)sender {
    
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
    if ([openPanel runModal] == NSOKButton) {
        [self setDictionaryFile:[[openPanel URL] absoluteString]];
        
    }
}

- (IBAction)saveAsButton:(id)sender {
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    if ([savePanel runModal] == NSOKButton) {
        [self setSaveFile:[[savePanel URL] absoluteString]];
    }
}

@end
