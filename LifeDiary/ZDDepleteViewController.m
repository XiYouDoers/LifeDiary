//
//  ZDDepleteViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDDepleteViewController.h"
#import "ZDDepleteDataBase.h"

@interface ZDDepleteViewController ()

@end

@implementation ZDDepleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"过期物品";
    

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    _dataMutableArray = [NSMutableArray array];
//    _dataMutableArray = [[ZDRecycleDataBase sharedDataBase]getAllGoods];
    
        CGRect  tabRect = self.tabBarController.tabBar.frame;
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = tabRect;
        }completion:^(BOOL finished) {
            
        }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
