//
//  ChatController.m
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatController.h"
#import "CCMessageViewTableCell.h"
#import "ChatMessage.h"

@implementation ChatController
@synthesize tableView;
@synthesize chatMessages;
@synthesize chatSession;
@synthesize chatServer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = NSLocalizedString(@"Chats", @"Chats");
        self.chatServer = [ChatServer server];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataModelChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.chatSession.managedObjectContext];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tableView = nil;
    self.view = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chatMessages count];
}


int padding = 20;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
(NSIndexPath *)indexPath {
    ChatMessage *chatMessage = [self.chatMessages objectAtIndex:indexPath.row];
    
    CGSize  textSize = { 260.0, 10000.0 };
    CGSize size = [chatMessage.message sizeWithFont:[UIFont boldSystemFontOfSize:13]
                  constrainedToSize:textSize
                      lineBreakMode:UILineBreakModeWordWrap];
    
    size.height += padding*2;
    
    CGFloat height = size.height < 65 ? 65 : size.height;
    return height;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChatListItem";
    
    CCMessageViewTableCell *cell = (CCMessageViewTableCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[CCMessageViewTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    ChatMessage *chatMessage = [self.chatMessages objectAtIndex:indexPath.row];
    
    CGSize  textSize = { 260.0, 10000.0 };
    CGSize size = [chatMessage.message sizeWithFont:[UIFont boldSystemFontOfSize:13]
                      constrainedToSize:textSize
                          lineBreakMode:UILineBreakModeWordWrap];
    
    size.width += (padding/2);
    
    cell.messageContentView.text = chatMessage.message;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
    
    UIImage *bgImage = nil;
    
    if ([chatMessage.sender isEqualToString:@"you"]) { // left aligned
        
        bgImage = [[UIImage imageNamed:@"orange.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
        
        [cell.messageContentView setFrame:CGRectMake(padding, padding*2, size.width, size.height)];
        
        [cell.bgImageView setFrame:CGRectMake( cell.messageContentView.frame.origin.x - padding/2,
                                              cell.messageContentView.frame.origin.y - padding/2,
                                              size.width+padding,
                                              size.height+padding)];
        
    } else {
        
        bgImage = [[UIImage imageNamed:@"aqua.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
        
        [cell.messageContentView setFrame:CGRectMake(320 - size.width - padding,
                                                     padding*2,
                                                     size.width,
                                                     size.height)];
        
        [cell.bgImageView setFrame:CGRectMake(cell.messageContentView.frame.origin.x - padding/2,
                                              cell.messageContentView.frame.origin.y - padding/2,
                                              size.width+padding,
                                              size.height+padding)];
        
    }
    
    cell.bgImageView.image = bgImage;
    cell.senderAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", chatMessage.sender, chatMessage.timeStamp];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0) {
        [chatServer sendMessage:textField.text inSession:chatSession];
    }
    return NO;
}

#pragma mark managed object updates
- (void)handleDataModelChange:(NSNotification *)note;
{
    NSSet *updatedObjects = [[note userInfo] objectForKey:NSUpdatedObjectsKey];
    NSSet *deletedObjects = [[note userInfo] objectForKey:NSDeletedObjectsKey];
    NSSet *insertedObjects = [[note userInfo] objectForKey:NSInsertedObjectsKey];
    if ([updatedObjects count]) {
        for (id updatedObject in updatedObjects) {
            NSLog(@"Kind: %@", [updatedObject description]);
        }
    }
    NSLog(@"updated: %@", [updatedObjects description]);
    NSLog(@"deleted: %@", [deletedObjects description]);
    NSLog(@"inserted: %@", [insertedObjects description]);
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chatSession == %@", chatSession];
    if ([insertedObjects count]) {
        for (id updatedObject in insertedObjects) {
            if ([updatedObject isKindOfEntity:(NSEntityDescription *):[ChatMessage ]) {
                ChatMessage *newMessage = (ChatMessage*)updatedObject;
                
            }
            NSLog(@"Kind: %@", [updatedObject description]);
        }
    }


    // Do something in response to this
}

@end
