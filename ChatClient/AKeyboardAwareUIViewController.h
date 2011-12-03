//
//  AKeyboardAwareUIViewController.h
//  Attendium
//
//  Created by Piotr Blasiak on 2/23/11.
//  Copyright 2011 Attendium. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AKeyboardAwareUIViewController : UIViewController {

    BOOL keyboardUp, revertNextViewFrameChange;
    CGRect savedViewFrame;
}

@end
