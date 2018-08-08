//
//  ZDLinkViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/7/18.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDLinkViewController.h"
#import "ZDHtmlScrollView.h"
#import "ZDOrderModel.h"

@interface ZDLinkViewController ()

@end

@implementation ZDLinkViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    //rightBarButtonItem
    UIBarButtonItem *shareBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareToOther)];
    
    
    [shareBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:LIGHTBLUE} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = shareBarButtonItem;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _htmlScrollView = [[ZDHtmlScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [_htmlScrollView updateHtmlView:_contentlistModel];
    [self.view addSubview: _htmlScrollView];
    
    
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)shareToOther{
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    //下移tabBar
    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //上移tabBar
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
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
