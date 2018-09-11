//
//  ZDRecycleViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDRecycleViewController.h"
#import "ZDRecycleDataBase.h"
#import "ZDAllDataBase.h"
#import "ZDRepertoryCell.h"
#import "HUDUtil.h"

@interface ZDRecycleViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UIBarButtonItem *_allSelectedBarButtonItem;
    UIBarButtonItem *_manageCellBarButtonItem;
    bool _rightBarButtonItemIsSeleted;
    NSMutableArray *_deletedCellArray;
    UIButton *_deleteButton;
}


@end

@implementation ZDRecycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回收站";
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    _manageCellBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(manageCell:)];
    self.navigationItem.rightBarButtonItem =  _manageCellBarButtonItem;
    
    _allSelectedBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(allSelectedCell)];
 

    //_recycleTableView
    _recycleTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _recycleTableView.backgroundColor = [UIColor colorWithDisplayP3Red:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    _recycleTableView.dataSource = self;
    _recycleTableView.delegate = self;
    //消除cell间细线
    _recycleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _recycleTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    _recycleTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_recycleTableView];
    [_recycleTableView registerClass:[ZDRepertoryCell class] forCellReuseIdentifier:@"recycleCell"];
    
    
    //允许table在编辑的时候多选
    _recycleTableView.allowsMultipleSelectionDuringEditing = YES;
    _rightBarButtonItemIsSeleted = NO;
    _deletedCellArray = [NSMutableArray array];
    
    //_deleteButton
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame = CGRectMake(0, HEIGHT, WIDTH, HEIGHT/9);
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteButton setBackgroundColor:[UIColor redColor]];
    [_deleteButton addTarget:self action:@selector(deleteSelectedCells) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteButton];
    

}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    _dataMutableArray = [NSMutableArray array];
    _dataMutableArray = [[ZDRecycleDataBase sharedDataBase]getAllGoods];


}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}

- (void)manageCell:(UIBarButtonItem *)sender{

    if (_rightBarButtonItemIsSeleted == NO) {
   _rightBarButtonItemIsSeleted = YES;
    //table进入编辑状态
    _recycleTableView.editing = YES;
    
    //设置右边按钮
    [sender setTitle:@"取消"];
    
    //设置左边按钮
    self.navigationItem.leftBarButtonItem = _allSelectedBarButtonItem;
    //上移删除button
    [UIView animateWithDuration:0.5 animations:^{
        _deleteButton.frame = CGRectMake(0,HEIGHT*8/9, WIDTH,HEIGHT/9);
     
    }];
       
    }else{
        _rightBarButtonItemIsSeleted = NO;
        //取消table进入编辑状态
        [self.recycleTableView setEditing:NO];
        [sender setTitle:@"管理"];
        [_deletedCellArray removeAllObjects];
        self.navigationItem.leftBarButtonItem = nil;
        //下移删除button
        [UIView animateWithDuration:0.5 animations:^{
            _deleteButton.frame = CGRectMake(0, HEIGHT, WIDTH, HEIGHT/9);
        }];
  
    }

}
- (void)allSelectedCell{
    
    for (int i = 0; i < self.dataMutableArray.count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        [self shallowCellSelectedImageView:indexPath];
        [self.recycleTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    _deletedCellArray = [NSMutableArray arrayWithArray:self.dataMutableArray];
}
- (void)deleteSelectedCells{
    for (ZDGoods *goods in _deletedCellArray) {
        [[ZDRecycleDataBase sharedDataBase]deleteGoods:goods];
    }
    self.dataMutableArray = [[ZDRecycleDataBase sharedDataBase]getAllGoods];
    [self.recycleTableView reloadData];
    //移除删除数组数据
    if (_deletedCellArray.count) {
        [_deletedCellArray removeAllObjects];
        [HUDUtil show:self.view text:@"删除成功"];
    }else{
        
    }
    //下移删除button
    [UIView animateWithDuration:0.5 animations:^{
        _deleteButton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/9*8, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/9);
    }];
    //删除后回归原状态
    [self manageCell:_manageCellBarButtonItem];
    
}

//// 改变选中时最左边对勾的背景颜色
//- (void)shallowCellSelectedImageView: (NSIndexPath *)indexPath{
//    ZDRepertoryCell *cell = [self.recycleTableView cellForRowAtIndexPath:indexPath];
//    NSArray *subviews = cell.subviews;
//    for (id obj in subviews) {
//        if ([obj isKindOfClass:[UIControl class]]) {
//
//            for (id subview in [obj subviews]) {
//                if ([subview isKindOfClass:[UIImageView class]]) {
//
//                    [subview setValue:[UIColor colorWithRed:0.0 green:165.0/255 blue:237.0/255 alpha:1] forKey:@"tintColor"];
//
//                    break;
//                }
//
//            }
//        }
//    }
//
//
//}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
//}



/**
 cell选中时执行的方法

 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [_deletedCellArray addObject:[self.dataMutableArray objectAtIndex:indexPath.row]];

}
/**
 //cell取消选中时执行的方法

 */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){

    [_deletedCellArray removeObject:[self.dataMutableArray objectAtIndex:indexPath.row]];

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
    
    _recycleCell = [tableView dequeueReusableCellWithIdentifier:@"recycleCell" forIndexPath:indexPath];
    //去除选中时渲染的蓝色背景
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _recycleCell.selectedBackgroundView = view;
    ZDGoods *goods = [[ZDGoods alloc]init];
    goods = _dataMutableArray[indexPath.row];
    
    _recycleCell.nameLabel.text = goods.name;
    _recycleCell.remarkLabel.text = goods.remark;
    _recycleCell.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    _recycleCell.dateOfstartLabel.text = [NSString stringWithFormat:@"起始%@",goods.dateOfStart];
    _recycleCell.dateOfEndLabel.text = [NSString stringWithFormat:@"截止%@",goods.dateOfEnd];
    _recycleCell.saveTimeLabel.text = [NSString stringWithFormat:@"保质期%@",goods.saveTime];
    _recycleCell.sumLabel.text = [NSString stringWithFormat:@"数量：%@",goods.sum];
    
    return _recycleCell;
    
}

///**
// 　tableView左滑编辑
//
// */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {

        ZDGoods *deletedGoods = self.dataMutableArray[indexPath.row];
        // 从数据库中删除
        [[ZDRecycleDataBase sharedDataBase]deleteGoods:deletedGoods];
        self.dataMutableArray = [[ZDRecycleDataBase sharedDataBase]getAllGoods];
        [self.recycleTableView reloadData];

    }];
    // 添加一个恢复按钮
    UITableViewRowAction *recoveryRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"恢复"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {

        ZDGoods *recoveryGoods = self.dataMutableArray[indexPath.row];
        // 从数据库中删除
        [[ZDRecycleDataBase sharedDataBase]deleteGoods:recoveryGoods];
        [[ZDAllDataBase sharedDataBase]addGoods:recoveryGoods];
        self.dataMutableArray = [[ZDRecycleDataBase sharedDataBase]getAllGoods];
        [self.recycleTableView reloadData];



    }];
    recoveryRowAction.backgroundColor = [UIColor colorWithRed:249.0/255 green:160.0/255 blue:8.0/255 alpha:1];
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction, recoveryRowAction];
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
        [[ZDRecycleDataBase sharedDataBase]deleteGoods:deletedGoods];
        self.dataMutableArray = [[ZDRecycleDataBase sharedDataBase]getAllGoods];
        [self.recycleTableView reloadData];

    }
}

@end

