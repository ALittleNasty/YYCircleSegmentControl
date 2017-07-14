//
//  YYCircleSegmentControl.m
//  CircleSegmentControl
//
//  Created by ALittleNasty on 2017/7/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "YYCircleSegmentControl.h"

static CGFloat kBorderWidth = 1.f;

@interface YYCircleSegmentControl ()

/** 标题数组 */
@property (nonatomic, copy) NSArray *titles;

/** 标题控件数组 */
@property (nonatomic, strong) NSMutableArray *titleLabels;

/** 竖直分割线的数组 */
@property (nonatomic, strong) NSMutableArray *separatorLines;

/** 遮罩 */
@property (nonatomic, strong) UIView *coverView;

/** 选中的索引 */
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation YYCircleSegmentControl

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray<NSString *> *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titles = titles;
        [self setupBackgroundCircle];
        [self setupCoverCircle];
        [self setupTitleLabel];
        [self reloadTitleLabels];
        [self hideCorrespondingVertialLine];
    }
    return self;
}

#pragma mark - Configure Subviews

/**
 *  添加外边框与内部竖直分隔条
 */
- (void)setupBackgroundCircle
{
    UIColor *color = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = kBorderWidth;
    
    if (self.titles.count > 2) {
        
        CGFloat width = self.bounds.size.width / self.titles.count;
        for (NSInteger i = 1; i < self.titles.count; i++) {
            UIView *verticalLine = [[UIView alloc] init];
            verticalLine.backgroundColor = color;
            CGFloat x = i * width;
            verticalLine.frame = CGRectMake(x, 0, 1.0, self.bounds.size.height);
            [self addSubview:verticalLine];
            [self.separatorLines addObject:verticalLine];
        }
    }
}

/**
 *  添加遮罩
 */
- (void)setupCoverCircle
{
    CGFloat width = self.bounds.size.width / self.titles.count;
    _coverView = [[UIView alloc] init];
    _coverView.backgroundColor = [UIColor whiteColor];
    _coverView.frame = CGRectMake(0, 0, width, self.bounds.size.height);
    _coverView.layer.masksToBounds = YES;
    _coverView.layer.cornerRadius = self.bounds.size.height * 0.5;
    _coverView.layer.borderWidth = kBorderWidth;
    _coverView.layer.borderColor = [UIColor redColor].CGColor;
    [self addSubview:_coverView];
}

/**
 *  添加标题
 */
- (void)setupTitleLabel
{
    CGFloat width = self.bounds.size.width / self.titles.count;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        NSString *text = self.titles[i];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = text;
        titleLabel.tag = i;
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(i * width, 0, width, self.bounds.size.height);
        [self addSubview:titleLabel];
        [self.titleLabels addObject:titleLabel];
        
        // 添加手势
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelAction:)];
        [titleLabel addGestureRecognizer:tapGesture];
    }
}

#pragma mark - Action

/**
 *  标题点击事件
 */
- (void)titleLabelAction:(UITapGestureRecognizer *)tapGesture
{
    UILabel *label = (UILabel *)tapGesture.view;
    if (label.tag == self.selectedIndex) { return; }
    
    self.selectedIndex = label.tag;
    [self reloadTitleLabels];
    if (self.titles.count > 2) {
        [self hideCorrespondingVertialLine];
    }
    
    CGFloat width = self.bounds.size.width / self.titles.count;
    CGRect frame = self.coverView.frame;
    frame.origin.x = width * _selectedIndex;
    self.coverView.frame = frame;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(circleSegmentControlDidSelectedAtIndex:)]) {
        [self.delegate circleSegmentControlDidSelectedAtIndex:self.selectedIndex];
    }
}

#pragma mark - Util

/**
 *  刷新标题样式
 */
- (void)reloadTitleLabels
{
    for (UILabel *label in self.titleLabels) {
        if (label.tag == _selectedIndex) {
            label.textColor = [UIColor redColor];
        } else {
            label.textColor = [UIColor lightGrayColor];
        }
    }
}

- (void)hideCorrespondingVertialLine
{
    if (_selectedIndex == 0) {
        
        for (NSInteger i = 0; i < self.separatorLines.count; i++) {
            UIView *line = self.separatorLines[i];
            if (i == 0) {
                line.hidden = YES;
            } else {
                line.hidden = NO;
            }
        }
    } else if (_selectedIndex == self.titles.count - 1) {
        for (NSInteger i = 0; i < self.separatorLines.count; i++) {
            UIView *line = self.separatorLines[i];
            if (i == self.separatorLines.count - 1) {
                line.hidden = YES;
            } else {
                line.hidden = NO;
            }
        }
    } else {
        for (NSInteger i = 0; i < self.separatorLines.count; i++) {
            UIView *line = self.separatorLines[i];
            if ((i == self.selectedIndex - 1) || (i == self.selectedIndex)) {
                line.hidden = YES;
            } else {
                line.hidden = NO;
            }
        }
    }
}

#pragma mark - Lazy Load

- (NSMutableArray *)titleLabels
{
    if (!_titleLabels) {
        
        _titleLabels = [NSMutableArray array];
    }
    
    return _titleLabels;
}

- (NSMutableArray *)separatorLines
{
    if (!_separatorLines) {
        
        _separatorLines = [NSMutableArray array];
    }
    
    return _separatorLines;
}


@end
