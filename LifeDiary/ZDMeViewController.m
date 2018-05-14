//
//  ZDMeViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMeViewController.h"


@interface ZDMeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}


@end

@implementation ZDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _meTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _meTableView.dataSource = self;
    _meTableView.delegate = self;
    _meTableView.scrollEnabled=NO;
    _meTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    _meTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_meTableView];
    [_meTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"meCell"];
    [_meTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"meCell"];
    
    _cellDataArray = [NSArray arrayWithObjects:@"回收站",@"耗尽物品",@"过期物品",@"关于", nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

/**
 section中cell的数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else {
    return 3;
    }
}
/**
 TableView中section的数量
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
/**
 cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 150;
    }else{
        return 80;
    }
    
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
         return _meCell;
    }else{
    _meCell = [tableView dequeueReusableCellWithIdentifier:@"meCell"];
    _meCell.textLabel.text = [_cellDataArray objectAtIndex:indexPath.row];
          return _meCell;
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

