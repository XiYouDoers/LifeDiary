//
//  ZDSaveViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/8/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDSaveViewController.h"

@interface ZDSaveViewController ()

@end

@implementation ZDSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    
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
