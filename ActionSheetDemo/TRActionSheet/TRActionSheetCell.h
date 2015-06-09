//
//  TRActionSheetCell.h
//  ActionSheetDemo
//
//  Created by Xiongchengfu on 15/6/4.
//  Copyright (c) 2015年 Xiongchengfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRActionSheetCell : UITableViewCell
@property (strong, nonatomic) UILabel *otherButtonLabel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
