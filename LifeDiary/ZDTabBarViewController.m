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
#import "ZDHighTabBar.h"
#import "ZDPhotoManagerViewController.h"

@interface ZDTabBarViewController ()<ZDHighTabBarDelegate,ZDPhotoManagerViewControllerDelegate>{
}

@end

@implementation ZDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
  
    
    // Do any additional setup after loading the view.
}
- (void)setupUI{
    [self setupVC];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    //kvo形式添加自定义的 UITabBar
    ZDHighTabBar *tabar = [ZDHighTabBar instanceCustomTabBarWithType:SamItemUIType_Five];
    tabar.centerBtnIcon = @"添加";
    tabar.tabDelegate = self;
    [self setValue:tabar forKey:@"tabBar"];
   
    
//    //自定义分割线颜色
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, WIDTH, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self.tabBar setShadowImage:img];

    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];

}

- (void)setupVC{
    //“消息”界面
    ZDMessageViewController *messageViewController = [[ZDMessageViewController alloc]init];
    UINavigationController *messageNavigationController = [[UINavigationController alloc]initWithRootViewController:messageViewController];
    [self wsf_settingController:messageNavigationController tabBarTitle:nil tabBarItemImageName:@"messageTabBarItemImage" tabBarItemSelectedImageName:@"messageTabBarItemSelectedImage"
     ];
    messageNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0);
    //“发现”页面
    ZDFindViewController *findViewController = [[ZDFindViewController alloc]init];
    UINavigationController *findNavigationController = [[UINavigationController alloc]initWithRootViewController:findViewController];
    [self wsf_settingController:findNavigationController tabBarTitle:nil tabBarItemImageName:@"findTabBarItemImage" tabBarItemSelectedImageName:@"findTabBarItemSelectedImage"
     ];
    findNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(7,-1,-7,1);
    //view4
    UIViewController *vC3 = [[UIViewController alloc]init];
    UINavigationController *nVC3 = [[UINavigationController alloc]initWithRootViewController:vC3];
    [self wsf_settingController:nVC3 tabBarTitle:nil tabBarItemImageName:@"findTabBarItemImage" tabBarItemSelectedImageName:@"findTabBarItemSelectedImage"
     ];
    nVC3.tabBarItem.imageInsets = UIEdgeInsetsMake(7,-1,-7,1);
    //“我”界面
    ZDMeViewController *meViewController = [[ZDMeViewController alloc]init];
    UINavigationController *meNavigationController = [[UINavigationController alloc]initWithRootViewController:meViewController];
    [self wsf_settingController:meNavigationController tabBarTitle:nil tabBarItemImageName:@"meTabBarItemImage" tabBarItemSelectedImageName:@"meTabBarItemSelectedImage"
     ];
    meNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(7,0,-7 ,0);
    
    self.viewControllers = @[messageNavigationController,findNavigationController,nVC3,meNavigationController];
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:[UIColor whiteColor]];
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
- (void)wsf_settingController:(UINavigationController *)controller tabBarTitle:(NSString *)title tabBarItemImageName:(NSString *)imageName tabBarItemSelectedImageName:(NSString *)selectedImageName{
    
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

    NSDictionary *selectedDictionary = [NSDictionary dictionaryWithObjectsAndKeys:LIGHTBLUE,NSForegroundColorAttributeName, [UIFont systemFontOfSize:50.0f],NSFontAttributeName,nil];
    [controller.tabBarItem setTitleTextAttributes:selectedDictionary forState:UIControlStateSelected];
    //设置tabbarItem 未选中状态下的文字颜色
    NSDictionary *normalDictionary = [NSDictionary dictionaryWithObject:[UIColor lightGrayColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:normalDictionary forState:UIControlStateNormal];
    
    //改变navigationBar中间title的颜色
    
    [controller.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: TITLECOLOR}];
    //改变navigationBar.barButtonItem的颜色
    
    [[UIBarButtonItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName: BARBUTTONITEMCOLOR} forState:UIControlStateNormal];
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
    // 为子控制器包装导航控制器
//    WBBaseNC *navigationVc = [[WBBaseNC alloc] initWithRootViewController:childVc];
//    // 添加子控制器
//    [self addChildViewController:navigationVc];
}

-(void)tabBar:(ZDHighTabBar *)tabBar clickCenterButton:(UIButton *)sender{
    ZDPhotoManagerViewController *photoManagerVC = [[ZDPhotoManagerViewController alloc]init];
    photoManagerVC.delegate = self;
    [photoManagerVC selectedWay];
}

- (void)returnImage:(UIImage *)image{
    NSLog(@"%@",image);
}
@end
