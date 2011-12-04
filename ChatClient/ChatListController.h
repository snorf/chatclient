//
//  MasterViewController.h
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <CoreData/CoreData.h>
#import "ChatSession.h"
#import "ChatController.h"

// Class for keeping a list of the chat history
// looks very much like the iOS Message application
//
@interface ChatListController : UITableViewController <NSFetchedResultsControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) id labelCellNib;

// Configures a cell in the table view
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

// Calls addressbook to get a name for a new chat
- (void)initiateNewChat;

// Pushes view controller for a chat session
- (void)pushChatControllerForChatSession:(ChatSession*)session;

// Finds existing chat
- (ChatSession *) fetchExistingChatWithUser:(NSString *) buddyUserId;

// Inserts a new chat in core data with name from Address book
- (void)insertNewChatWithName:(NSString*)buddyUserId;
@end
