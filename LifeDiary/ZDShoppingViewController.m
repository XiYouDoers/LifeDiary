//
//  ZDShoppingViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/7/23.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDShoppingViewController.h"
#import "RGCardViewLayout.h"
#import "ZDFindDataManager.h"
#import <WebKit/WebKit.h>
#import "ZDLinkViewController.h"
#import "ZDShoppingViewController.h"
#import "ZDCollectionViewShoppingCell.h"
#import "ZDOrderModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZDCardForShoppingView.h"
#import "ZDShoppingDataManger.h"
#import "ZDShoppingModel.h"
#import "ZDLinkForShoppingViewController.h"

@interface ZDShoppingViewController ()<ZDCardForShoppingViewDelegate>{
    
    CGFloat _dragStartX;
    CGFloat _dragEndX;
    
}
@property(nonatomic,strong) NSMutableArray <ZDProductInfo>*dataMutableArray ;
@property(nonatomic,strong)  UISegmentedControl *segmentControl;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) ZDCardForShoppingView *cardForShoppingView;
@end
@implementation ZDShoppingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self setNavigationBar];
    [self getData];
    [self addImageView];
    [self addCardForShoppingView];
    
}
- (void)getData{
    ZDShoppingDataManger *shoppingManger= [[ZDShoppingDataManger alloc]init];
    [shoppingManger getData_sucessBlock:^(ZDShoppingModel *shoppingModel){
        _dataMutableArray = [[NSMutableArray<ZDProductInfo> alloc]initWithArray:shoppingModel.productInfo];

        //初始化数据源
        [_cardForShoppingView setDataMutableArray:_dataMutableArray];
        [_cardForShoppingView setSelectedIndex:0];
        
    } faliure:^{
        
    }];
//    NSDictionary *dic0 = @{@"name":@"长城（GreatWall）红酒",@"price":@"168.00",@"image":@"shopping0"};
//     NSDictionary *dic1 = @{@"name":@"蒙牛 纯甄 常温酸牛奶",@"price":@"89.90",@"image":@"shopping1"};
//     NSDictionary *dic2 = @{@"name":@"鲁花 5S 压榨一级 花生油 4L",@"price":@"109.90",@"image":@"shopping2"};

}
- (void)setNavigationBar{
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title = @"商品";
    self.navigationItem.backBarButtonItem = backBtnItem;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}
- (void)addImageView {
     
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_imageView];
    
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _imageView.bounds;
    [_imageView addSubview:effectView];
}

- (void)addCardForShoppingView{
    
    _cardForShoppingView = [[ZDCardForShoppingView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _cardForShoppingView.delegate = self;
    
    [self.view addSubview:_cardForShoppingView];
    
}




#pragma mark ZDCardViewDelegate 代理方法

- (void)changeBackgroundImageView:(NSInteger)index{
    
    if (_dataMutableArray.count >= index) {
        ZDProductInfo *productInfo = _dataMutableArray[index];
        [_imageView sd_setImageWithURL:productInfo.imageUrl];
    }
    
}
- (void)pushToNextViewController:(NSInteger)index{
    
    ZDProductInfo *productInfo = _dataMutableArray[index];
    ZDLinkForShoppingViewController *linkVC = [[ZDLinkForShoppingViewController alloc]init];
    linkVC.productInfo = productInfo;
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-14)];
    //    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [linkVC.view addSubview:webView];
    NSURL* url = productInfo.url;//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    [self.navigationController pushViewController:linkVC animated:YES];
}

@end
