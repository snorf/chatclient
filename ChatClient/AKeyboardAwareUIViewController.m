//
//  AKeyboardAwareUIViewController.m
//  Attendium
//
//  Created by Piotr Blasiak on 2/23/11.
//  Copyright 2011 Attendium. All rights reserved.
//

#import "AKeyboardAwareUIViewController.h"


@implementation AKeyboardAwareUIViewController


- (void)moveViewForKeyboard:(NSNotification*)aNotification up:(BOOL)up {

	NSDictionary* userInfo = [aNotification userInfo];
	
	CGRect keyboardEndFrame;
	[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
	
	CGRect newFrame = self.view.frame;
	CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
	
	newFrame.size.height += (up? -1 : 1) * keyboardFrame.size.height;
	
	self.view.frame = newFrame;
    
    keyboardUp = up;
}


- (void)keyboardDidShow:(NSNotification *)notification {
    
	[self moveViewForKeyboard:notification up:YES];
}


- (void)keyboardDidHide:(NSNotification *)notification {
	
	[self moveViewForKeyboard:notification up:NO];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	[notificationCenter addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    if (&UIApplicationDidEnterBackgroundNotification != nil) [notificationCenter addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [self.view addObserver:self forKeyPath:@"frame" options:0 context:nil];
}


- (void)applicationDidEnterBackground {
    
    // When an application becomes active after going to the background, the main view is resized without taking the keyboard into account -
    // so we need to save the frame and revert the frame change when going active again
    if (keyboardUp) {
        
        savedViewFrame = self.view.frame;
        revertNextViewFrameChange = YES;
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (revertNextViewFrameChange) {
        
        revertNextViewFrameChange = NO;
        self.view.frame = savedViewFrame;
    }
}


- (void)dealloc {

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}


@end
