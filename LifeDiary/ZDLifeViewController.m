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

@interface ZDLifeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) RGCardViewLayout *rgcardViewLayout;
@property(nonatomic,strong)  UISegmentedControl *segmentControl;
@end

@implementation ZDLifeViewController
static NSString *const cellId = @"collectionViewCellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title = @"发现";
    self.navigationItem.backBarButtonItem = backBtnItem;
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = TABBARCOLOR;

    ZDFindDataManager *findDataManger = [[ZDFindDataManager alloc]init];
    
    [findDataManger getData_sucessBlock:^(ZDOrderModel *model) {
        ZDBodyModel *bodyModel = [[ZDBodyModel alloc]init];
        bodyModel = model.showapi_res_body;
        ZDPagebeanModel *pagebeanModel = [[ZDPagebeanModel alloc]init];
        pagebeanModel = bodyModel.pagebean;
        
        _contentlistArray = [[NSMutableArray<ZDContentlistModel > alloc]initWithArray:pagebeanModel.contentlist];
        [self.collectionView reloadData];
    } faliure:^{
        
    } maxResult:@"10"];
    
    
    _rgcardViewLayout = [[RGCardViewLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:_rgcardViewLayout];
    _collectionView.backgroundColor = TABBARCOLOR;
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
    return _contentlistArray.count;
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
    ZDContentlistModel *contentlistModel = [[ZDContentlistModel alloc]init];
    contentlistModel = _contentlistArray[indexPath.section];
    [_collectionViewCell updateCell:contentlistModel];
    
    
    return _collectionViewCell;
}

//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZDContentlistModel *contentlist = [[ZDContentlistModel alloc]init];
    contentlist = _contentlistArray[indexPath.section];
    ZDLinkViewController *linkVC = [[ZDLinkViewController alloc]init];
    linkVC.contentlistModel = contentlist;
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
