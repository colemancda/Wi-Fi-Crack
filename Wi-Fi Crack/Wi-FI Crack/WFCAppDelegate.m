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

@implementation WFCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    // initialize VCs
    
    _interfaceVC = [[WFCInterfaceSelectionViewController alloc] init];
    
    _networkVC = [[WFCNetworkSelectionViewController alloc] init];
    
    // KVO
    [self addObserver:self
           forKeyPath:@"visibleVC"
              options:NSKeyValueObservingOptionInitial
              context:nil];
    
    // load initial VC
    
    self.visibleVC = (NSViewController *)self.interfaceVC;
    
}

-(void)applicationWillTerminate:(NSNotification *)notification
{
    // KVO
    [self removeObserver:self
              forKeyPath:@"visibleVC"];
    
}

#pragma mark - Actions

- (IBAction)back:(id)sender {
    
    if (self.visibleVC == self.networkVC) {
        
        
    }
    
}

- (IBAction)next:(id)sender {
    
    
    
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
