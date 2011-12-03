//
//  CCMessageViewTableCell.h
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCMessageViewTableCell : UITableViewCell
@property (nonatomic,assign) UILabel *senderAndTimeLabel;
@property (nonatomic,assign) UITextView *messageContentView;
@property (nonatomic,assign) UIImageView *bgImageView;
@end
