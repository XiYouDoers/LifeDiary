//
//  ZDTabBarViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDTabBarViewController.h"
#import "ZDMessageViewController.h"
#import "ZDFindViewController.h"
#import "ZDMeViewController.h"

@interface ZDTabBarViewController ()

@end

@implementation ZDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //“消息”界面
    ZDMessageViewController *messageViewController = [[ZDMessageViewController alloc]init];
    UINavigationController *messageNavigationController = [[UINavigationController alloc]initWithRootViewController:messageViewController];
    [self wsf_settingController:messageNavigationController tabBarTitle:@"消息" tabBarItemImageName:@"messageTabBarItemImage" tabBarItemSelectedImageName:@"messageTabBarItemSelectedImage"
     ];
    //“发现”页面
    ZDFindViewController *findViewController = [[ZDFindViewController alloc]init];
    UINavigationController *findNavigationController = [[UINavigationController alloc]initWithRootViewController:findViewController];
    [self wsf_settingController:findNavigationController tabBarTitle:@"发现" tabBarItemImageName:@"findTabBarItemImage" tabBarItemSelectedImageName:@"findTabBarItemSelectedImage"
     ];
    //“我”界面
    ZDMeViewController *meViewController = [[ZDMeViewController alloc]init];
    UINavigationController *meNavigationController = [[UINavigationController alloc]initWithRootViewController:meViewController];
    [self wsf_settingController:meNavigationController tabBarTitle:@"我" tabBarItemImageName:@"meTabBarItemImage" tabBarItemSelectedImageName:@"meTabBarItemSelectedImage"
     ];
    
    self.viewControllers = @[messageNavigationController,findNavigationController,meNavigationController];
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 自定义方法，方便设置tabbar
 
 @param controller 传入的navigationController
 @param title tabbar的标题
 @param imageName tabbar静态图片
 @param selectedImageName tabbar选中时的图片
 */
- (void)wsf_settingController:(UIViewController *)controller tabBarTitle:(NSString *)title tabBarItemImageName:(NSString *)imageName tabBarItemSelectedImageName:(NSString *)selectedImageName{
    
    controller.tabBarItem.title = title;
    // 设置 tabbarItem 静态图片(不被系统默认渲染,显示图像原始颜色)
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.image = image;
    // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [controller.tabBarItem setSelectedImage:selectedImage];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *selectedDictionary = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:selectedDictionary forState:UIControlStateSelected];
    //设置tabbarItem 未选中状态下的文字颜色
    NSDictionary *normalDictionary = [NSDictionary dictionaryWithObject:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:normalDictionary forState:UIControlStateNormal];
    
    
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
