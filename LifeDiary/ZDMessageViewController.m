//
//  ZDMessageViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/16.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define LIGHTBLUE [UIColor colorWithRed:0.0 green:165.0/255 blue:237.0/255 alpha:1]
#define HEIGHT_REFRESH 64+50.f
#import "ZDMessageViewController.h"
#import "ZDMessageDataBase.h"
#import "ZDAllDataBase.h"
#import "ZDAllViewController.h"
#import "ZDAddViewController.h"
#import "MJRefresh.h"

@interface ZDMessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSDateFormatter *_formatter;
}
@property(nonatomic,strong) UISegmentedControl *segmentControl;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) NSMutableArray *allDataMutableArray;
@end

@implementation ZDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    [self setNavigationBar];
//    //_segmentControl
//    _segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"当前",@"全部" ]];
//    _segmentControl.frame = CGRectMake(60, 100, 100, 32);
//    self.navigationItem.titleView = _segmentControl;
//    _segmentControl.selectedSegmentIndex=0;
//    _segmentControl.tintColor=[UIColor blueColor];
//    [_segmentControl addTarget:self action:@selector(doSomethingInSegment:) forControlEvents:UIControlEventValueChanged];
    
    //_messageTableView
    _messageTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _messageTableView.dataSource = self;
    _messageTableView.delegate = self;
//    _messageTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    _messageTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_messageTableView];
    [_messageTableView registerClass:[ZDMessageCell class] forCellReuseIdentifier:@"messageCell"];
    //addRefreshHeaderGif
    [self addRefreshHeaderGif];



    // Do any additional setup after loading the view.
}

- (void)setNavigationBar{
    //backBarButtonItem
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    [backBtnItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] } forState:UIControlStateNormal];
    backBtnItem.title = @"消息";
    self.navigationItem.backBarButtonItem = backBtnItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *allBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全部" style:UIBarButtonItemStylePlain target:self action:@selector(openAll)];
    [allBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] } forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = allBarButtonItem;
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //rightBarButtonItem
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"╋" style:UIBarButtonItemStylePlain target:self action:@selector(addGoods)];
    [addBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
}




-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            _messageTableView.hidden = NO;
            _allTableView.hidden = YES;
            [_messageTableView reloadData];
            
            break;
        case 1:
            _messageTableView.hidden = YES;
            _allTableView.hidden = NO;
            [_allTableView reloadData];

            break;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    _messageDataMutableArray = [NSMutableArray array];
    
    _allDataMutableArray = [NSMutableArray array];
    _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
    NSDate *dateNow = [[NSDate alloc]init];
    for (ZDGoods *goods in _allDataMutableArray) {
        NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
        NSInteger seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
        if (seconds<100) {
            [_messageDataMutableArray addObject:goods];
        }
    }
    [self.messageTableView reloadData];

 
    
        //显示tabBar
        CGRect  tabRect=self.tabBarController.tabBar.frame;
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = tabRect;
        }completion:^(BOOL finished) {
            
        }];
    
   
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (void)openAll{
    
    ZDAllViewController *allViewController = [[ZDAllViewController alloc]init];
    [self.navigationController pushViewController:allViewController animated:YES];
}
- (void)addGoods{
    ZDAddViewController *addViewController = [[ZDAddViewController alloc]init];
    [self.navigationController pushViewController:addViewController animated:YES];
}
/**
 section中cell的数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _messageDataMutableArray.count;
    
}
/**
 TableView中section的数量
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    return 1;
}
/**
 cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        _messageCell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
        
        ZDGoods *goods = _messageDataMutableArray[indexPath.row];
        _messageCell.nameLabel.text = goods.name;
        _messageCell.remarkLabel.text = goods.remark;
        _messageCell.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    _messageCell.dateOfstartLabel.text = [NSString stringWithFormat:@"起始： %@",goods.dateOfStart];
        _messageCell.dateOfEndLabel.text = [NSString stringWithFormat:@"截止： %@",goods.dateOfEnd];
        _messageCell.saveTimeLabel.text = [NSString stringWithFormat:@"保质期： %@",goods.saveTime];
    //计算出保质期的时间戳
    NSDate *dateOfStart = [_formatter dateFromString:goods.dateOfStart];
    NSDate *dateOfEnd = [_formatter dateFromString:goods.dateOfEnd];
    NSTimeInterval timeIntervalOfStart = [dateOfStart timeIntervalSince1970];
    NSTimeInterval timeIntervalOfEnd = [dateOfEnd timeIntervalSince1970];
    [_messageCell setArc:goods.ratio saveTimeTimeInterval:timeIntervalOfEnd-timeIntervalOfStart];
    
    return _messageCell;

        
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     ZDAllCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedCell.selected) {
        selectedCell.selected = !selectedCell.selected;
    }
}
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
        [self.messageTableView reloadData];
        [self.messageTableView.mj_header endRefreshing];
        
    }];
    NSMutableArray *refreshHeaderArray = [[NSMutableArray alloc]init];
    [refreshHeaderArray addObject:[UIImage imageNamed:@"UFO"]];
    [refreshHeaderArray addObject:[UIImage imageNamed:@"UFO"]];
    // Set the ordinary state of animated images
    [header setImages:refreshHeaderArray forState:MJRefreshStateIdle];
    // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
    [header setImages:refreshHeaderArray forState:MJRefreshStatePulling];
    // Set the refreshing state of animated images
    [header setImages:refreshHeaderArray forState:MJRefreshStateRefreshing];
    // Set header
    self.messageTableView.mj_header = header;
    // Hide the time
    header.lastUpdatedTimeLabel.hidden = YES;
    // Hide the status
    header.stateLabel.hidden = NO;
    //set title
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"努力加载中..." forState:MJRefreshStateRefreshing];
    
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:17];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:17];
    
    // Set textColor
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
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
