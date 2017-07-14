//
//  YYCircleSegmentControl.h
//  CircleSegmentControl
//
//  Created by ALittleNasty on 2017/7/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点击事件的代理协议
 */
@protocol YYCircleSegmentControlDelegate <NSObject>

@required
- (void)circleSegmentControlDidSelectedAtIndex:(NSInteger)index;

@end

@interface YYCircleSegmentControl : UIView

/** 代理 */
@property (nonatomic, weak) id <YYCircleSegmentControlDelegate> delegate;

/**
 *  初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray <NSString *>*)titles;

@end
