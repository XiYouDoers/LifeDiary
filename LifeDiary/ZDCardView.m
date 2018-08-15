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
    
    CGFloat _dragStartX;
    
    CGFloat _dragEndX;
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _contentlistArray.count;
}
/**
 dataSource

 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _collectionViewCell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellIdForLife forIndexPath:indexPath];
    ZDContentlistModel *contentlistModel = _contentlistArray[indexPath.row];
    [_collectionViewCell updateCell:contentlistModel];

    return _collectionViewCell;
}
//手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    _dragStartX = scrollView.contentOffset.x;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
    
}
//滚动到中间
- (void)scrollToCenter {
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.delegate changeBackgroundImageView:_selectedIndex];
}
//配置cell居中
- (void)fixCellToCenter {
    //最小滚动距离
    float dragMiniDistance = self.frame.size.width/20.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _selectedIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _selectedIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex;
    _selectedIndex = _selectedIndex >= maxIndex ? maxIndex : _selectedIndex;
    [self scrollToCenter];
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [self.delegate changeBackgroundImageView:_selectedIndex];
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    _selectedIndex = indexPath.item;
    [self scrollToCenter];
    [self.delegate pushToNextViewController:indexPath.item];
}


@end
