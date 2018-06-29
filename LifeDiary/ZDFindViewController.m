//
//  ZDFindViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define PURPLE [UIColor colorWithRed:98.0/255 green:54.0/255 blue:88.0/255 alpha:1]
#define LIGHTBLUE [UIColor colorWithRed:67.0/255 green:148.0/255 blue:204.0/255 alpha:1]
#import "ZDFindViewController.h"
#import "RGCardViewLayout.h"

@interface ZDFindViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) RGCardViewLayout *rgcardViewLayout;
@end

@implementation ZDFindViewController
static NSString *const cellId = @"collectionViewCellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor =[ UIColor lightGrayColor];
    
   
    _rgcardViewLayout = [[RGCardViewLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:_rgcardViewLayout];
    _collectionView.backgroundColor = BACKGROUNDCOLOR;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // 开启分页
    _collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
//    _collectionView.showsHorizontalScrollIndicator = NO;
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
    self.navigationController.navigationBar.hidden = YES;
}
/**
 numberOfSections

 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
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
    UIView  *subview = [cell.contentView viewWithTag:20];
    [subview removeFromSuperview];
    
    switch (indexPath.section) {
        case 0:
            cell.imageView.image =  [UIImage imageNamed:@"practice1"];
            cell.nameLabel.text = @"Glaciers";
            break;
        case 1:
            cell.imageView.image =  [UIImage imageNamed:@"practice2"];
            cell.nameLabel.text = @"Parrots";
            break;
        case 2:
            cell.imageView.image =  [UIImage imageNamed:@"practice3"];
            cell.nameLabel.text = @"Whales";
            break;
        case 3:
            cell.imageView.image =  [UIImage imageNamed:@"practice4"];
            cell.nameLabel.text = @"Lake View";
            break;
        case 4:
            cell.imageView.image =  [UIImage imageNamed:@"practice5"];
            break;
        default:
            break;
    }


}
//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
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
