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
#import "ZDExpireDataBase.h"
#import "ZDDepleteDataBase.h"
#import "ZDGoods.h"

@interface ZDShoppingViewController ()<ZDCardForShoppingViewDelegate>{
    
    CGFloat _dragStartX;
    CGFloat _dragEndX;
    
}
@property(nonatomic,strong) NSMutableArray *dataMutableArray ;
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
    _dataMutableArray = [[NSMutableArray alloc]init];
    NSMutableArray *sourceMuArray = [NSMutableArray array];
    //从过期物品获取关键词
    sourceMuArray = [[ZDExpireDataBase sharedDataBase]getAllGoods];
    ZDShoppingDataManger *shoppingManger= [[ZDShoppingDataManger alloc]init];
    for (ZDGoods * goods in sourceMuArray) {
        [shoppingManger getData_sucessBlock:^(ZDShoppingModel *shoppingModel) {
            [_dataMutableArray addObject:shoppingModel.productInfo[0]];
            [_dataMutableArray addObject:shoppingModel.productInfo[1]];
            [_dataMutableArray addObject:shoppingModel.productInfo[2]];
            NSArray *dataArray = @[shoppingModel.productInfo[0],shoppingModel.productInfo[1],shoppingModel.productInfo[2]];
            //添加数据源
            [_cardForShoppingView addDataMutableArray:dataArray];
        } faliure:^{
            
        } keyString:goods.name];
    }
     //从耗尽物品获取关键词
    sourceMuArray = [[ZDDepleteDataBase sharedDataBase]getAllGoods];
    for (ZDGoods * goods in sourceMuArray) {
        [shoppingManger getData_sucessBlock:^(ZDShoppingModel *shoppingModel) {
            [_dataMutableArray addObject:shoppingModel.productInfo[0]];
            [_dataMutableArray addObject:shoppingModel.productInfo[1]];
            [_dataMutableArray addObject:shoppingModel.productInfo[2]];
            NSArray *dataArray = @[shoppingModel.productInfo[0],shoppingModel.productInfo[1],shoppingModel.productInfo[2]];
            //添加数据源
            [_cardForShoppingView addDataMutableArray:dataArray];
            
        } faliure:^{
            
        } keyString:goods.name];
    }
    [_cardForShoppingView setSelectedIndex:0];
    
}
- (void)setNavigationBar{
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title = @"商品";
    self.navigationItem.backBarButtonItem = backBtnItem;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar NightWithType:UIViewColorTypeNormal];
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




#pragma mark ZDCardForShoppingViewDelegate 代理方法

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
