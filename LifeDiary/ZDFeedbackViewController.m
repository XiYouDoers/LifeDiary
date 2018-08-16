//
//  ZDFeedbackViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/8/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDFeedbackViewController.h"

@interface ZDFeedbackViewController ()

@end

@implementation ZDFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"反馈";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    //隐藏tabBar
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
}
@end
