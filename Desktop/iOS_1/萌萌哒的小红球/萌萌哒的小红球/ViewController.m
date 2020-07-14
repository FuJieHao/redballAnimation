//
//  ViewController.m
//  萌萌哒的小红球
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 haofujie. All rights reserved.
//


#import "ViewController.h"
#import "FJCircleView.h"

@interface ViewController ()

@property (nonatomic,weak) FJCircleView *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISlider *silder = [[UISlider alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height - 80, self.view.frame.size.width - 40, 30)];
    [silder addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:silder];
    
    FJCircleView *circleView = [[FJCircleView alloc] initWithFrame:CGRectMake(0,0, 200, 150)];
    circleView.center = self.view.center;
    [self.view addSubview:circleView];
    circleView.circleLayer.progress = 0.5;
    self.circleView = circleView;
    
}

- (void)valueChanged:(UISlider *)sender
{
    self.circleView.circleLayer.progress = sender.value;
}

@end


















