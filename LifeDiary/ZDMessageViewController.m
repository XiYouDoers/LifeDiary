//
//  ZDMessageViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/16.
//  Copyright © 2018年 JACK. All rights reserved.
//


#define HEIGHT_REFRESH 64+50.f
#import "ZDMessageViewController.h"
#import "ZDMessageDataBase.h"
#import "ZDAllDataBase.h"
#import "ZDExpireDataBase.h"
#import "ZDDepleteDataBase.h"
#import "ZDAllViewController.h"
#import "ZDAddViewController.h"
#import "MJRefresh.h"
#import "ZDEditViewController.h"
#import "ZDMessageCollectionViewFlowLayout.h"

@interface ZDMessageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSDateFormatter *_formatter;
}
@property(nonatomic,strong) UISegmentedControl *segmentControl;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) NSMutableArray *allDataMutableArray;
@end
static NSString *const cellId = @"collectionViewCellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";
@implementation ZDMessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    [self setNavigationBar];
    
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    //    [_messageCell.sumLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    //_collectionView
    ZDMessageCollectionViewFlowLayout *messageLayout = [[ZDMessageCollectionViewFlowLayout alloc]init];
    //    SquareLayout *layout = [[SquareLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:messageLayout];
    self.automaticallyAdjustsScrollViewInsets= NO;
    //    self.navigationController.navigationBar.translucent = NO;
    _collectionView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // 开启分页
    //    _collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧效果
    _collectionView.bounces = YES;
    [self.view addSubview:_collectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[ZDMessageCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
    //addRefreshHeaderGif
    [self addRefreshHeaderGif];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)valueChanged:(UIStepper *)stepper{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:stepper.tag - 200 inSection:0];
    ZDMessageCollectionViewCell *cell = (ZDMessageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.sumLabel.text = [NSString stringWithFormat:@"数量：%d",(int)stepper.value ];
    ZDGoods *goods = _messageDataMutableArray[indexPath.item];
    goods.sum = [NSString stringWithFormat:@"%d",(int)stepper.value ];
    [[ZDAllDataBase sharedDataBase]updateGoods:goods];
    
}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//
//    if ([keyPath isEqualToString:@"text"]) {
//
//    }else{
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setNavigationBar{
    //backBarButtonItem
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    [backBtnItem setTitleTextAttributes:@{NSForegroundColorAttributeName:LIGHTBLUE } forState:UIControlStateNormal];
    backBtnItem.title = @"消息";
    self.navigationItem.backBarButtonItem = backBtnItem;
    self.navigationController.navigationBar.tintColor = LIGHTBLUE;
    
    
    UIBarButtonItem *allBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全部" style:UIBarButtonItemStylePlain target:self action:@selector(openAll)];
    
    [allBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:LIGHTBLUE} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = allBarButtonItem;
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:LIGHTBLUE}];
    
    //rightBarButtonItem
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGoods)];
    
    [addBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:LIGHTBLUE} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
}


