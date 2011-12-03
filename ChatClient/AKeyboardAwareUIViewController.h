//
//  AKeyboardAwareUIViewController.h
//  Attendium
//
//  Created by Piotr Blasiak on 2/23/11.
//  Copyright 2011 Attendium. All rights reserved.
//
// Borrowed from: http://compiotr.wordpress.com/2011/04/15/solving-the-ios-keyboard-hiding-views-once-and-for-all-akeyboardawareuiviewcontroller/
//

#import <UIKit/UIKit.h>


@interface AKeyboardAwareUIViewController : UIViewController {

    BOOL keyboardUp, revertNextViewFrameChange;
    CGRect savedViewFrame;
}

@end
