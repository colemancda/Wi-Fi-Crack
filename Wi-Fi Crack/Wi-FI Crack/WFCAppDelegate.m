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
    self.visibleVC = (WFCProceedViewController *)self.interfaceVC;
        
    // KVO
    [self addObserver:self
           forKeyPath:@"visibleVC"
              options:NSKeyValueObservingOptionInitial
              context:nil];
    
    [self addObserver:self
           forKeyPath:@"visibleVC.canProceed"
              options:NSKeyValueObservingOptionNew
              context:nil];
    
}

-(void)applicationWillTerminate:(NSNotification *)notification
{
    // KVO
    [self removeObserver:self
              forKeyPath:@"visibleVC"];
    
    [self removeObserver:self
              forKeyPath:@"visibleVC.canProceed"];
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
    
    if (self.visibleVC == (WFCProceedViewController *)self.captureVC) {
        
        self.visibleVC = (WFCProceedViewController *)self.crackVC;
        
        // put finish button
        
        self.nextButton.action = @selector(finish:);
        
        self.nextButton.title = NSLocalizedString(@"Finish", @"Finish");
    }
    
    if (self.visibleVC == (WFCProceedViewController *)self.networkVC) {
        
        self.visibleVC = (WFCProceedViewController *)self.captureVC;
    }
    
    if (self.visibleVC == (WFCProceedViewController *)self.interfaceVC) {
        
        self.visibleVC = self.networkVC;
        
        self.backButton.hidden = NO;
    }
    
    
}

- (IBAction)back:(id)sender {
    
    if (self.visibleVC == (WFCProceedViewController *)self.networkVC) {
        
        self.visibleVC = (WFCProceedViewController *)self.interfaceVC;
        
        self.backButton.hidden = YES;
    }
    
    if (self.visibleVC == (WFCProceedViewController *)self.captureVC) {
        
        self.visibleVC = (WFCProceedViewController *)self.networkVC;
        
    }
    
    if (self.visibleVC == (WFCProceedViewController *)self.crackVC) {
        
        self.visibleVC = (WFCProceedViewController *)self.captureVC;
        
        // reset next button
        
        self.nextButton.action = @selector(next:);
        
        self.nextButton.title = NSLocalizedString(@"Next", @"Next");
    }
    
    
}

-(void)finish:(id)sender
{
    [NSApp terminate:nil];
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // set KVO
    if ([keyPath isEqualToString:@"visibleVC"]) {
        
        self.box.contentView = self.visibleVC.view;
        
        self.box.title = self.visibleVC.title;
    }
    
    if ([keyPath isEqualToString:@"visibleVC.canProceed"]) {
        
        self.nextButton.enabled = self.visibleVC.canProceed;
    }
}

@end
