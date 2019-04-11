//
//  ZDCardView.m
//  LifeDiary
//
//  Created by Jack on 2018/8/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDCardView.h"
#import "ZDCollectionViewCell.h"
#import "ZDCollectionViewShoppingCell.h"
#import "RGCardViewLayout.h"
#import "ZDOrderModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ZDCardView ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    UICollectionView *_collectionView;
}

@property(nonatomic,strong) RGCardViewLayout *rgcardViewLayout;
@property(nonatomic,strong) ZDCollectionViewCell *collectionViewCell;



@end
static NSString *const cellIdForLife = @"collectionViewForLifeCellId";
@implementation ZDCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    
    [self addCollectionView];
}

- (void)addCollectionView{
    
    _rgcardViewLayout = [[RGCardViewLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_rgcardViewLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    // 开启分页
    _collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    // 设置弹簧效果
    _collectionView.bounces = YES;
    [self addSubview:_collectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[ZDCollectionViewCell class] forCellWithReuseIdentifier:cellIdForLife];
    
}

- (void)setContentlistArray:(NSMutableArray<ZDContentlistModel> *)contentlistArray{
    _contentlistArray = contentlistArray;
    [_collectionView reloadData];
}

#pragma mark collectionViewDataSource
/**
 ItemsInSection
 
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
/**
 Sections
 
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _contentlistArray.count;
}
/**
 dataSource
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _collectionViewCell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellIdForLife forIndexPath:indexPath];
    ZDContentlistModel *contentlistModel = _contentlistArray[indexPath.section];
    [_collectionViewCell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"life%ld",indexPath.section]]];
    [_collectionViewCell updateCell:contentlistModel];

    return _collectionViewCell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _selectedIndex = scrollView.contentOffset.x / WIDTH;
    [self setSelectedIndex:_selectedIndex];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    [self.delegate changeBackgroundImageView:_selectedIndex];
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.delegate pushToNextViewController:indexPath.section];
}


@end
