//
//  ChatServer.h
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatSession.h"

@class AppDelegate;
@interface ChatServer : NSObject

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (id)server;

// Merge changes in managed object context
- (void)mergeChanges:(NSNotification *)notification;

// Creates a copy of ManagedObjectContext to be used on background thread
- (NSManagedObjectContext*)copyOfManagedObjectContext;

// Substitutes some common ascii smileys for their corresponding codes
- (NSString *) substituteEmoticons:(NSString*)res;

// Inserts a chat message in moc
- (void)insertMessage:(NSString *)message fromSender:(NSString *)sender inChatSession:(ChatSession *)chatSession atDate:(NSDate *)date inMoc:(NSManagedObjectContext*)moc;

// Generates 500 conversations with 1000 messages in each
- (void)fillWithTestData;

// Called by background thread to answer on a chat message, sleeps 2 seconds first
- (void)answerMessageInSession:(ChatSession*)session;

// Sends a message to the chat server
- (void)sendMessage:(NSString*)message inSession:(ChatSession*)session;

@end
