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

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *animationImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];


    animationImageView.image = [UIImage imageNamed:@"animationImageView"];
    animationImageView.contentMode =  UIViewContentModeScaleAspectFill;
//    ZDTimerView *timerView = [[ZDTimerView alloc]init];
//    timerView.frame = CGRectMake(WIDTH/2.0-25, HEIGHT/6*5, 50, 50);
//    [animationImageView addSubview:timerView];
    
    [self.view addSubview:animationImageView];
    self.navigationController.navigationBar.hidden = YES;
    
    //jump to main VC after 2.0s
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
        ZDTabBarViewController *tabBarVC = [[ZDTabBarViewController alloc]init];
        [self presentViewController:tabBarVC animated:YES completion:nil];
    }];

}



@end
