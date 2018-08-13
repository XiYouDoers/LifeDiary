//
//  ZDEditViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/7/28.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDEditViewController.h"
#import "ZDAllDataBase.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZDAddTableHeaderView.h"
#import "ZDEditDefaultCell.h"
#import "ZDEditPickerViewCell.h"
#import "ZDGoods.h"
#import "ZDAddTableHeaderView.h"
#import "ZDUnderLineTextField.h"

@interface ZDEditViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>{
    NSArray *_cellTabArray;
    NSDateFormatter *_dateFormatter;
    NSDateFormatter *_saveTimeFormatter;
    NSDateFormatter *_countFormatter;
    NSArray *_pickerViewDataArray;
}

@end

@implementation ZDEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"编辑物品";
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    _saveTimeFormatter = [[NSDateFormatter alloc] init];
    [_saveTimeFormatter setDateFormat:@"y-MM-dd"];
    
    _countFormatter = [[NSDateFormatter alloc]init];
    [_countFormatter setDateFormat:@"yyy"];
    
    self.view.backgroundColor = LIGHTBLUE;
    [self setNavigationBar];
    
    _editTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _editTableView.dataSource = self;
    _editTableView.delegate = self;
    //    _addTableView.sectionHeaderHeight = 16.0f;
    _editTableHeaderView  = [[ZDAddTableHeaderView alloc]init];
    _editTableHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,150);
    _editTableHeaderView.nameTextField.delegate = self;
    _editTableHeaderView.remarkTextField.delegate = self;
    
    [_editTableHeaderView.headPictureSetButton addTarget:self action:@selector(selectWhichStyle) forControlEvents:UIControlEventTouchUpInside];
    _editTableView.tableHeaderView = _editTableHeaderView;
    _editTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_editTableView];
    [_editTableView registerClass:[ZDEditDefaultCell class] forCellReuseIdentifier:@"editDefaultCell"];
    [_editTableView registerClass:[ZDEditPickerViewCell class] forCellReuseIdentifier:@"editPickerViewCell"];
    
    _pickerViewDataArray = [NSArray arrayWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"28",@"30",nil];
    _cellTabArray = [NSArray arrayWithObjects:@"生产日期",@"截止日期", @"保质期", @"数量",  nil];
    
    // Do any additional setup after loading the view.
}
- (void)setNavigationBar{
    UIBarButtonItem *finishBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    [finishBtnItem setTitleTextAttributes:@{NSForegroundColorAttributeName:LIGHTBLUE } forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =  finishBtnItem;
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    } else {
        // Fallback on earlier versions
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_editTableHeaderView.nameTextField resignFirstResponder];
    [_editTableHeaderView.remarkTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField  == _editTableHeaderView.nameTextField) {
        
        [_editTableHeaderView.remarkTextField becomeFirstResponder];
    }else if(textField  == _editTableHeaderView.remarkTextField) {
        
        [_editTableHeaderView.nameTextField becomeFirstResponder];
    }
    return YES;
}
- (void)finish{
    
    ZDGoods *newGoods = [[ZDGoods alloc]init];
    newGoods.identifier = _goods.identifier;
    newGoods.name = _editTableHeaderView.nameTextField.text;
    newGoods.remark = _editTableHeaderView.remarkTextField.text;
    int index = arc4random_uniform(9);
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"goods%d",index]];
    newGoods.imageData = UIImagePNGRepresentation(image);
    
    NSIndexPath *indexpathForZero = [NSIndexPath indexPathForRow:0 inSection:0];
    ZDAddDefaultCell *cellForZero = [_editTableView cellForRowAtIndexPath:indexpathForZero];
    newGoods.dateOfStart = cellForZero.textField.text;
    
    NSIndexPath *indexpathForOne = [NSIndexPath indexPathForRow:1 inSection:0];
    ZDAddDefaultCell *cellForOne = [_editTableView cellForRowAtIndexPath:indexpathForOne];
    newGoods.dateOfEnd = cellForOne.textField.text;
    
    NSIndexPath *indexpathForTwo = [NSIndexPath indexPathForRow:2 inSection:0];
    ZDAddDefaultCell *cellForTwo = [_editTableView cellForRowAtIndexPath:indexpathForTwo];
    newGoods.saveTime = cellForTwo.textField.text;
    
    NSIndexPath *indexpathForThree = [NSIndexPath indexPathForRow:3 inSection:0];
    ZDAddDefaultCell *cellForThree = [_editTableView cellForRowAtIndexPath:indexpathForThree];
    newGoods.sum = cellForThree.textField.text;
    
    
    bool value1 = ![newGoods.dateOfStart isEqualToString:@""];
    bool value2 = ![newGoods.dateOfEnd isEqualToString:@""];
    bool value3 = ![newGoods.saveTime isEqualToString:@""];
    if (!((value1 && value2)||(value1 && value3)||(value2 && value3))) {
        //当生产日期，截止日期，保质期全不为空，报错
        [self displayWrongIntput];
        
    }else{
        
        NSDate *dateNow = [[NSDate alloc]init];
        NSCalendar *calender = [NSCalendar currentCalendar];
        NSCalendarUnit unitsave = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
        //计算出另一个日期
        if([newGoods.dateOfStart isEqualToString:@""]){
            
            NSDate *dateOfEnd = [_dateFormatter dateFromString:newGoods.dateOfEnd];
            NSDate *dateOfSaveTime = [_saveTimeFormatter dateFromString:newGoods.saveTime];
            NSDateComponents *dateComponentsOfStart =[calender components:unitsave fromDate:dateOfSaveTime toDate:dateOfEnd options:0];
            NSString *stringOfStart = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponentsOfStart.year,dateComponentsOfStart.month,dateComponentsOfStart.day];
            newGoods.dateOfStart = stringOfStart;
        }else if([newGoods.dateOfEnd isEqualToString:@""]){
            NSDate *dateOfStart = [_dateFormatter dateFromString:newGoods.dateOfStart];
            NSDate *dateOfSaveTime = [_saveTimeFormatter dateFromString:newGoods.saveTime];
            NSDateComponents *dateComponentsOfSaveTime = [calender components: unitsave fromDate:dateOfSaveTime];
            NSDate *dateOfEnd = [calender dateByAddingComponents:dateComponentsOfSaveTime toDate:dateOfStart options:0];
            NSString *stringOfEnd = [_dateFormatter stringFromDate:dateOfEnd];
            newGoods.dateOfEnd = stringOfEnd;
        }else{
            //newGoods.saveTime==nil
            NSDate *dateOfStart = [_dateFormatter dateFromString:newGoods.dateOfStart];
            NSDate *dateOfEnd = [_dateFormatter dateFromString:newGoods.dateOfEnd];
            NSTimeInterval timeIntervalOfStart = [dateOfStart timeIntervalSince1970];
            NSTimeInterval timeIntervalOfEnd = [dateOfEnd timeIntervalSince1970];
            //如果开始日期大于等于结束日期，则报错
            if (timeIntervalOfStart - timeIntervalOfEnd>=0.00000000) {
                [self displayWrongIntput];
                return ;
            }
            //将均正确的任意两个日期进行计算，得出另一个日期
            NSDateComponents *dateComponentsOfSaveTime = [calender components:unitsave fromDate:dateOfStart toDate:dateOfEnd options:0];
            
            NSString *stringOfSaveTime = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponentsOfSaveTime.year,dateComponentsOfSaveTime.month,dateComponentsOfSaveTime.day];
            newGoods.saveTime = stringOfSaveTime;
            
        }
        
        // 计算出圆弧的角度比率
        NSDate *dateOfStart = [_dateFormatter dateFromString:newGoods.dateOfStart];
        NSDate *dateOfEnd = [_dateFormatter dateFromString:newGoods.dateOfEnd];
        NSInteger secondsOfNowToEnd = [dateOfEnd timeIntervalSinceDate:dateNow];
        NSInteger secondsOfStartToEnd = [dateOfEnd timeIntervalSinceDate:dateOfStart];
        double ratio = (double)secondsOfNowToEnd/secondsOfStartToEnd;
        newGoods.ratio = ratio;
        [[ZDAllDataBase sharedDataBase]updateGoods:newGoods];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)displayWrongIntput{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"日期冲突，请修改" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}
