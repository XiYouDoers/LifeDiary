//
//  ZDAboutViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAboutViewController.h"

@interface ZDAboutViewController ()
@property(nonatomic,strong) UILabel *projectInfoLabel;
@property(nonatomic,strong) UIImageView *projectPictureImageView;
@end

@implementation ZDAboutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    

    
    self.view.backgroundColor = [UIColor colorWithRed:237.0/255 green:237.0/255 blue:243.0/255 alpha:1];
    
    _projectInfoLabel = [[UILabel alloc]init];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.5f animations:^{
        CGRect  tabRect = self.tabBarController.tabBar.frame;
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = tabRect;
        }completion:^(BOOL finished) {
            
        }];
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
