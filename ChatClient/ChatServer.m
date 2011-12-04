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
        self.managedObjectContext = [self copyOfManagedObjectContext];
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [super dealloc];
}

#pragma mark chat server methods
- (NSString *) substituteEmoticons:(NSString*) res {
    
    //See http://www.easyapns.com/iphone-emoji-alerts for a list of emoticons available
    
    res = [res stringByReplacingOccurrencesOfString:@":)" withString:@"\ue415"];
    res = [res stringByReplacingOccurrencesOfString:@":(" withString:@"\ue403"];
    res = [res stringByReplacingOccurrencesOfString:@";)" withString:@"\ue405"];
    res = [res stringByReplacingOccurrencesOfString:@":x" withString:@"\ue418"];
    res = [res stringByReplacingOccurrencesOfString:@":D" withString:@"\ue415"];
    
    return res;
    
}

- (void)insertMessage:(NSString *)message fromSender:(NSString *)sender inChatSession:(ChatSession *)chatSession atDate:(NSDate *)date inMoc:(NSManagedObjectContext*)moc {
    ChatMessage *chatMessage = [NSEntityDescription insertNewObjectForEntityForName:@"ChatMessage" inManagedObjectContext:moc];
    chatMessage.message = [self substituteEmoticons:message];
    chatMessage.sender = sender;
    chatMessage.timeStamp = date;
    chatMessage.chatSession = chatSession;
    chatSession.lastChatDate = [NSDate date];
    chatSession.lastChatMessage = message;
}

- (NSManagedObjectContext*)copyOfManagedObjectContext {
    // Since this is running on a separate thread we need our own MOC
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] init];
    [moc setUndoManager:nil];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [moc setPersistentStoreCoordinator: [appDelegate persistentStoreCoordinator]];
    
    // Register context with the notification center
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; 
    [nc addObserver:self
           selector:@selector(mergeChanges:)
               name:NSManagedObjectContextDidSaveNotification
             object:moc];
    return moc;
}

- (void)fillWithTestData {
    NSManagedObjectContext *moc = [self copyOfManagedObjectContext];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    for (int i=0; i<500; i++) {
        NSDate *date = [NSDate date];
        NSString *buddyUserName = [NSString stringWithFormat:@"Buddy %d", i];
        ChatSession *chatSession = [NSEntityDescription insertNewObjectForEntityForName:@"ChatSession" inManagedObjectContext:moc];
        chatSession.buddyUserId = buddyUserName;
        for (int j=0; j<1000; j++) {
            [self insertMessage:[NSString stringWithFormat:@"Hello %d ;)", j] fromSender:buddyUserName inChatSession:chatSession atDate:date inMoc:moc];
            [self insertMessage:[NSString stringWithFormat:@"Message %d :)", j] fromSender:@"you" inChatSession:chatSession atDate:date inMoc:moc];
        }
        NSError *error = nil;
        [moc save:&error];
        
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [moc reset];

        // Drain the pool
        [pool drain];
        pool = [[NSAutoreleasePool alloc] init];
    }
    [pool drain];
}

- (void)answerMessageInSession:(ChatSession*)session {
    NSManagedObjectContext *moc = [self copyOfManagedObjectContext];
    sleep(2);
    session = (ChatSession*)[moc objectWithID:session.objectID];
    [self insertMessage:@"I hear you man :)" fromSender:session.buddyUserId inChatSession:session atDate:[NSDate date] inMoc:moc];
    NSError *error = nil;
    [moc save:&error];
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    [moc reset];
    
    //sleep(3);
    //[self fillWithTestData];
}

- (void)sendMessage:(NSString*)message inSession:(ChatSession*)session {
    ChatSession *chatSession = (ChatSession*)[self.managedObjectContext objectWithID:session.objectID];

    [self insertMessage:message fromSender:@"you" inChatSession:chatSession atDate:[NSDate date] inMoc:self.managedObjectContext];
            
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    
    [self.managedObjectContext reset];

    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(answerMessageInSession:)
                                                                              object:chatSession];
    
    [queue addOperation:operation];
    [operation release];
}

@end
