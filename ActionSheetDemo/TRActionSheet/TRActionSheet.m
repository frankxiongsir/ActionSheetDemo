//
//  TRActionSheet.m
//  ActionSheetDemo
//
//  Created by Xiongchengfu on 15/6/4.
//  Copyright (c) 2015年 Xiongchengfu. All rights reserved.
//

#import "TRActionSheet.h"
#import "TRActionSheetCell.h"

#define SPACE_SMALL 5
#define TITLE_FONT_SIZE 15
#define OTHERBUTTON_FONT_SIZE 14
@interface TRActionSheet()
@property (strong, nonatomic)UIView *backgroundView;
@property (strong, nonatomic)UIView *contentView;
@property (strong, nonatomic)UIView *aboveView;
@property (strong, nonatomic)UITableView *otherButtonView;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UIButton *cancelButton;
@end
CGFloat contentViewWidth;
CGFloat contentViewHeight;
@implementation TRActionSheet

- (id) initWithOtherButtonArray:(NSArray *)array {
    self = [super init];
    if (self) {
        _otherButtonArray = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (id) initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle;
        _otherButtonArray = [NSMutableArray array];
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles) {
            [_otherButtonArray addObject:otherButtonTitles];
            while (1) {
                NSString *otherButtonTitle = va_arg(args, NSString *);
                if (otherButtonTitle == nil) {
                    break;
                } else {
                    [_otherButtonArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.alpha = 0;
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:_backgroundView];
        
        [self initContentView];
    }
    return self;
}

- (void) initContentView
{
    if (!_contentView) {
        contentViewWidth = 290 * self.frame.size.width / 320;
        contentViewHeight = 0;

        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];

        _aboveView = [[UIView alloc] init];
        _aboveView.backgroundColor = [UIColor whiteColor];
        
        [self initTitle];
        [self initOtherButtonView];
        [self initCancelButton];
        
        _contentView.frame = CGRectMake((self.frame.size.width - contentViewWidth ) / 2, self.frame.size.height, contentViewWidth, contentViewHeight);
        [self addSubview:_contentView];
        
    }
}

- (void) initTitle
{
    if (_title != nil && ![_title isEqualToString:@""]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentViewWidth, 50)];
        _titleLabel.text = _title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [_aboveView addSubview:_titleLabel];
        contentViewHeight += _titleLabel.frame.size.height;
    }
}
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size
{
    if (color != nil) {
        _titleLabel.textColor = color;
    }
    if (size > 0) {
        _titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void) initOtherButtonView
{
    CGFloat otherButtonViewHeight = [self getOtherButtonViewHeight:_otherButtonArray];
    if (!_otherButtonView) {
        _otherButtonView = [[UITableView alloc] initWithFrame:CGRectMake(0, contentViewHeight, contentViewWidth, otherButtonViewHeight)];
        _otherButtonView.layer.cornerRadius = 0.5;
        _otherButtonView.dataSource = self;
        _otherButtonView.delegate = self;
        _otherButtonView.backgroundColor = [UIColor whiteColor];
        _otherButtonView.bounces = NO;
        _otherButtonView.bouncesZoom = NO;
        _otherButtonView.showsHorizontalScrollIndicator = NO;
        _otherButtonView.showsVerticalScrollIndicator = YES;
        _otherButtonView.separatorStyle = UITableViewCellSeparatorStyleNone;
        contentViewHeight += _otherButtonView.frame.size.height;
        [_aboveView addSubview:_otherButtonView];
    }
    _aboveView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
    _aboveView.layer.cornerRadius = 5.0;
    _aboveView.layer.masksToBounds = YES;
    [_contentView addSubview:_aboveView];
}

//set the otherButtonView height autoresizing
- (CGFloat) getOtherButtonViewHeight:(NSArray *)Array{
    CGFloat height = 44.0f;
    for (NSInteger i = 0; i < Array.count; i++) {
        NSString *otherButtonTitle = [Array objectAtIndex:i];
        CGFloat titleHeight = [self getHeightWithString:otherButtonTitle fontSize:OTHERBUTTON_FONT_SIZE width:[UIScreen mainScreen].bounds.size.width - 60];
        height += titleHeight;
    }
    height = height>[UIScreen mainScreen].bounds.size.height - 150?[UIScreen mainScreen].bounds.size.height - 150:height;
    return height;
}


- (void) initCancelButton
{
    if (_cancelButtonTitle != nil) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, contentViewHeight + SPACE_SMALL, contentViewWidth, 44)];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _cancelButton.layer.cornerRadius = 5.0;
        [_cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithRed:0 / 255.0 green:122 / 255.0 blue:255 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cancelButton];
        contentViewHeight += SPACE_SMALL + _cancelButton.frame.size.height + SPACE_SMALL;
    }
}
- (void)setCancelButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size
{
    if (color != nil) {
        [_cancelButton setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (bgcolor != nil) {
        [_cancelButton setBackgroundColor:bgcolor];
    }
    
    if (size > 0) {
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void) cancelButtonClicked:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCancel:)]) {
        [_delegate didSelectedCancel:self];
    }
    [self hide];
}
#pragma -- rewrite the setter
- (void) setTitle:(NSString *)title
{
    _title = title;
    [self initContentView];
}
- (void) setCancelButtonTitle:(NSString *)cancelButtonTitle
{
    _cancelButtonTitle = cancelButtonTitle;
    [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}


- (void) showAnimation
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height-_contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0.7;
    } completion:^(BOOL finished) {
        
    }];
}
- (void) hideAnimation
{
    [UIView animateWithDuration:0.3 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void) show
{
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
    [self showAnimation];
}
- (void) hide
{
    [self hideAnimation];
}
#pragma mark - getHeightWithString
- (CGFloat) getHeightWithString:(NSString *)string fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    if (!string.length) return CGSizeZero.height;
    CGSize size;
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES:NO)) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],UITextAttributeFont,nil];
        NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:string attributes:dict];
        NSRange range = NSMakeRange(0, atrString.length);
        NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
        size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    }else {
        size = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    }
    size.width += 20;
    return size.height;
}


#pragma mark --UITableViewDelegate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _otherButtonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"Cell";
    TRActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[TRActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.otherButtonLabel.text = _otherButtonArray[indexPath.row];
    CGFloat Height = [self getHeightWithString:_otherButtonArray[indexPath.row] fontSize:OTHERBUTTON_FONT_SIZE width:[UIScreen mainScreen].bounds.size.width - 60];
    Height = Height >44?Height:44;
    CGRect frame = cell.otherButtonLabel.frame;
    frame.size.height = Height;
    cell.otherButtonLabel.frame = frame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedActionSheetIndex:)]) {
        [_delegate didSelectedActionSheetIndex:indexPath.row];
    }
    [self hide];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *text = [_otherButtonArray objectAtIndex:indexPath.row];
    CGFloat height = [self getHeightWithString:text fontSize:OTHERBUTTON_FONT_SIZE width:[UIScreen mainScreen].bounds.size.width-60];
    height = height>44?height:44;
    return height;
}


@end
