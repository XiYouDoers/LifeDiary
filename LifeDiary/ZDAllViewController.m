//
//  ZDAllViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAllViewController.h"
#import "ZDAllDataBase.h"

@interface ZDAllViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}


@end

@implementation ZDAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _allTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _allTableView.dataSource = self;
    _allTableView.delegate = self;
    _allTableView.scrollEnabled=NO;
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
    
    ZDGoods *goods = _dataMutableArray[indexPath.row];
    
    _allCell.nameLabel.text = goods.name;
    _allCell.remarkLabel.text = goods.remark;
    _allCell.imageView.image = [UIImage imageWithData:goods.imageData];
    _allCell.dateOfstartLabel.text = goods.dateOfStart;
    _allCell.dateOfEndLabel.text = goods.dateOfEnd;
    _allCell.saveTimeLabel.text = goods.saveTime;
    
    return _allCell;
    
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
