//
//  CCMessageViewTableCell.m
//  ChatClient
//
//  Created by Johan Karlsteen on 2011-12-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCMessageViewTableCell.h"

@implementation CCMessageViewTableCell
@synthesize senderAndTimeLabel;
@synthesize messageContentView;
@synthesize bgImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        senderAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 20)];
        senderAndTimeLabel.textAlignment = UITextAlignmentCenter;
        senderAndTimeLabel.font = [UIFont systemFontOfSize:11.0];
        senderAndTimeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:senderAndTimeLabel];
        
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:bgImageView];
        
        messageContentView = [[UITextView alloc] init];
        messageContentView.backgroundColor = [UIColor clearColor];
        messageContentView.editable = NO;
        messageContentView.scrollEnabled = NO;
        [messageContentView sizeToFit];
        [self.contentView addSubview:messageContentView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    self.senderAndTimeLabel = nil;
    self.messageContentView = nil;
    self.bgImageView = nil;
    [super dealloc];
}

@end