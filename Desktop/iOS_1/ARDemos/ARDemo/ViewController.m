//
//  ViewController.m
//  ARDemo
//
//  Created by Mac on 2017/7/29.
//  Copyright © 2017年 haofujie. All rights reserved.
//

#import "ViewController.h"
#import "ARViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height / 2 - 30, 100, 60)];
    [btn setTitle:@"点击进入" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(enterAR) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)enterAR
{
    ARViewController *arVc = [[ARViewController alloc] init];
    [self presentViewController:arVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
