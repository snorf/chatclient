//
//  ChatServer.m
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
// Used example from: http://iphone.galloway.me.uk/iphone-sdktutorials/singleton-classes/
// and: http://www.duckrowing.com/2010/03/11/using-core-data-on-multiple-threads/
//

#import "ChatServer.h"
#import "ChatMessage.h"

static ChatServer *chatServer = nil;
@implementation ChatServer
@synthesize managedObjectContext;

+ (id)server {
    @synchronized(self) {
        if (chatServer == nil) {
            chatServer = [[super allocWithZone:NULL] init];
        }
    }
    return chatServer;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self server] retain];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}

- (void)release {
    // never release
}
- (id)autorelease {
    return self;
}

- (void)mergeChanges:(NSNotification *)notification
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *mainContext = [appDelegate managedObjectContext];
	
	// Merge changes into the main context on the main thread
	[mainContext performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:)	
                                  withObject:notification
                               waitUntilDone:YES];	
}


- (id)init {
    if (self = [super init]) {
        // Initialize managed object context
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [[NSManagedObjectContext alloc] init];
        [self.managedObjectContext setUndoManager:nil];
        [self.managedObjectContext setPersistentStoreCoordinator: [appDelegate persistentStoreCoordinator]];
        
        // Register context with the notification center
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; 
        [nc addObserver:self
               selector:@selector(mergeChanges:)
                   name:NSManagedObjectContextDidSaveNotification
                 object:self.managedObjectContext];
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [super dealloc];
}

#pragma mark chat server methods
- (NSString *) substituteEmoticons:(NSString*) message {
    
    //See http://www.easyapns.com/iphone-emoji-alerts for a list of emoticons available
    
    NSString *res = [message stringByReplacingOccurrencesOfString:@":)" withString:@"\ue415"];
    res = [res stringByReplacingOccurrencesOfString:@":(" withString:@"\ue403"];
    res = [res stringByReplacingOccurrencesOfString:@";)" withString:@"\ue405"];
    res = [res stringByReplacingOccurrencesOfString:@":x" withString:@"\ue418"];
    res = [res stringByReplacingOccurrencesOfString:@":D" withString:@"\ue415"];
    
    return res;
    
}

- (void)sendMessage:(NSString*)message inSession:(ChatSession*)session {
    ChatSession *chatSession = (ChatSession*)[self.managedObjectContext objectWithID:session.objectID];
    ChatMessage *chatMessage = [NSEntityDescription insertNewObjectForEntityForName:@"ChatMessage" inManagedObjectContext:self.managedObjectContext];
    chatMessage.message = [self substituteEmoticons:message];
    chatMessage.sender = @"you";
    chatMessage.timeStamp = [NSDate date];
    chatMessage.chatSession = chatSession;
    
    ChatMessage *chatMessage2 = [NSEntityDescription insertNewObjectForEntityForName:@"ChatMessage" inManagedObjectContext:self.managedObjectContext];
    chatMessage2.message = [self substituteEmoticons:@"I hear you man! :)"];
    chatMessage2.sender = session.buddyUserId;
    chatMessage2.timeStamp = [NSDate date];
    chatMessage2.chatSession = chatSession;
    
    chatSession.lastChatDate = [NSDate date];
    chatSession.lastChatMessage = chatMessage2.message;
    
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
        //[NSApp presentError:error]; 
    }
    
    [self.managedObjectContext reset];
}

@end
