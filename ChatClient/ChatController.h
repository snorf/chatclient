//
//  ChatController.h
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ChatSession.h"
#import "AKeyboardAwareUIViewController.h"
#import "ChatServer.h"

@interface ChatController : AKeyboardAwareUIViewController <UITextFieldDelegate> {
   IBOutlet UITableView *tableView;    
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ChatSession *chatSession;
@property (strong, nonatomic) NSArray *chatMessages;
@property (strong, nonatomic) ChatServer *chatServer;

@end
