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
#import <TesseractOCR/TesseractOCR.h>
#import "ZDAddViewController.h"
#import "ZDAddTableHeaderView.h"

@interface ZDTabBarViewController ()<ZDHighTabBarDelegate,ZDPhotoManagerViewControllerDelegate,UIImagePickerControllerDelegate>{
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
    tabar.centerBtnIcon = @"addTabBarItemSelectedImage";
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
    [self wsf_settingController:findNavigationController tabBarTitle:nil tabBarItemImageName:@"shoppingTabBarItemImage" tabBarItemSelectedImageName:@"shoppingTabBarItemSelectedImage"
     ];
    findNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0);
    //view4
    UIViewController *vC3 = [[UIViewController alloc]init];
    UINavigationController *nVC3 = [[UINavigationController alloc]initWithRootViewController:vC3];
    [self wsf_settingController:nVC3 tabBarTitle:nil tabBarItemImageName:@"lifeTabBarItemImage" tabBarItemSelectedImageName:@"lifeTabBarItemSelectedImage"
     ];
    nVC3.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0);
    //“我”界面
    ZDMeViewController *meViewController = [[ZDMeViewController alloc]init];
    UINavigationController *meNavigationController = [[UINavigationController alloc]initWithRootViewController:meViewController];
    [self wsf_settingController:meNavigationController tabBarTitle:nil tabBarItemImageName:@"meTabBarItemImage" tabBarItemSelectedImageName:@"meTabBarItemSelectedImage"
     ];
    meNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0);
    
    self.viewControllers = @[messageNavigationController,findNavigationController,nVC3,meNavigationController];
    [[UITabBar appearance]setBarTintColor:[UIColor lightGrayColor]];
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

#pragma mark - UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
     [picker dismissViewControllerAnimated:YES completion:nil];

    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
//        [self GoToCoreML:info[@"UIImagePickerControllerOriginalImage"]];
        [self tesseractRecogniceWithImage:[UIImage imageNamed:@"1535273887355"] compleate:^(NSString *text) {
            NSLog(@"text = %@",text);
        } ];

    }else  if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
//        [self GoToCoreML:info[@"UIImagePickerControllerOriginalImage"]];
        [self tesseractRecogniceWithImage:[UIImage imageNamed:@"1535273887355"] compleate:^(NSString *text) {
            NSLog(@"text = %@",text);
        }
    ];

}

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
            NSMutableArray *muArray = [NSMutableArray array];
            ZDAddViewController *addVC = [[ZDAddViewController alloc]init];
            [muArray addObject:tempClassification.identifier];
            [self presentViewController:addVC animated:YES completion:nil];
            [addVC setGoodsInfo:muArray];
            NSLog(@"%@",[NSString stringWithFormat:@"识别结果:%@",tempClassification.identifier]);
            NSLog(@"%@",[NSString stringWithFormat:@"匹配率:%@",@(tempClassification.confidence)]);
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

/**
 文字识别

 @param image
 @param compleate
 */
- (void)tesseractRecogniceWithImage:(UIImage *)image compleate:(void(^)(NSString *text))compleate {
        G8Tesseract *tesseract = [[G8Tesseract alloc]initWithLanguage:@"eng+chi_sim"];
        //模式
        tesseract.engineMode = G8OCREngineModeTesseractOnly;
        tesseract.maximumRecognitionTime = 10;
        tesseract.pageSegmentationMode = G8PageSegmentationModeAuto;
        //灰化 如果是英文或者数字推荐使用。如果是汉字不推荐使用
//        tesseract.image = [image g8_blackAndWhite];
        tesseract.image = image;
        [tesseract recognize];
        compleate(tesseract.recognizedText);
    }
@end
