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
#import "ChatServer.h"
#import "ChatTableViewCell.h"

//
//
@interface ChatController : AKeyboardAwareUIViewController <UITextFieldDelegate, NSFetchedResultsControllerDelegate> {
    IBOutlet UITableView *tableView;    
    IBOutlet UITextField *textField;    
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) ChatSession *chatSession;
@property (strong, nonatomic) ChatServer *chatServer;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

// Configure the tableViewCell at indexPath
// according to the cell
// will create ballons for sender/receiver
- (void)configureCell:(ChatTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

// Called when user clicks send in chat window, will send text to ChatServer
- (IBAction)sendAction:(id)sender;

@end
