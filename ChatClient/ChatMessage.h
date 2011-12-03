//
//  ChatMessage.h
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ChatSession.h"

@interface ChatMessage : NSManagedObject
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *sender;
@property (nonatomic, retain) NSDate *timeStamp;
@property (nonatomic, retain) ChatSession *chatSession;
@end
