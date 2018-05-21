//
//  ZDMessageViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/16.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define LIGHTBLUE [UIColor colorWithRed:0.0 green:165.0/255 blue:237.0/255 alpha:1]
#import "ZDMessageViewController.h"
#import "ZDMessageDataBase.h"
#import "ZDAllDataBase.h"
#import "ZDAllViewController.h"
#import "ZDAddViewController.h"

@interface ZDMessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
}
@property(nonatomic,strong) UISegmentedControl *segmentControl;
@end

@implementation ZDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //backBarButtonItem
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    [backBtnItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] } forState:UIControlStateNormal];
    backBtnItem.title = @"消息";
    self.navigationItem.backBarButtonItem = backBtnItem;
    //leftBarButtonItem
//    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBarButton.layer setMasksToBounds:YES];
//    [leftBarButton.layer setCornerRadius:3.0]; //设置矩圆角半径
//    [leftBarButton.layer setBorderWidth:1.0];   //边框宽度
//    [leftBarButton setTitle:@"全部" forState:UIControlStateNormal];
//    [leftBarButton setTitleColor:LIGHTBLUE forState:UIControlStateNormal];
//    [leftBarButton addTarget:self action:@selector(openAll) forControlEvents:UIControlEventTouchUpInside];
//    [leftBarButton sizeToFit];
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarButton];
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    UIBarButtonItem *allBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全部" style:UIBarButtonItemStylePlain target:self action:@selector(openAll)];
    [allBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] } forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = allBarButtonItem;

  
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    //rightBarButtonItem
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"╋" style:UIBarButtonItemStylePlain target:self action:@selector(addGoods)];
    [addBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = addBarButtonItem;
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
    _messageTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    _messageTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_messageTableView];
    [_messageTableView registerClass:[ZDMessageCell class] forCellReuseIdentifier:@"messageCell"];
    
//    //_allTableView
//    _allTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
//    _allTableView.dataSource = self;
//    _allTableView.delegate = self;
//    _allTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
//    _allTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
//    [self.view addSubview:_allTableView];
//    [_allTableView registerClass:[ZDAllCell class] forCellReuseIdentifier:@"allCell"];
//   
    


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _messageDataMutableArray = [NSMutableArray array];
    _messageDataMutableArray = [[ZDMessageDataBase sharedDataBase]getAllGoods];
    
    _AllDataMutableArray = [NSMutableArray array];
    _AllDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
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
    if (tableView==_messageTableView) {
        return _messageDataMutableArray.count;
    }else if (tableView==_allTableView){
        return _AllDataMutableArray.count;
    }else{
        return 0;
    }
    
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
    if (tableView == _messageTableView) {
        _messageCell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
        
        ZDGoods *goods = _messageDataMutableArray[indexPath.row];
        
        _messageCell.nameLabel.text = goods.name;
        _messageCell.remarkLabel.text = goods.remark;
        _messageCell.imageView.image = [UIImage imageWithData:goods.imageData];
        _messageCell.dateOfstartLabel.text = goods.dateOfStart;
        _messageCell.dateOfEndLabel.text = goods.dateOfEnd;
        _messageCell.saveTimeLabel.text = goods.saveTime;
        
        return _messageCell;

    }else if (tableView == _allTableView){
        _allCell = [tableView dequeueReusableCellWithIdentifier:@"allCell"];
        
        ZDGoods *goods = _AllDataMutableArray[indexPath.row];
        
        _allCell.nameLabel.text = goods.name;
        _allCell.remarkLabel.text = goods.remark;
        _allCell.imageView.image = [UIImage imageWithData:goods.imageData];
        _allCell.dateOfstartLabel.text = goods.dateOfStart;
        _allCell.dateOfEndLabel.text = goods.dateOfEnd;
        _allCell.saveTimeLabel.text = goods.saveTime;
        
        return _allCell;

    }else{
        return nil;
    }
    
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
