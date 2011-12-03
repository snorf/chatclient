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
- (void)sendMessage:(NSString*)message inSession:(ChatSession*)session;

@end
