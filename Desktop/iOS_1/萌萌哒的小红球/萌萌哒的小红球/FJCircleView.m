//
//  FJCircleView.m
//  萌萌哒的小红球
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJCircleView.h"

@implementation FJCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.circleLayer = [FJCircleLayer layer];
        self.circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.circleLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}

@end
