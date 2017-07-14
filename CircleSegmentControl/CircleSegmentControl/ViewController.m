//
//  ViewController.m
//  CircleSegmentControl
//
//  Created by ALittleNasty on 2017/7/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "ViewController.h"
#import "YYCircleSegmentControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = @[@"LOL", @"Dota", @"CF", @"XXX"];
    YYCircleSegmentControl *seg = [[YYCircleSegmentControl alloc] initWithFrame:CGRectMake(10, 100, 240, 50) withTitles:titles];
    [self.view addSubview:seg];
}


@end
