//
//  ChatSession.h
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-04.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ChatMessage;

@interface ChatSession : NSManagedObject

@property (nonatomic, retain) NSString * buddyUserId;
@property (nonatomic, retain) NSDate * lastChatDate;
@property (nonatomic, retain) NSString * lastChatMessage;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSSet *chatMessages;
@end

@interface ChatSession (CoreDataGeneratedAccessors)

- (void)addChatMessagesObject:(ChatMessage *)value;
- (void)removeChatMessagesObject:(ChatMessage *)value;
- (void)addChatMessages:(NSSet *)values;
- (void)removeChatMessages:(NSSet *)values;

@end
