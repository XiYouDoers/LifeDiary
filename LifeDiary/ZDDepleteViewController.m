//
//  ZDDepleteViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDDepleteViewController.h"
#import "ZDDepleteDataBase.h"
#import "ZDAllDataBase.h"
#import "ZDRepertoryCell.h"
#import "HUDUtil.h"

@interface ZDDepleteViewController()<UITableViewDelegate,UITableViewDataSource>{
    
    NSDateFormatter *_formatter;
    UIBarButtonItem *_allSelectedBarButtonItem;
    UIBarButtonItem *_manageCellBarButtonItem;
    bool _rightBarButtonItemIsSeleted;
    NSMutableArray *_deletedCellArray;
    UIButton *_deleteButton;
}
@property(nonatomic,strong) NSMutableArray *allDataMutableArray;
@end

@implementation ZDDepleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"过期物品";
    
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    
    _manageCellBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(manageCell:)];
    self.navigationItem.rightBarButtonItem =  _manageCellBarButtonItem;
    
    _allSelectedBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(allSelectedCell)];
    
    //_depleteTableView
    _depleteTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _depleteTableView.dataSource = self;
    _depleteTableView.delegate = self;
    //消除cell间细线
    _depleteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _depleteTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    _depleteTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_depleteTableView];
    [_depleteTableView registerClass:[ZDRepertoryCell class] forCellReuseIdentifier:@"depleteCell"];
    
    //允许table在编辑的时候多选
    self.depleteTableView.allowsMultipleSelectionDuringEditing = YES;
    
    _rightBarButtonItemIsSeleted = NO;
    _deletedCellArray = [NSMutableArray array];
    
    //_deleteButton
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/9);
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteButton setBackgroundColor:[UIColor redColor]];
    [_deleteButton addTarget:self action:@selector(deleteSelectedCells) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteButton];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _dataMutableArray = [NSMutableArray array];
    _dataMutableArray = [[ZDDepleteDataBase sharedDataBase]getAllGoods];
    [self.depleteTableView reloadData];
  
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)manageCell:(UIBarButtonItem *)sender{
    
    if (_rightBarButtonItemIsSeleted == NO) {
        _rightBarButtonItemIsSeleted = YES;
        //table进入编辑状态
        self.depleteTableView.editing = YES;
        //设置右边按钮
        [sender setTitle:@"取消"];
        
        //设置左边按钮
        self.navigationItem.leftBarButtonItem = _allSelectedBarButtonItem;
        //下移删除button
        [UIView animateWithDuration:0.5 animations:^{
            _deleteButton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/9*8, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/9);
        }];
        
    }else{
        _rightBarButtonItemIsSeleted = NO;
        //取消table进入编辑状态
        self.depleteTableView.editing = NO;
        [sender setTitle:@"管理"];
        [_deletedCellArray removeAllObjects];
        self.navigationItem.leftBarButtonItem = nil;
        //上移删除button
        [UIView animateWithDuration:0.5 animations:^{
            _deleteButton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/9);
        }];
    }
    
}
- (void)allSelectedCell{
    
    for (int i = 0; i < self.dataMutableArray.count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        [self shallowCellSelectedImageView:indexPath];
        [self.depleteTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    _deletedCellArray = [NSMutableArray arrayWithArray:self.dataMutableArray];
}
- (void)deleteSelectedCells{
    for (ZDGoods *goods in _deletedCellArray) {
        [[ZDDepleteDataBase sharedDataBase]deleteGoods:goods];
    }
    self.dataMutableArray = [[ZDDepleteDataBase sharedDataBase]getAllGoods];
    [self.depleteTableView reloadData];
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

// 改变选中时最左边对勾的背景颜色
- (void)shallowCellSelectedImageView: (NSIndexPath *)indexPath{
    ZDRepertoryCell *cell = [self.depleteTableView cellForRowAtIndexPath:indexPath];
    NSArray *subviews = cell.subviews;
    for (id obj in subviews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            
            for (id subview in [obj subviews]) {
                if ([subview isKindOfClass:[UIImageView class]]) {
                    
                    //                    [subview setValue:[UIColor colorWithRed:0.0 green:165.0/255 blue:237.0/255 alpha:1] forKey:@"tintColor"];
                    [subview setValue:[UIColor redColor] forKey:@"tintColor"];
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
    
//    [self shallowCellSelectedImageView:indexPath];
    [_deletedCellArray addObject:[self.dataMutableArray objectAtIndex:indexPath.row]];
    
}
/**
 cell取消选中时执行的方法
 
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
    
    _depleteCell = [tableView dequeueReusableCellWithIdentifier:@"depleteCell"];
    //去除选中时渲染的蓝色背景
    //去除选中时渲染的蓝色背景
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _depleteCell.selectedBackgroundView = view;
    ZDGoods *goods = [[ZDGoods alloc]init];
    goods = _dataMutableArray[indexPath.row];
    
    _depleteCell.nameLabel.text = goods.name;
    _depleteCell.remarkLabel.text = goods.remark;
    _depleteCell.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    _depleteCell.dateOfstartLabel.text = [NSString stringWithFormat:@"起始%@",goods.dateOfStart];
    _depleteCell.dateOfEndLabel.text = [NSString stringWithFormat:@"截止%@",goods.dateOfEnd];
    _depleteCell.saveTimeLabel.text = [NSString stringWithFormat:@"保质期%@",goods.saveTime];
    _depleteCell.sumLabel.text = [NSString stringWithFormat:@"数量：%@",goods.sum];
    
    return _depleteCell;
    
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
        [[ZDDepleteDataBase sharedDataBase]deleteGoods:deletedGoods];
        self.dataMutableArray = [[ZDDepleteDataBase sharedDataBase]getAllGoods];
        [self.depleteTableView reloadData];
        
    }
}
@end
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