- (void)openAll{
    
    ZDAllViewController *allViewController = [[ZDAllViewController alloc]init];
    [self.navigationController pushViewController:allViewController animated:YES];
}
- (void)addGoods{
    ZDAddViewController *addViewController = [[ZDAddViewController alloc]init];
    [self.navigationController pushViewController:addViewController animated:YES];
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
    _messageCollectionViewCell.nameLabel.text = goods.name;
    _messageCollectionViewCell.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    if (indexPath.item == 0) {
        _messageCollectionViewCell.nameLabel.font = [UIFont boldSystemFontOfSize:23];
        _messageCollectionViewCell.nameLabel.text = @"DELICIOUS FOOD";
    }else{
        _messageCollectionViewCell.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    
    
    _messageCollectionViewCell.remarkLabel.text = goods.remark;
    _messageCollectionViewCell.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    
    NSDate *dateNow = [[NSDate alloc]init];
    NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
    NSInteger seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
    _messageCollectionViewCell.remainderTimeLabel.text = [NSString stringWithFormat:@"剩余：%ld天",seconds];
    _messageCollectionViewCell.sumLabel.text = [NSString stringWithFormat:@"数量：%@",goods.sum];
    
    //计算出保质期的时间戳
    //        NSDate *dateOfStart = [_formatter dateFromString:goods.dateOfStart];
    //        NSDate *dateOfEnd = [_formatter dateFromString:goods.dateOfEnd];
    //        NSTimeInterval timeIntervalOfStart = [dateOfStart timeIntervalSince1970];
    //        NSTimeInterval timeIntervalOfEnd = [dateOfEnd timeIntervalSince1970];
    //        [_messageCollectionViewCell setArc:goods.ratio saveTimeTimeInterval:timeIntervalOfEnd-timeIntervalOfStart];
    _messageCollectionViewCell.stepper.tag = 200 + indexPath.row;
    _messageCollectionViewCell.stepper.value = [goods.sum doubleValue];
    [_messageCollectionViewCell.stepper addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    return _messageCollectionViewCell;
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
    //    [headerView addSubview:_searchView];
    return headerView;
    
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZDMessageCollectionViewCell *cell = (ZDMessageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (!cell. isChangeAlpha) {
        
        cell.alpha = 1;
        //        cell.detailView.hidden = NO;
    }else{
        
        cell.alpha = 1;
        //        cell.detailView.hidden = YES;
    }
    cell. isChangeAlpha = !cell.isChangeAlpha;
    
    
}
#pragma mark - 下拉刷新
- (void)addRefreshHeaderGif{
    //MJRefreshGifHeader
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //延时1s执行
        [NSThread sleepForTimeInterval:0.3f];
        _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
        _messageDataMutableArray = [NSMutableArray array];
        NSDate *dateNow = [[NSDate alloc]init];
        for (ZDGoods *goods in _allDataMutableArray) {
            NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
            NSInteger seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
            if (seconds<100) {
                [_messageDataMutableArray addObject:goods];
            }
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        
    }];
    NSMutableArray *refreshHeaderArray2 = [[NSMutableArray alloc]init];
    [refreshHeaderArray2 addObject:[UIImage imageNamed:@"clock0"]];
    NSMutableArray *refreshHeaderArray = [[NSMutableArray alloc]init];
    [refreshHeaderArray addObject:[UIImage imageNamed:@"clock1"]];
    [refreshHeaderArray addObject:[UIImage imageNamed:@"clock2"]];
    [refreshHeaderArray addObject:[UIImage imageNamed:@"clock3"]];
    // Set the ordinary state of animated images
    [header setImages:refreshHeaderArray2 forState:MJRefreshStateIdle];
    // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
    [header setImages:refreshHeaderArray2 forState:MJRefreshStatePulling];
    // Set the refreshing state of animated images
    [header setImages:refreshHeaderArray forState:MJRefreshStateRefreshing];
    // Set header
    self.collectionView.mj_header = header;
    // Hide the time
    header.lastUpdatedTimeLabel.hidden = YES;
    // Hide the status
    header.stateLabel.hidden = NO;
    //set title
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:17];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:17];
    
    // Set textColor
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _messageDataMutableArray = [NSMutableArray array];
    
    _allDataMutableArray = [NSMutableArray array];
    _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
    NSDate *dateNow = [[NSDate alloc]init];
    
    for (ZDGoods *goods in _allDataMutableArray) {
        
        //判断是否加入耗尽数据库
        if ([goods.sum isEqualToString:@"0"]||[goods.sum isEqualToString:@""]) {
            int key=0;
            //根据identifier判断是否存在于全部数据库中
            for (ZDGoods *expireGoods in _allDataMutableArray) {
                
                if (goods == expireGoods) {
                    key=1;
                }
            }
            
            if (key) {
                //耗尽数据库中添加物品
                [[ZDExpireDataBase sharedDataBase]addGoods:goods];
                //全部物品数据库中删除物品
                [[ZDAllDataBase sharedDataBase]deleteGoods:goods];
                _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
            }
        }
        
        NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
        NSTimeInterval seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
        //判断是否加入过期数据库
        
        
        if (seconds<=0){
            
            int key=0;
            //根据identifier判断是否存在于全部数据库中
            
            for (ZDGoods *depleteGoods in _allDataMutableArray) {
                
                if (goods == depleteGoods) {
                    
                    key = 1;
                }
            }
            
            if (key) {
                //过期数据库中添加物品
                [[ZDDepleteDataBase sharedDataBase]addGoods:goods];
                //全部物品数据库中删除物品
                [[ZDAllDataBase sharedDataBase]deleteGoods:goods];
                _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
            }
        }else if (seconds<100 ) {
            [_messageDataMutableArray addObject:goods];
        }
        
    }
    
    [self.collectionView reloadData];
    //显示tabBar
    CGRect  tabRect=self.tabBarController.tabBar.frame;
    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
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
