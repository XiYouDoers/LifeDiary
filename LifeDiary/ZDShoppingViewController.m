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
    
    [self getData];
    [self setNavigationBar];
    [self addImageView];
    [self addCardForShoppingView];

}
- (void)getData{
    
    NSDictionary *dic0 = @{@"name":@"长城（GreatWall）红酒",@"price":@"168.00",@"image":@"shopping0"};
     NSDictionary *dic1 = @{@"name":@"蒙牛 纯甄 常温酸牛奶",@"price":@"89.90",@"image":@"shopping1"};
     NSDictionary *dic2 = @{@"name":@"鲁花 5S 压榨一级 花生油 4L",@"price":@"109.90",@"image":@"shopping2"};
    _dataMutableArray = [NSMutableArray arrayWithObjects:dic0,dic1,dic2, nil];

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
    
    _cardForShoppingView = [[ZDCardForShoppingView alloc]initWithFrame:CGRectMake(0, 96, WIDTH, HEIGHT-96)];
    _cardForShoppingView.delegate = self;
    [_cardForShoppingView setDataMutableArray:_dataMutableArray];
    [_cardForShoppingView setSelectedIndex:0];
    [self.view addSubview:_cardForShoppingView];
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    ZDLinkViewController *linkVC = [[ZDLinkViewController alloc]init];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    [linkVC.view addSubview:webView];
    NSArray *arrayOfHtml = [NSArray arrayWithObjects:@"https://item.jd.com/1304924.html", @"https://item.jd.com/1975749.html",@"https://item.jd.com/964416.html",nil];
    NSURL *url = [NSURL URLWithString:[arrayOfHtml objectAtIndex:indexPath.section]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    
    [self.navigationController pushViewController:linkVC animated:YES];
    
}


#pragma mark ZDCardViewDelegate 代理方法
- (void)changeBackgroundImageView:(NSInteger)index{
    
    if (_dataMutableArray.count >= index) {
        NSDictionary *dic = _dataMutableArray[index];
        [_imageView setImage:[UIImage imageNamed:dic[@"image"]]];
    }
    
}
- (void)pushToNextViewController:(NSInteger)index{
    
//    ZDContentlistModel *contentlist = [[ZDContentlistModel alloc]init];
//    contentlist = _contentlistArray[index];
//    ZDLinkViewController *linkVC = [[ZDLinkViewController alloc]init];
//    linkVC.contentlistModel = contentlist;
//    [self.navigationController pushViewController:linkVC animated:YES];
}

@end
