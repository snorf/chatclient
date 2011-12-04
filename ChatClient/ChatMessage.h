//
//  ChatMessage.h
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-04.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ChatMessage : NSManagedObject

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * sender;
@property (nonatomic, retain) NSManagedObject *chatSession;

@end
