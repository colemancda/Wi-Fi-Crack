//
//  WFCAppDelegate.m
//  Wi-Fi Crack
//
//  Created by Alsey Coleman Miller on 2/16/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

#import "WFCAppDelegate.h"
#import "WFCInterfaceSelectionViewController.h"
#import "WFCNetworkSelectionViewController.h"
#import "WFCCaptureViewController.h"
#import "WFCCrackViewController.h"
#import "WFCStore.h"

@implementation WFCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    // initialize VCs
    
    _interfaceVC = [[WFCInterfaceSelectionViewController alloc] init];
    
    _networkVC = [[WFCNetworkSelectionViewController alloc] init];
    
    _captureVC = [[WFCCaptureViewController alloc] init];
    
    _crackVC = [[WFCCrackViewController alloc] init];
    
    // load initial VC
    self.visibleVC = (NSViewController *)self.interfaceVC;
    
    // KVO
    [self addObserver:self
           forKeyPath:@"visibleVC"
              options:NSKeyValueObservingOptionInitial
              context:nil];
    
    
}

-(void)applicationWillTerminate:(NSNotification *)notification
{
    // KVO
    [self removeObserver:self
              forKeyPath:@"visibleVC"];
    
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    [self.window makeKeyAndOrderFront:nil];
    
    return YES;
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    // dont exit if the app is cracking or capturing
    if ([WFCStore sharedStore].isCapturing ||
        [WFCStore sharedStore].isCracking) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Actions

- (IBAction)next:(id)sender {
    
    if (self.visibleVC == (NSViewController *)self.interfaceVC) {
        
        self.visibleVC = self.networkVC;
        
        self.backButton.hidden = NO;
    }
    
    if (self.visibleVC == (NSViewController *)self.networkVC) {
        
        self.visibleVC = (NSViewController *)self.captureVC;
    }
    
    if (self.visibleVC == (NSViewController *)self.captureVC) {
        
        self.visibleVC = (NSViewController *)self.crackVC;
        
    }
    
}

- (IBAction)back:(id)sender {
    
    if (self.visibleVC == (NSViewController *)self.crackVC) {
        
        self.visibleVC = (NSViewController *)self.captureVC;
    }
    
    if (self.visibleVC == (NSViewController *)self.captureVC) {
        
        self.visibleVC = (NSViewController *)self.networkVC;
        
    }
    
    if (self.visibleVC == (NSViewController *)self.networkVC) {
        
        self.visibleVC = (NSViewController *)self.interfaceVC;
        
        self.backButton.hidden = YES;
    }
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // set KVO
    if ([keyPath isEqualToString:@"visibleVC"]) {
        
        self.box.contentView = self.visibleVC.view;
        
        self.box.title = self.visibleVC.title;
    }
    
}

@end
