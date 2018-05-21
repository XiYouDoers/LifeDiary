//
//  ZDAllViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ZDAllViewController.h"
#import "ZDAllDataBase.h"
#import "ZDRecycleDataBase.h"
#import "ZDRoundView.h"

@interface ZDAllViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}


@end

@implementation ZDAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //_allTableView
    self.navigationItem.title = @"全部物品";

    _allTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _allTableView.dataSource = self;
    _allTableView.delegate = self;
    _allTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    _allTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_allTableView];
    [_allTableView registerClass:[ZDAllCell class] forCellReuseIdentifier:@"allCell"];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _dataMutableArray = [NSMutableArray array];
    _dataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
    //隐藏tabBar
        CGRect  tabRect = self.tabBarController.tabBar.frame;
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = tabRect;
        }completion:^(BOOL finished) {
            
        }];

    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
     _allCell = [tableView dequeueReusableCellWithIdentifier:@"allCell"];
    ZDGoods *goods = [[ZDGoods alloc]init];
    goods = _dataMutableArray[indexPath.row];
    
    _allCell.nameLabel.text = goods.name;
    _allCell.remarkLabel.text = goods.remark;
    _allCell.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    _allCell.dateOfstartLabel.text = goods.dateOfStart;
    _allCell.dateOfEndLabel.text = goods.dateOfEnd;
    _allCell.saveTimeLabel.text = goods.saveTime;
    
    return _allCell;
    
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDAllCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedCell.selected==YES) {
        selectedCell.selected = !selectedCell.selected;
       
    }
}
/**
 cell是否可以左滑删除

 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
/**
 cell的删除方法

 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         
         ZDGoods *deletedGoods = self.dataMutableArray[indexPath.row];
    // 从数据库中删除
         [[ZDAllDataBase sharedDataBase]deleteGoods:deletedGoods];
    // 回收站中添加
         [[ZDRecycleDataBase sharedDataBase]addGoods:deletedGoods];
         self.dataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
         [self.allTableView reloadData];

     }
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
