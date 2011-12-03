//
//  ChatSession.h
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ChatSession : NSManagedObject
@property (nonatomic, retain) NSString *buddyUserId;
@property (nonatomic, retain) NSDate *lastChatDate;
@property (nonatomic, retain) NSString *lastChatMessage;
@property (nonatomic, retain) NSDate *timeStamp;
@property (nonatomic, retain) NSMutableSet *chatMessages;
@end
