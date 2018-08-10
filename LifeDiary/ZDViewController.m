//
//  ZDViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDViewController.h"

@interface ZDViewController ()
@property(nonatomic,assign)  CGFloat historyY;

@end

@implementation ZDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//tabbar动态隐藏
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (_historyY+20<targetContentOffset->y)
    {
        [self setTabBarHidden:YES];
        
    }
    else if(_historyY-20>targetContentOffset->y)
    {
        [self setTabBarHidden:NO];
       
    }
    _historyY  = targetContentOffset->y;
}

//设置tabBar
- (void)setTabBarHidden:(BOOL)hidden
{
    
    CGRect  tabRect=self.tabBarController.tabBar.frame;
    
    if (hidden) {
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    } else {
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
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
