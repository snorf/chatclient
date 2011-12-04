//
//  ChatClientTests.h
//  ChatClientTests
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ChatListController.h"

@interface ChatClientTests : SenTestCase {
    AppDelegate     *yourApplicationDelegate;
    ChatListController  *chatListController;
    UIView          *view;
}

@end
