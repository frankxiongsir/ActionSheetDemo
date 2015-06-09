//
//  TRActionSheetCell.m
//  ActionSheetDemo
//
//  Created by Xiongchengfu on 15/6/4.
//  Copyright (c) 2015年 Xiongchengfu. All rights reserved.
//

#import "TRActionSheetCell.h"

#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
@interface TRActionSheetCell()
@property (strong, nonatomic) UIImageView *seperateline;
@end

@implementation TRActionSheetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.otherButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, IPHONE_WIDTH - 60, 44)];
        self.otherButtonLabel.font = [UIFont systemFontOfSize:14.0f];
        self.otherButtonLabel.numberOfLines = 0;
        self.otherButtonLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.otherButtonLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.otherButtonLabel];
        self.seperateline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,IPHONE_WIDTH, 1)];
        self.seperateline.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.seperateline];
    }
    return self;
}
@end