- (void)selectWhichStyle{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *openCameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction *openPhotoLibraryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoLibrary];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    //把action添加到actionSheet里
    [actionSheet addAction:openCameraAction];
    [actionSheet addAction:openPhotoLibraryAction];
    [actionSheet addAction:cancelAction];
    
    //相当于之前的[actionSheet show];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 拍照和相册
/**
 *  调用照相机
 */
- (void)openCamera{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        
        NSLog(@"没有摄像头");
    }
    
}



/**
 *  打开相册
 */

-(void)openPhotoLibrary{
    
    // Supported orientations has no common orientation with the application, and [PUUIAlbumListViewController shouldAutorotate] is returning YES
    
    // 进入相册
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
            
            NSLog(@"打开相册");
        }];
        
    }else{
        
        NSLog(@"不能打开相册");
    }
}


// 拍照完成回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [_editTableHeaderView.headPictureSetButton setImage:image forState:UIControlStateNormal];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - tableView代理方法
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
    return 60;
    
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _editTableHeaderView.nameTextField.text = _goods.name;
    _editTableHeaderView.remarkTextField.text = _goods.remark;
    _editTableHeaderView.headPictureSetButton.imageView.image = [UIImage imageWithData:_goods.imageData];
    
    //单独实现row=3的cell
    if (indexPath.row==3) {
        _editPickerViewCell = [tableView dequeueReusableCellWithIdentifier:@"editPickerViewCell"];
        _editPickerViewCell.pickerViewDataArray = _pickerViewDataArray;
        [_editPickerViewCell.pickerView reloadAllComponents];
        _editPickerViewCell.tabLabel.text = [_cellTabArray objectAtIndex:indexPath.row];
        _editPickerViewCell.textField.placeholder = [NSString stringWithFormat:@"请输入%@",[_cellTabArray objectAtIndex:indexPath.row]];
        _editPickerViewCell.textField.text = _goods.sum;
        return _editPickerViewCell;
    }
    
    
    _editDefaultCell = [tableView dequeueReusableCellWithIdentifier:@"editDefaultCell"];
    if (indexPath.row == 0) {
        
        _editDefaultCell.datePicker.datePickerMode = UIDatePickerModeDate;
        _editDefaultCell.textField.text = _goods.dateOfStart;
        [_editDefaultCell.datePicker addTarget:self action:@selector(indexZeroDateChanged:) forControlEvents:UIControlEventValueChanged];
    }else if (indexPath.row==1){
        
        _editDefaultCell.datePicker.datePickerMode = UIDatePickerModeDate;
        _editDefaultCell.textField.text = _goods.dateOfEnd;
        [_editDefaultCell.datePicker addTarget:self action:@selector(indexOneDateChanged:) forControlEvents:UIControlEventValueChanged];
    }else if (indexPath.row == 2){
        
        NSDate *maxDate = [_dateFormatter dateFromString:@"4-12-31"];
        _editDefaultCell.datePicker.maximumDate = maxDate;
        _editDefaultCell.datePicker.datePickerMode = UIDatePickerModeDate;
        _editDefaultCell.textField.text = _goods.saveTime;
        [_editDefaultCell.datePicker addTarget:self action:@selector(indexTwoDateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    _editDefaultCell.tabLabel.text = [_cellTabArray objectAtIndex:indexPath.row];
    _editDefaultCell.textField.placeholder = [NSString stringWithFormat:@"请输入%@",[_cellTabArray objectAtIndex:indexPath.row]];
    return _editDefaultCell;
    
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)indexZeroDateChanged:(UIDatePicker *)datePicker{
    
    NSDate *date = datePicker.date;
    NSString  *string = [[NSString alloc]init];
    string = [_dateFormatter stringFromDate:date];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    ZDAddDefaultCell *cell = [_editTableView cellForRowAtIndexPath:indexPath];
    cell.textField.text = string;
}
- (void)indexOneDateChanged:(UIDatePicker *)datePicker{
    
    NSDate *date = datePicker.date;
    NSString  *string = [[NSString alloc]init];
    string = [_dateFormatter stringFromDate:date];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    ZDAddDefaultCell *cell = [_editTableView cellForRowAtIndexPath:indexPath];
    cell.textField.text = string;
}
- (void)indexTwoDateChanged:(UIDatePicker *)datePicker{
    
    NSDate *date = datePicker.date;
    NSString  *string = [[NSString alloc]init];
    string = [_saveTimeFormatter stringFromDate:date];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    ZDAddDefaultCell *cell = [_editTableView cellForRowAtIndexPath:indexPath];
    cell.textField.text = string;
    
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
