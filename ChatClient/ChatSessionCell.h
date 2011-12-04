//
//  ChatSessionCell.h
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-04.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatSessionCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel* buddyUserName;
@property (nonatomic, retain) IBOutlet UILabel* date;
@property (nonatomic, retain) IBOutlet UILabel* message;
@end
