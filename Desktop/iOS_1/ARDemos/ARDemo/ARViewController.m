//
//  ARViewController.m
//  ARDemo
//
//  Created by Mac on 2017/7/29.
//  Copyright © 2017年 haofujie. All rights reserved.
//

#import "ARViewController.h"
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface ARViewController () <ARSCNViewDelegate>

///AR视图
@property (nonatomic, strong) ARSCNView *arSCNView;

///AR会话，管理相机追踪配置和3D相机坐标
@property (nonatomic, strong) ARSession *arSession;

///会话追踪配置：追踪相机运动
@property (nonatomic, strong) ARSessionConfiguration *arSessionConfig;

///模型
@property (nonatomic, strong) SCNNode *modelNode;

@end

@implementation ARViewController

- (ARSessionConfiguration *)arSessionConfig
{
    if (_arSessionConfig != nil) {
        return _arSessionConfig;
    }
    
    ARWorldTrackingSessionConfiguration *config = [[ARWorldTrackingSessionConfiguration alloc] init];
    config.planeDetection = ARPlaneDetectionHorizontal;
    _arSessionConfig = config;
    _arSessionConfig.lightEstimationEnabled = YES;
    
    return _arSessionConfig;
}

- (ARSession *)arSession
{
    if (_arSession != nil) {
        return _arSession;
    }
    _arSession = [[ARSession alloc] init];
    return _arSession;
}

- (ARSCNView *)arSCNView
{
    if (_arSCNView != nil) {
        return _arSCNView;
    }
    _arSCNView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
    _arSCNView.session = self.arSession;
    _arSCNView.autoenablesDefaultLighting = YES;
    _arSCNView.showsStatistics = YES;
    return _arSCNView;
}


- (void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
    
     [self.view addSubview:self.arSCNView];
     [self.arSession runWithConfiguration:self.arSessionConfig];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arSCNView.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SCNScene *scene = [SCNScene sceneNamed:@"Models.scnassets/chair/chair.scn"];
    
    SCNNode *modelNode = scene.rootNode.childNodes[0];
    ////    self.modelNode = modelNode;
    ////    modelNode.position = SCNVector3Make(0, 0, 0);
    [self.arSCNView.scene.rootNode addChildNode:modelNode];
    //    self.arSCNView.scene = scene;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
