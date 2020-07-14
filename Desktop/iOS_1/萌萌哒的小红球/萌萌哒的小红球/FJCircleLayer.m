//
//  FJCircleLayer.m
//  萌萌哒的小红球
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJCircleLayer.h"
#import <UIKit/UIKit.h>

/**
 *  我在这里把这个球做成进度条驱动型的
 */

#define outsideRectSize 40

typedef enum MoveDuration{
    MoveDuration_left,
    MoveDuration_right,
}MoveDuration;

@interface FJCircleLayer ()

//首先，我先按刚才说的套路搞一个外接的矩形
@property (nonatomic,assign)CGRect outsideRect;

//移动的方向
@property (nonatomic,assign)MoveDuration moveDuration;

//这个是记录最后一次运动的点
@property (nonatomic,assign)CGFloat lastProgress;

@end

@implementation FJCircleLayer

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

//复杂的绘图方法来了
- (void)drawInContext:(CGContextRef)ctx
{
    //当然了，一会就知道不该在这里写这个啦，他会动啊
//    self.outsideRect = CGRectMake(self.position.x - outsideRectSize / 2, self.position.y - outsideRectSize / 2, outsideRectSize, outsideRectSize);
    
    //A-C1这种的距离
    CGFloat offset = self.outsideRect.size.width / 3.6;
    
    //然后计算一个比较重要的，就是移动的距离
    //哪一个值需要移动，ABCD了，AC Y值移动，BD X值移动，而且BD移动比AC的多
    CGFloat moveDistance = (self.outsideRect.size.width * 1 / 6) * fabs(self.progress - 0.5) * 2;
    
    //下面确定ABCD以及中心点位置
    CGPoint rectCenter = CGPointMake(self.outsideRect.origin.x + self.outsideRect.size.width / 2, self.outsideRect.origin.y + self.outsideRect.size.height / 2);
    
    CGPoint pointA = CGPointMake(rectCenter.x, self.outsideRect.origin.y + moveDistance);
    CGPoint pointC = CGPointMake(rectCenter.x, rectCenter.y + self.outsideRect.size.height/2 - moveDistance);
    
    //这里还需要判断一下移动的方向
    CGPoint pointB = CGPointMake((self.moveDuration == MoveDuration_right) ? rectCenter.x + self.outsideRect.size.width / 2 : self.outsideRect.size.width / 2 + rectCenter.x + moveDistance * 2, rectCenter.y);
    CGPoint pointD = CGPointMake((self.moveDuration == MoveDuration_right) ? self.outsideRect.origin.x - moveDistance * 2 : self.outsideRect.origin.x, rectCenter.y);
    
    //C1 - C8 的位置确定(左移和右移的时候Y值还是有不同的)
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, self.moveDuration == MoveDuration_right ? pointB.y - offset : pointB.y - offset + moveDistance);
    
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    CGPoint c3 = CGPointMake(pointB.x, self.moveDuration == MoveDuration_right ? pointB.y + offset : pointB.y + offset - moveDistance);
    
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, self.moveDuration == MoveDuration_right ? pointD.y + offset - moveDistance : pointD.y + offset);
    
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    CGPoint c7 = CGPointMake(pointD.x, self.moveDuration == MoveDuration_right ? pointD.y - offset + moveDistance :  pointD.y - offset);
    
    //绘制圆的路径
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath moveToPoint:pointA];
    [circlePath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [circlePath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [circlePath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [circlePath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [circlePath closePath];
    
    CGContextAddPath(ctx, circlePath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextDrawPath(ctx, kCGPathEOFillStroke);
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (progress <= 0.5) {
        self.moveDuration = MoveDuration_left;
    } else {
        self.moveDuration = MoveDuration_right;
    }
    self.lastProgress = progress;
    
    //我在这里要确定方块的位置（x,y)
    CGFloat origin_x = (self.position.x - outsideRectSize / 2) + (progress - 0.5) * (self.frame.size.width - outsideRectSize);
    //我不进行纵向运动
    CGFloat origin_y = self.position.y - outsideRectSize / 2;
    
    self.outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize);
    
    //在这里进行重绘
    [self setNeedsDisplay];
}

@end













