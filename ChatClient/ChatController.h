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

@interface ChatController : AKeyboardAwareUIViewController <NSFetchedResultsControllerDelegate> {
   IBOutlet UITableView *tableView;    
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ChatSession *chatSession;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
