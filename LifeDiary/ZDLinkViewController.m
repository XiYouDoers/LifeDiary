//
//  ZDLinkViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/7/18.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDLinkViewController.h"

@interface ZDLinkViewController ()

@end

@implementation ZDLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
//    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
//    _navView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_navView];
//
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.frame = CGRectMake(20, 20, 40, 40);
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
//    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [_navView addSubview:backButton];
//    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//
//    UIButton *qiTaButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    qiTaButton.frame = CGRectMake(WIDTH-50, 20, 40, 40);
//    [qiTaButton setTitle:@"其他" forState:UIControlStateNormal];
//    [qiTaButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [_navView addSubview:qiTaButton];
    
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

//    CGRect  tabRect = self.tabBarController.tabBar.frame;
//    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
//    [UIView animateWithDuration:0.5f animations:^{
//        self.tabBarController.tabBar.frame = tabRect;
//    }completion:^(BOOL finished) {
//        
//    }];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
