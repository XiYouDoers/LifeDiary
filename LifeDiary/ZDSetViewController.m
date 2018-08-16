//
//  ZDSetViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/8/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDSetViewController.h"
#import "ZDMeDefaultCell.h"

@interface ZDSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *setTableView;
@property(nonatomic,copy) NSArray *cellLabelDataArray;
@property(nonatomic,copy) NSArray *cellImageDataArray;
@property(nonatomic,strong) ZDMeDefaultCell *meCell;
@end

@implementation ZDSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _setTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _setTableView.dataSource = self;
    _setTableView.delegate = self;
    _setTableView.sectionHeaderHeight = 0.01f;
    _setTableView.sectionFooterHeight = 0.01f;
    _setTableView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    _setTableView.tableHeaderView = [UIView new];
    _setTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_setTableView];
    [_setTableView registerClass:[ZDMeDefaultCell class] forCellReuseIdentifier:@"meDefaultCell"];
    
    _cellLabelDataArray = [NSArray arrayWithObjects:@"夜间模式",@"主题",@"清除缓存",@"退出账号", nil];

}
- (void)viewWillAppear:(BOOL)animated{
    //隐藏tabBar
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
}
#pragma mark tableView 代理方法

/**
 section中cell的数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
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
    return 50;
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _meCell = [tableView dequeueReusableCellWithIdentifier:@"meDefaultCell"];
    _meCell.tabLabel.text = [_cellLabelDataArray objectAtIndex:indexPath.row];
    return _meCell;
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


@end
