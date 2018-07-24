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
@interface ZDShoppingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) RGCardViewLayout *rgcardViewLayout;
@property(nonatomic,strong)  UISegmentedControl *segmentControl;
@end

@implementation ZDShoppingViewController
static NSString *const cellId = @"collectionViewCellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title = @"发现";
    self.navigationItem.backBarButtonItem = backBtnItem;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = BACKGROUNDCOLOR;
    
    
    _rgcardViewLayout = [[RGCardViewLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:_rgcardViewLayout];
    _collectionView.backgroundColor = BACKGROUNDCOLOR;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // 开启分页
    _collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧效果
    _collectionView.bounces = NO;
    [self.view addSubview:_collectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[ZDCollectionViewShoppingCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
/**
 numberOfSections
 
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
/**
 ItemsInSection
 
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
/**
 dataSource
 
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _collectionViewShoppingCell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    [self configureCell:_collectionViewShoppingCell withIndexPath:indexPath];
    
    return _collectionViewShoppingCell;
}
- (void)configureCell:(ZDCollectionViewShoppingCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    //    UIView  *subview = [cell.contentView viewWithTag:20];
    //    [subview removeFromSuperview];
    NSArray *nameArray = [NSArray arrayWithObjects:@"长城（GreatWall）红酒", @"蒙牛 纯甄 常温酸牛奶",@"鲁花 5S 压榨一级 花生油 4L",nil];
    NSArray *priceArray = [NSArray arrayWithObjects:@"168.00",@"89.90",@"109.90", nil];
//    NSInteger index = arc4random_uniform(5);
    NSInteger index = indexPath.section;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"shopping%ld",index]];
    cell.nameLabel.text = [nameArray objectAtIndex:indexPath.section];
    cell.priceLabel.text = [priceArray objectAtIndex:indexPath.section];
    cell.sourceLabel.text = @"京东商城";
    
}
//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
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
