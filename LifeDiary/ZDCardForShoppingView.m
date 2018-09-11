//
//  ZDCardForShoppingView.m
//  LifeDiary
//
//  Created by Jack on 2018/8/15.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDCardForShoppingView.h"
#import "ZDCollectionViewShoppingCell.h"
#import "ZDCollectionViewShoppingCell.h"
#import "RGCardViewLayout.h"
#import "ZDOrderModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZDShoppingModel.h"

@interface ZDCardForShoppingView ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    UICollectionView *_collectionView;
    
    CGFloat _dragStartX;
    
    CGFloat _dragEndX;
}

@property(nonatomic,strong) RGCardViewLayout *rgcardViewLayout;
@property(nonatomic,strong) ZDCollectionViewShoppingCell *collectionViewShoppingCell;
@end
static NSString *const cellIdForShopping = @"collectionViewForShoppingCellId";
@implementation ZDCardForShoppingView
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
    if (@available(iOS 11.0, *)) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_rgcardViewLayout];
    }else{
        _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:_rgcardViewLayout];
    }
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    // 开启分页
    _collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧效果
    _collectionView.bounces = YES;
    [self addSubview:_collectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[ZDCollectionViewShoppingCell class] forCellWithReuseIdentifier:cellIdForShopping];
    
}
- (NSMutableArray *)dataMutableArray{
    if (_dataMutableArray == nil) {
        _dataMutableArray = [NSMutableArray array];
    }
    return _dataMutableArray;
}
- (void)addDataMutableArray:(NSArray *)productInfoArray{
    
    if (productInfoArray.count>=1) {
        [self.dataMutableArray addObject:productInfoArray[0]];
    }
    if (productInfoArray.count>=2) {
        [self.dataMutableArray addObject:productInfoArray[1]];
    }
    if (productInfoArray.count>=3) {
        [self.dataMutableArray addObject:productInfoArray[2]];
    }

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
    return _dataMutableArray.count;
}
/**
 dataSource
 
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _collectionViewShoppingCell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellIdForShopping forIndexPath:indexPath];
    if (_dataMutableArray.count) {
  
        ZDProductInfo *productInfo = _dataMutableArray[indexPath.section];
        [_collectionViewShoppingCell updateCell:productInfo];
    }

    
    return _collectionViewShoppingCell;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
