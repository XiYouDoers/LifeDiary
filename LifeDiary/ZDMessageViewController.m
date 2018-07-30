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
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    [self setNavigationBar];
    
    self.view.backgroundColor = TABBARCOLOR;

    //_messageTableView
    _messageTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _messageTableView.dataSource = self;
    _messageTableView.delegate = self;
    _messageTableView.backgroundColor = TABBARCOLOR;
    _messageTableView.sectionHeaderHeight = 5;
    _messageTableView.sectionFooterHeight = 5;
    _messageTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_messageTableView.bounds.size.width,0.01f)];
    _messageTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_messageTableView];
    [_messageTableView registerClass:[ZDMessageCell class] forCellReuseIdentifier:@"messageCell"];
    
    
//    [_messageCell.sumLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    //addRefreshHeaderGif
    [self addRefreshHeaderGif];



    // Do any additional setup after loading the view.
}
- (void)valueChanged:(UIStepper *)stepper{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:stepper.tag - 200];
    ZDMessageCell *cell = [_messageTableView cellForRowAtIndexPath:indexPath];
    ZDGoods *goods = _messageDataMutableArray[indexPath.section];
    cell.sumLabel.text = [NSString stringWithFormat:@"数量：%d",(int)stepper.value ];
    goods.sum = [NSString stringWithFormat:@"%d",(int)stepper.value ];
    [[ZDAllDataBase sharedDataBase]updateGoods:goods];
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"text"]) {
      
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//-(void)dealloc{
//    [_messageCell.sumLabel removeObserver:self forKeyPath:@"text" context:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setNavigationBar{
    //backBarButtonItem
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    [backBtnItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] } forState:UIControlStateNormal];
    backBtnItem.title = @"消息";
    self.navigationItem.backBarButtonItem = backBtnItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *allBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全部 ▼" style:UIBarButtonItemStylePlain target:self action:@selector(openAll)];
    [allBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] } forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = allBarButtonItem;
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //rightBarButtonItem
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"╋" style:UIBarButtonItemStylePlain target:self action:@selector(addGoods)];
    [addBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
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

#pragma mark - tableView代理方法
/**
 section中cell的数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
    
}
/**
 TableView中section的数量
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    return _messageDataMutableArray.count;
}
/**
 cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        _messageCell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
        
        ZDGoods *goods = _messageDataMutableArray[indexPath.section];
        _messageCell.nameLabel.text = goods.name;
        _messageCell.remarkLabel.text = goods.remark;
        _messageCell.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    
    NSDate *dateNow = [[NSDate alloc]init];
    NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
    NSInteger seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
        _messageCell.remainderTimeLabel.text = [NSString stringWithFormat:@"剩余：%ld天",seconds];
    _messageCell.sumLabel.text = [NSString stringWithFormat:@"数量：%@",goods.sum];
    
    //计算出保质期的时间戳
    NSDate *dateOfStart = [_formatter dateFromString:goods.dateOfStart];
    NSDate *dateOfEnd = [_formatter dateFromString:goods.dateOfEnd];
    NSTimeInterval timeIntervalOfStart = [dateOfStart timeIntervalSince1970];
    NSTimeInterval timeIntervalOfEnd = [dateOfEnd timeIntervalSince1970];
    [_messageCell setArc:goods.ratio saveTimeTimeInterval:timeIntervalOfEnd-timeIntervalOfStart];
    _messageCell.stepper.tag = 200 + indexPath.section;
    _messageCell.stepper.value = [goods.sum doubleValue];
    [_messageCell.stepper addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    return _messageCell;

        
}

/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
   
//    ZDEditViewController *editVC = [[ZDEditViewController alloc]init];
//    [self.navigationController pushViewController:editVC animated:YES];
//    
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
        [self.messageTableView reloadData];
        [self.messageTableView.mj_header endRefreshing];
        
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
    self.messageTableView.mj_header = header;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
