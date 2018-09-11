//
//  ZDLifeViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/7/23.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDLifeViewController.h"
#import "RGCardViewLayout.h"
#import "ZDFindDataManager.h"
#import <WebKit/WebKit.h>
#import "ZDLinkViewController.h"
#import "ZDShoppingViewController.h"
#import "ZDCollectionViewCell.h"
#import "ZDOrderModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZDCardView.h"

@interface ZDLifeViewController ()<ZDCardViewDelegate>{
    
    CGFloat _dragStartX;
    CGFloat _dragEndX;

}
@property(nonatomic,strong) NSMutableArray <ZDContentlistModel > *contentlistArray;
@property(nonatomic,strong)  UISegmentedControl *segmentControl;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) ZDCardView *cardView;
@end
@implementation ZDLifeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    [self getData];
    [self addImageView];
    [self addCardView];
   
}
- (void)setNavigationBar{
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title = @"发现";
    self.navigationItem.backBarButtonItem = backBtnItem;
    self.navigationItem.title = @"生活";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar NightWithType:UIViewColorTypeNormal];
}

- (void)getData{
    ZDFindDataManager *findDataManger = [[ZDFindDataManager alloc]init];
    
    [findDataManger getData_sucessBlock:^(ZDOrderModel *model) {

        ZDBodyModel *bodyModel = [[ZDBodyModel alloc]init];
        bodyModel = model.showapi_res_body;
        ZDPagebeanModel *pagebeanModel = [[ZDPagebeanModel alloc]init];
        pagebeanModel = bodyModel.pagebean;
        
        _contentlistArray = [[NSMutableArray<ZDContentlistModel > alloc]initWithArray:pagebeanModel.contentlist];
        //初始化数据源
        [_cardView setContentlistArray:_contentlistArray];
        [_cardView setSelectedIndex:0];
      
    } faliure:^{
        
    } maxResult:@"10"];
}

- (void)addImageView {
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_imageView];
    
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _imageView.bounds;
    [_imageView addSubview:effectView];
}

- (void)addCardView{
    
    _cardView = [[ZDCardView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _cardView.delegate = self;
    [self.view addSubview:_cardView];


}

#pragma mark ZDCardViewDelegate 代理方法
- (void)changeBackgroundImageView:(NSInteger)index{

    [_imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"life%ld",index]]];
    
}

- (void)pushToNextViewController:(NSInteger)index{
    
    ZDContentlistModel *contentlist = [[ZDContentlistModel alloc]init];
    contentlist = _contentlistArray[index];
    ZDLinkViewController *linkVC = [[ZDLinkViewController alloc]init];
    linkVC.contentlistModel = contentlist;
    [self.navigationController pushViewController:linkVC animated:YES];
}

@end
