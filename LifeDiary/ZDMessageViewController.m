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
#import "ZDAllViewController.h"
#import "ZDAddViewController.h"


@interface ZDMessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}


@end

@implementation ZDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //backBarButtonItem
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全部" style:UIBarButtonItemStylePlain target:self action:@selector(openAll)];
    //rightBarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGoods)];
    
    //_messageTableView
    _messageTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _messageTableView.dataSource = self;
    _messageTableView.delegate = self;
    _messageTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    _messageTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_messageTableView];
    [_messageTableView registerClass:[ZDMessageCell class] forCellReuseIdentifier:@"messageCell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _dataMutableArray = [NSMutableArray array];
    _dataMutableArray = [[ZDMessageDataBase sharedDataBase]getAllGoods];
    
    [UIView animateWithDuration:0.5f animations:^{
        CGRect  tabRect=self.tabBarController.tabBar.frame;
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = tabRect;
        }completion:^(BOOL finished) {
            
        }];
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
    return _dataMutableArray.count;
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
    
    ZDGoods *goods = _dataMutableArray[indexPath.row];
    
    _messageCell.nameLabel.text = goods.name;
    _messageCell.remarkLabel.text = goods.remark;
    _messageCell.imageView.image = [UIImage imageWithData:goods.imageData];
    _messageCell.dateOfstartLabel.text = goods.dateOfStart;
    _messageCell.dateOfEndLabel.text = goods.dateOfEnd;
    _messageCell.saveTimeLabel.text = goods.saveTime;
    
    return _messageCell;
    
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
