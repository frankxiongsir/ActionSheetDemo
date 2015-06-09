//
//  TRActionSheet.h
//  ActionSheetDemo
//
//  Created by Xiongchengfu on 15/6/4.
//  Copyright (c) 2015年 Xiongchengfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActionSheetSelectedDelegate;
@interface TRActionSheet : UIView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *cancelButtonTitle;

@property (strong, nonatomic) NSMutableArray *otherButtonArray;
@property (weak, nonatomic) id<ActionSheetSelectedDelegate> delegate;


- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

// Show the action sheet at current window
- (void) show;

// Hide the action sheeet.
- (void) hide;

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;
- (void)setCancelButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size;

@end

@protocol ActionSheetSelectedDelegate <NSObject>

@optional

- (void) didSelectedActionSheetIndex:(NSInteger)index;
- (void) didSelectedCancel:(TRActionSheet *)actionSheet;
@end