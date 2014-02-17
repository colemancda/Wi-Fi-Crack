//
//  WFCAppDelegate.h
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class WFCNetworkSelectionViewController, WFCInterfaceSelectionViewController, WFCCaptureViewController, WFCCrackViewController;

@interface WFCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSBox *box;

@property (weak) IBOutlet NSButton *backButton;

@property (weak) IBOutlet NSButton *nextButton;

#pragma mark - View Controllers

@property NSViewController *visibleVC;

@property (readonly) WFCInterfaceSelectionViewController *interfaceVC;

@property (readonly) WFCNetworkSelectionViewController *networkVC;

@property (readonly) WFCCaptureViewController *captureVC;

@property (readonly) WFCCrackViewController *crackVC;

#pragma mark - Actions

- (IBAction)back:(id)sender;

- (IBAction)next:(id)sender;



@end
