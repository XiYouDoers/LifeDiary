//
//  ZDSetViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/8/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDSetViewController.h"
#import "ZDMeDefaultCell.h"
#import "ZDMeSwitchCell.h"
#import "HUDUtil.h"


@interface ZDSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *setTableView;
@property(nonatomic,copy) NSArray *cellLabelDataArray;
@property(nonatomic,copy) NSArray *cellImageDataArray;
@property(nonatomic,strong) ZDMeDefaultCell *defaultCell;
@property(nonatomic,strong) ZDMeSwitchCell *switchCell;
@end

@implementation ZDSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self.view NightWithType:UIViewColorTypeNormal];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _setTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _setTableView.dataSource = self;
    _setTableView.delegate = self;
    _setTableView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
     [self.setTableView NightWithType:UIViewColorTypeNormal];
    [_defaultCell NightWithType:UIViewColorTypeNormal];
    [_switchCell NightWithType:UIViewColorTypeNormal];
    //消除cell间细线
    _setTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _setTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    _setTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_setTableView];
    [_setTableView registerClass:[ZDMeDefaultCell class] forCellReuseIdentifier:@"meDefaultCell"];
    [_setTableView registerClass:[ZDMeSwitchCell class] forCellReuseIdentifier:@"meSwitchCell"];
    _cellLabelDataArray = [NSArray arrayWithObjects:@"夜间模式",@"主题",@"清除缓存", nil];
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
    
    return 3;
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
    return 60;
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        _switchCell = [tableView dequeueReusableCellWithIdentifier:@"meSwitchCell" forIndexPath:indexPath];
        _switchCell.tabLabel.text = [_cellLabelDataArray objectAtIndex:indexPath.row];
        [_switchCell.nightModeSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        return _switchCell;

    }else{
    _defaultCell = [tableView dequeueReusableCellWithIdentifier:@"meDefaultCell" forIndexPath:indexPath];
    _defaultCell.tabLabel.text = [_cellLabelDataArray objectAtIndex:indexPath.row];
    return _defaultCell;
    }
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
    }else if (indexPath.row == 2) {
        [HUDUtil show:self.view text:@"清除缓存成功"];
    }
}

- (void)switchAction:(UISwitch *)switch1{

    if (switch1.isOn == YES) {
        [ThemeManage shareThemeManage].isNight = ![ThemeManage shareThemeManage].isNight;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:nil];
        [[NSUserDefaults standardUserDefaults] setBool:[ThemeManage shareThemeManage].isNight forKey:@"night"];
       
    }else{
        [ThemeManage shareThemeManage].isNight = ![ThemeManage shareThemeManage].isNight;
          [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:nil];
        [[NSUserDefaults standardUserDefaults] setBool:[ThemeManage shareThemeManage].isNight forKey:@"day"];
        
    }
}
@end
