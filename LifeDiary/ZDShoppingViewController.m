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
    [_collectionView registerClass:[ZDCollectionViewCell class] forCellWithReuseIdentifier:cellId];
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
    return 6;
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
    
    _collectionViewCell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    [self configureCell:_collectionViewCell withIndexPath:indexPath];
    
    return _collectionViewCell;
}
- (void)configureCell:(ZDCollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    //    UIView  *subview = [cell.contentView viewWithTag:20];
    //    [subview removeFromSuperview];
    NSArray *array = [NSArray arrayWithObjects:@"长城（GreatWall）红酒", @"长城2（GreatWall）红酒",@"长城3（GreatWall）红酒",@"长城4（GreatWall）红酒",@"长城5（GreatWall）红酒",@"长城6（GreatWall）红酒",nil];
//    NSInteger index = arc4random_uniform(5);
    NSInteger index = 0;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"shopping%ld",index]];
    cell.nameLabel.text = [array objectAtIndex:indexPath.section];
    cell.sourceLabel.text = @"红酒 特酿3年解百纳干红葡萄酒 整箱装 750ml*6瓶";
    
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
    NSURL* url = [NSURL URLWithString:@"https://item.jd.com/1304924.html"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
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
