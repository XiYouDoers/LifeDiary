//
//  ViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ViewController.h"
#import "ZDTabBarViewController.h"
#import "ZDTimerView.h"
#import "Resnet50.h"
#import <CoreML/CoreML.h>
#import <Vision/Vision.h>
#import "ZDTextView.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *animationImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ZDTextView *text = [[ZDTextView alloc]init];
    [text  recognizeWithTesseract:[UIImage imageNamed:@"text"]];
//    [self GoToCoreML:@"clock2"];
//    [self GoToCoreML:@"goods2"];
//    [self GoToCoreML:@"goods15"];
    animationImageView.image = [UIImage imageNamed:@"animationImageView"];
    animationImageView.contentMode =  UIViewContentModeScaleAspectFill;
    ZDTimerView *timerView = [[ZDTimerView alloc]init];
    timerView.frame = CGRectMake(WIDTH/2.0-25, HEIGHT/6*5, 50, 50);
    [animationImageView addSubview:timerView];
    
    [self.view addSubview:animationImageView];
    self.navigationController.navigationBar.hidden = YES;
    
    //jump to main VC after 3.0s
    [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        ZDTabBarViewController *tabBarVC = [[ZDTabBarViewController alloc]init];
        [self presentViewController:tabBarVC animated:YES completion:nil];
    }];

}


- (void)GoToCoreML:(NSString *)str{
    if (@available(iOS 11.0, *)) {
        Resnet50 *resnetModel = [[Resnet50 alloc] init];
        UIImage *image = [UIImage imageNamed:str];
        VNCoreMLModel *vnCoreModel = [VNCoreMLModel modelForMLModel:resnetModel.model error:nil];
        
        VNCoreMLRequest *vnCoreMlRequest = [[VNCoreMLRequest alloc] initWithModel:vnCoreModel completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
            CGFloat confidence = 0.0f;
            VNClassificationObservation *tempClassification = nil;
            for (VNClassificationObservation *classification in request.results) {
                if (classification.confidence > confidence) {
                    confidence = classification.confidence;
                    tempClassification = classification;
                }
            }
            
            NSLog(@"%@",[NSString stringWithFormat:@"识别结果:%@",tempClassification.identifier]);
            NSLog(@"%@",[NSString stringWithFormat:@"匹配率:%@",@(tempClassification.confidence)]);
        }];
        
        VNImageRequestHandler *vnImageRequestHandler = [[VNImageRequestHandler alloc] initWithCGImage:image.CGImage options:nil];
        
        NSError *error = nil;
        [vnImageRequestHandler performRequests:@[vnCoreMlRequest] error:&error];
        
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
        
    } else {
        // Fallback on earlier versions
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
