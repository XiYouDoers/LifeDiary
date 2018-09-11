//
//  ZDMessageCardView.m
//  LifeDiary
//
//  Created by Jack on 2018/8/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMessageCardView.h"
#import "ZDMessageCollectionViewFlowLayout.h"
#import "ZDMessageCollectionViewCell.h"
#import "MJRefresh.h"
#import "ZDAllDataBase.h"

@interface ZDMessageCardView ()<UICollectionViewDelegate,UICollectionViewDataSource>{
 
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) ZDMessageCollectionViewCell *messageCollectionViewCell;
@end
static NSString *const cellId = @"collectionViewCellId";

@implementation ZDMessageCardView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self buildUI];
    }
    return self;
}
- (void)initData{
    self.messageDataMutableArray = [[NSMutableArray alloc]init];
}
- (void)buildUI {
    [self addCollectionView];
}

- (void)addCollectionView {
    //_collectionView
    ZDMessageCollectionViewFlowLayout *messageLayout = [[ZDMessageCollectionViewFlowLayout alloc]init];
    //    SquareLayout *layout = [[SquareLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake( 0, 0, WIDTH, HEIGHT) collectionViewLayout:messageLayout];
    _collectionView.backgroundColor = [UIColor colorWithDisplayP3Red:250.0/255 green:250.0/255 blue:250.0/255 alpha:1];
    [_collectionView NightWithType:UIViewColorTypeNormal];
    //    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    // 开启分页
    //    _collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    // 设置弹簧效果
    _collectionView.bounces = YES;
    [self addSubview:_collectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[ZDMessageCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
}
- (void)setMessageDataMutableArray:(NSMutableArray *)messageDataMutableArray{

    _messageDataMutableArray = messageDataMutableArray;
    [_collectionView reloadData];
}
#pragma mark collectionView
/**
 numberOfSections
 
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
/**
 ItemsInSection
 
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.messageDataMutableArray.count;
    
}
/**
 dataSource
 
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _messageCollectionViewCell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    ZDGoods *goods = _messageDataMutableArray[indexPath.item];
    [_messageCollectionViewCell setData:goods];
    return _messageCollectionViewCell;
}


//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZDMessageCollectionViewCell *cell = (ZDMessageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (!cell. isChangeAlpha) {
        //处理点击别的item的问题
        if (self.messageDataMutableArray.count) {
            for (int i = 0;i<self.messageDataMutableArray.count;i++) {
                NSIndexPath *indexpathForOthers = [NSIndexPath indexPathForItem:i inSection:0];
                ZDMessageCollectionViewCell *cell = (ZDMessageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexpathForOthers];
                if (cell.isChangeAlpha == YES) {
                    cell.isChangeAlpha = NO;
                }
                cell.alpha = 1;
            }
        }
        cell.alpha = 0.6;
        [self.delegate notHiddenDetailView:cell selectedIndexPath:indexPath];
    }else{
        cell.alpha = 1;
        [self.delegate hiddenDetailView];
        
    }
    cell. isChangeAlpha = !cell.isChangeAlpha;
}
//#pragma mark - 下拉刷新
//- (void)addRefreshHeaderGif{
//    //MJRefreshGifHeader
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//
//        //延时1s执行
//        [NSThread sleepForTimeInterval:0.3f];
//        //隐藏底部信息栏
//        //将原来选中状态清除
//        for (int i = 0;i<self.messageDataMutableArray.count;i++) {
//            NSIndexPath *indexpathForOthers = [NSIndexPath indexPathForItem:i inSection:0];
//            ZDMessageCollectionViewCell *cell = (ZDMessageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpathForOthers];
//            if (cell.isChangeAlpha == YES) {
//                cell.isChangeAlpha = NO;
//                break;
//            }
//        }
//        [self.delegate hiddenDetailView];
//        _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
//        _messageDataMutableArray = [NSMutableArray array];
//        NSDate *dateNow = [[NSDate alloc]init];
//        for (ZDGoods *goods in _allDataMutableArray) {
//            NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
//            NSInteger seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
//            if (seconds<100) {
//                [_messageDataMutableArray addObject:goods];
//            }
//        }
//        [self.collectionView reloadData];
//        [self.collectionView.mj_header endRefreshing];
//
//    }];
//    NSMutableArray *refreshHeaderArray2 = [[NSMutableArray alloc]init];
//    [refreshHeaderArray2 addObject:[UIImage imageNamed:@"clock0"]];
//    NSMutableArray *refreshHeaderArray = [[NSMutableArray alloc]init];
//    [refreshHeaderArray addObject:[UIImage imageNamed:@"clock1"]];
//    [refreshHeaderArray addObject:[UIImage imageNamed:@"clock2"]];
//    [refreshHeaderArray addObject:[UIImage imageNamed:@"clock3"]];
//    // Set the ordinary state of animated images
//    [header setImages:refreshHeaderArray2 forState:MJRefreshStateIdle];
//    // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
//    [header setImages:refreshHeaderArray2 forState:MJRefreshStatePulling];
//    // Set the refreshing state of animated images
//    [header setImages:refreshHeaderArray forState:MJRefreshStateRefreshing];
//    // Set header
//    self.collectionView.mj_header = header;
//    // Hide the time
//    header.lastUpdatedTimeLabel.hidden = YES;
//    // Hide the status
//    header.stateLabel.hidden = NO;
//    //set title
//    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
//    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
//    [header setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
//
//    // Set font
//    header.stateLabel.font = [UIFont systemFontOfSize:17];
//    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:17];
//
//    // Set textColor
//    header.stateLabel.textColor = [UIColor lightGrayColor];
//    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
