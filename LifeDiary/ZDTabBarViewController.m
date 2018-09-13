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
#import "Resnet50.h"
#import <CoreML/CoreML.h>
#import <Vision/Vision.h>

#import "ZDAddViewController.h"
#import "ZDAddTableHeaderView.h"
#import "ZDTextRecognitionView.h"
#import "ZDPickerViewController.h"
#import "ZDGoods.h"
#import "ZDTranslateDataManager.h"
#import "ZDStringManager.h"
#import "HUDUtil.h"

typedef NS_ENUM(NSInteger,RECOgnitionMode){
    RECOgnitionForTextMode,
    RECOgnitionForImageMode,
};
@interface ZDTabBarViewController ()<ZDHighTabBarDelegate,ZDPhotoManagerViewControllerDelegate,UIImagePickerControllerDelegate,ZDImageRecognitionDelegate,ZDTextRecognitionViewDelegate,ZDAddVCDelegate>{
    RECOgnitionMode recognitionMode;
    ZDTextRecognitionView *textReView;
}

@end

@implementation ZDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
  
}
- (void)setupUI{
    
    //kvo形式添加自定义的 UITabBar
    ZDHighTabBar *tabar = [ZDHighTabBar instanceCustomTabBarWithType:SamItemUIType_Three];
    tabar.centerBtnIcon = @"fff";
    tabar.tabDelegate = self;
    tabar.selectedItem = 0;
    [self setValue:tabar forKey:@"tabBar"];
    
    [self setupVC];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
//    //自定义分割线颜色
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, WIDTH, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self.tabBar setShadowImage:img];

    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    [self.tabBar NightWithType:UIViewColorType2];
    
}

- (void)setupVC{
    
    
    //“消息”界面
    ZDMessageViewController *messageViewController = [[ZDMessageViewController alloc]init];

    UINavigationController *messageNavigationController = [[UINavigationController alloc]initWithRootViewController:messageViewController];
//     [messageNavigationController.navigationBar NightWithType:UIViewColorTypeNormal];
    [self wsf_settingController:messageNavigationController tabBarTitle:nil tabBarItemImageName:@"messageTabBarItemImage" tabBarItemSelectedImageName:@"messageTabBarItemSelectedImage"
     ];
    messageNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6,-5,-6,5);
    
    //“发现”页面
    ZDFindViewController *findViewController = [[ZDFindViewController alloc]init];
    UINavigationController *findNavigationController = [[UINavigationController alloc]initWithRootViewController:findViewController];
     [findNavigationController.navigationBar NightWithType:UIViewColorTypeNormal];
    [self wsf_settingController:findNavigationController tabBarTitle:nil tabBarItemImageName:@"findTabBarItemImage" tabBarItemSelectedImageName:@"findTabBarItemSelectedImage"
     ];
    findNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6,5,-6,-5);
    
    
    self.viewControllers = @[messageNavigationController,findNavigationController];
//    [[UITabBar appearance]setBarTintColor:[UIColor colorWithRed:236/255.0 green:235/255.0 blue:241/255.0 alpha:1]];
    [[UITabBar appearance]setBackgroundColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:[UIColor whiteColor]];
//    [self.tabBar NightWithType:UIViewColorTypeNormal];
    
    
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

- (void)tabBar:(ZDHighTabBar *)tabBar clickCenterButton:(UIButton *)sender{
    
    ZDPhotoManagerViewController *photoManagerVC = [[ZDPhotoManagerViewController alloc]init];
    photoManagerVC.delegate = self;
    [photoManagerVC selectedWay];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
     [picker dismissViewControllerAnimated:YES completion:nil];

    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        if (recognitionMode == RECOgnitionForImageMode)
        {
            [HUDUtil show:self.view text:@"正在识别..."];
            //图像识别
            [self GoToCoreML:info[@"UIImagePickerControllerEditedImage"]];
            NSLog(@"图像识别");
            recognitionMode = RECOgnitionForTextMode;
            
        }else  if (recognitionMode == RECOgnitionForTextMode){
            
            NSLog(@"文字识别");
            //文字识别
            textReView = [[ZDTextRecognitionView alloc]init];
            textReView.delegate = self;
            [textReView setData:info[@"UIImagePickerControllerEditedImage"]];
            [HUDUtil show:self.view text:@"正在识别..."];
            [textReView recognitionForText];
  
        }
    }else  if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        NSLog(@"文字识别");
        //文字识别
        textReView = [[ZDTextRecognitionView alloc]init];
        textReView.delegate = self;
        [textReView setData:info[@"UIImagePickerControllerEditedImage"]];
        [HUDUtil show:self.view text:@"正在识别..."];
        [textReView recognitionForText];
        
    }

}
- (void)exhibitSucceed{
    [HUDUtil show:self.view text:@"添加成功"];
}
- (void)jumpToAddVC{

    ZDAddViewController *addVC = [[ZDAddViewController alloc]init];
    addVC.delegate = self;
    [addVC setGoodsInfo:textReView.goods];
    [self presentViewController:addVC animated:YES completion:nil];
    [HUDUtil show:addVC.view text:@"识别成功"];
}
- (void)textButtonWasClicked{
     recognitionMode = RECOgnitionForTextMode;
}
- (void)imageButtonWasClicked{
    recognitionMode = RECOgnitionForImageMode;
}

- (void)GoToCoreML:(UIImage *)image{
    if (@available(iOS 11.0, *)) {
        Resnet50 *resnetModel = [[Resnet50 alloc] init];
        VNCoreMLModel *vnCoreModel = [VNCoreMLModel modelForMLModel:resnetModel.model error:nil];
        
        VNCoreMLRequest *vnCoreMlRequest = [[VNCoreMLRequest alloc] initWithModel:vnCoreModel completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
            CGFloat confidence = 0.0f;
            VNClassificationObservation *tempClassification = nil;
            for (VNClassificationObservation *classification in request.results) {
                if (classification.confidence > confidence) {
                    confidence = classification.confidence;
                    tempClassification = classification;
                }
            }
            ZDGoods *goods = [[ZDGoods alloc]init];
            ZDAddViewController *addVC = [[ZDAddViewController alloc]init];
            //去除空格
            NSString *sourceString = [ZDStringManager deleteSpace:tempClassification.identifier];
            //翻译
            ZDTranslateDataManager *mange = [[ZDTranslateDataManager alloc]init];
            [mange getData_sucessBlock:^(NSString *result) {
                goods.imageData = UIImagePNGRepresentation(image);
                goods.name = result;
                [addVC setGoodsInfo:goods];
                [self presentViewController:addVC animated:YES completion:nil];
                [HUDUtil show:addVC.view text:@"识别成功"];
            } faliure:^{
                [HUDUtil show:addVC.view text:@"识别失败"];
            } sourceString:sourceString];
        

        }];
        
        VNImageRequestHandler *vnImageRequestHandler = [[VNImageRequestHandler alloc] initWithCGImage:image.CGImage options:nil];
        
        NSError *error = nil;
        [vnImageRequestHandler performRequests:@[vnCoreMlRequest] error:&error];
        
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
        
    } else {
        // Fallback on earlier versions
    }
}


@end
