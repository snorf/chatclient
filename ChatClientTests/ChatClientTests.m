//
//  ChatClientTests.m
//  ChatClientTests
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatClientTests.h"

@implementation ChatClientTests

- (void)setUp
{
    [super setUp];
    yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    chatListController = [yourApplicationDelegate chatListController];
    view = [chatListController view];    
}

- (void)testAppDelegate
{
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
}

- (void)testViewController
{
    STAssertNotNil(chatListController, @"UIApplication failed to find the View Controller");
}

- (void)testView
{
    STAssertNotNil(view, @"UIApplication failed to find the View");
}


@end
