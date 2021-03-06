//
//  ViewController.m
//  CircleSegmentControl
//
//  Created by ALittleNasty on 2017/7/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "ViewController.h"
#import "YYCircleSegmentControl.h"

@interface ViewController ()<YYCircleSegmentControlDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = @[@"LOL", @"Dota", @"CF"];
    YYCircleSegmentControl *seg = [[YYCircleSegmentControl alloc] initWithFrame:CGRectMake(80, 100, 240, 50) withTitles:titles];
    seg.delegate = self;
    [self.view addSubview:seg];
}

#pragma mark - YYCircleSegmentControlDelegate

- (void)circleSegmentControlDidSelectedAtIndex:(NSInteger)index
{
    NSLog(@"选中第--%zd--个", index);
}

@end
