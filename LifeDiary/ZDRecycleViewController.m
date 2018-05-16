//
//  ZDRecycleViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDRecycleViewController.h"
#import "ZDRecycleDataBase.h"

@interface ZDRecycleViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *_manageButton;
    UIBarButtonItem *_allSelectedBarButtonItem;
    bool _rightBarButtonItemIsSeleted;
    NSMutableArray *_deletedCellArray;
}


@end

@implementation ZDRecycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回收站";
    
    
    
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(manageCell:)];
    
    _allSelectedBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(allSelectedCell)];
 

    //_recycleTableView
    _recycleTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _recycleTableView.dataSource = self;
    _recycleTableView.delegate = self;
    _recycleTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    _recycleTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_recycleTableView];
    [_recycleTableView registerClass:[ZDAllCell class] forCellReuseIdentifier:@"recycleCell"];
    //允许table在编辑的时候多选
    self.recycleTableView.allowsMultipleSelectionDuringEditing = YES;
    
    _rightBarButtonItemIsSeleted = NO;
    _deletedCellArray = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
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
    self.recycleTableView.editing = YES;
    //设置右边按钮
    [sender setTitle:@"取消"];
    
    //设置左边按钮
    self.navigationItem.leftBarButtonItem = _allSelectedBarButtonItem;
    }else{
        _rightBarButtonItemIsSeleted = NO;
        //取消table进入编辑状态
        self.recycleTableView.editing = NO;
        [sender setTitle:@"管理"];
        for (int i = 0; i < self.dataMutableArray.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self shallowCellSelectedImageView:indexPath];
            [self.recycleTableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        self.navigationItem.leftBarButtonItem = nil;
    }

}
- (void)allSelectedCell{
    
    for (int i = 0; i < self.dataMutableArray.count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.recycleTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 改变选中时最左边对勾的背景颜色
- (void)shallowCellSelectedImageView: (NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.recycleTableView cellForRowAtIndexPath:indexPath];
    NSArray *subviews = cell.subviews;
    for (id obj in subviews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            
            for (id subview in [obj subviews]) {
                if ([subview isKindOfClass:[UIImageView class]]) {
                    
                    [subview setValue:[UIColor colorWithRed:0.0 green:165.0/255 blue:237.0/255 alpha:1] forKey:@"tintColor"];
                    break;
                }
                
            }
        }
    }

    
}



/**
 cell选中时执行的方法

 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self shallowCellSelectedImageView:indexPath];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [_deletedCellArray addObject:cell];
    
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
    
    _allCell = [tableView dequeueReusableCellWithIdentifier:@"recycleCell"];
    //去除选中时渲染的蓝色背景
    _allCell.selectedBackgroundView = [[UIView alloc] init];
    ZDGoods *goods = [[ZDGoods alloc]init];
    goods = _dataMutableArray[indexPath.row];
    
    _allCell.nameLabel.text = goods.name;
    _allCell.remarkLabel.text = goods.remark;
    _allCell.imageView.image = [UIImage imageWithData:goods.imageData];
    _allCell.dateOfstartLabel.text = goods.dateOfStart;
    _allCell.dateOfEndLabel.text = goods.dateOfEnd;
    _allCell.saveTimeLabel.text = goods.saveTime;
    
    return _allCell;
    
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

