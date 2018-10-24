//
//  ZDAddViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAddViewController.h"
#import "ZDAllDataBase.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZDAddTableHeaderView.h"
#import "ZDAddDefaultCell.h"
#import "ZDPickerViewCell.h"
#import "ZDRecognitionData.h"
#import "ZDPhotoManagerViewController.h"
#import "ZDClassPickerTableViewCell.h"
#import "ZDStringManager.h"
#import "HUDUtil.h"

@interface ZDAddViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate,ZDPhotoManagerViewControllerDelegate>{
    NSArray *_cellTabArray;
    NSDateFormatter *_dateFormatter;
    NSDateFormatter *_saveTimeFormatter;
    NSDateFormatter *_countFormatter;
    NSArray *_sumPickerViewDataArray;
    NSArray *_classPickerViewDataArray;
    ZDGoods *_goods;
    BOOL isTakePhoto;
}


@end

@implementation ZDAddViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"添加物品";

    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    _saveTimeFormatter = [[NSDateFormatter alloc] init];
    [_saveTimeFormatter setDateFormat:@"y-MM-dd"];

    _countFormatter = [[NSDateFormatter alloc]init];
    [_countFormatter setDateFormat:@"yyy"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBar];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame  = CGRectMake(15, 20+10,40, 24);
    backButton.layer.masksToBounds = YES;
    backButton.layer.cornerRadius = 15.f;
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:BARBUTTONITEMCOLOR forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToBeforeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame  = CGRectMake(305+15,20+10 ,40, 24);
    finishButton.layer.masksToBounds = YES;
    finishButton.layer.cornerRadius = 15.f;
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:BARBUTTONITEMCOLOR forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(150,20+10, 75, 24);
    titleLabel.text = @"添加物品";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    _addTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _addTableView.dataSource = self;
    _addTableView.delegate = self;
    _addTableHeaderView  = [[ZDAddTableHeaderView alloc]init];
    _addTableHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,150);
    _addTableHeaderView.nameTextField.delegate = self;
    _addTableHeaderView.remarkTextField.delegate = self;
    
    [_addTableHeaderView.headPictureSetButton addTarget:self action:@selector(selectWhichStyle) forControlEvents:UIControlEventTouchUpInside];
    _addTableView.tableHeaderView = _addTableHeaderView;
    _addTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_addTableView];
    [_addTableView registerClass:[ZDAddDefaultCell class] forCellReuseIdentifier:@"addDefaultCell"];
    [_addTableView registerClass:[ZDPickerViewCell class] forCellReuseIdentifier:@"pickerViewCell"];
    [_addTableView registerClass:[ZDClassPickerTableViewCell class] forCellReuseIdentifier:@"classPickerViewCell"];
    [self setInfo];
    
    _sumPickerViewDataArray = [NSArray arrayWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"28",@"30",nil];
    _classPickerViewDataArray = [NSArray arrayWithObjects:@"食品", @"日用品",@"药品",@"其他",nil];
    _cellTabArray = [NSArray arrayWithObjects:@"分类",@"生产日期",@"截止日期", @"保质期", @"数量",  nil];
    
    _continueToRecognizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _continueToRecognizeButton.frame = CGRectMake(125, 580, 125, 50);
    _continueToRecognizeButton.layer.cornerRadius = 10.f;
    _continueToRecognizeButton.layer.masksToBounds = YES;
    _continueToRecognizeButton.hidden = YES;
    [_continueToRecognizeButton setTitle:@"继续识别" forState:UIControlStateNormal];
    [_continueToRecognizeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_continueToRecognizeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_continueToRecognizeButton setBackgroundColor:[UIColor blueColor]];
    [_continueToRecognizeButton addTarget:self action:@selector(continueToRecognize) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_continueToRecognizeButton];

}
- (void)continueToRecognize{
    ZDPhotoManagerViewController *photoManagerVC = [[ZDPhotoManagerViewController alloc]init];
    photoManagerVC.delegate = self;
    [photoManagerVC selectedWayToRecognize];
}
- (void)backToBeforeVC{
    //回收所有输入框
    [self.addTableView endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setInfo{

    if (_goods) {
       
        if (_goods.imageData) {
            UIImage *image = [[UIImage alloc]init];
            image = [UIImage imageWithData:_goods.imageData];
            [_addTableHeaderView.headPictureSetButton setImage:image forState:UIControlStateNormal];
        }
        if (![_goods.name isEqualToString:@""]) {
            NSString *str = _goods.name;
     
            _addTableHeaderView.nameTextField.text = str;
        }

        if (![_goods.dateOfStart isEqualToString:@""]) {
            
            NSString *str = _goods.dateOfStart;
            NSIndexPath *indexpathForOne = [NSIndexPath indexPathForRow:1 inSection:0];
            ZDAddDefaultCell *cellForOne = [_addTableView cellForRowAtIndexPath:indexpathForOne];
            cellForOne.textField.text = str;
        }
        if (![_goods.dateOfEnd isEqualToString:@""]) {
            
            NSString *str = _goods.dateOfEnd;
            NSIndexPath *indexpathForTwo = [NSIndexPath indexPathForRow:2 inSection:0];
            ZDAddDefaultCell *cellForTwo = [_addTableView cellForRowAtIndexPath:indexpathForTwo];
            cellForTwo.textField.text = str;
        }
        if (![_goods.saveTime isEqualToString:@""]) {
            
            NSString *str = _goods.saveTime;
            NSIndexPath *indexpathForThree = [NSIndexPath indexPathForRow:3 inSection:0];
            ZDAddDefaultCell *cellForThree = [_addTableView cellForRowAtIndexPath:indexpathForThree];
            cellForThree.textField.text = str;
        }
    }
        

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
    //隐藏tabBarbbbbb
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_addTableHeaderView.nameTextField resignFirstResponder];
    [_addTableHeaderView.remarkTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField  == _addTableHeaderView.nameTextField) {
        
    [_addTableHeaderView.remarkTextField becomeFirstResponder];
    }else if(textField  == _addTableHeaderView.remarkTextField) {
        
     [_addTableHeaderView.nameTextField becomeFirstResponder];
    }
    return YES;
}
- (void)finish{

    ZDGoods *newGoods = [[ZDGoods alloc]init];
    newGoods.name = _addTableHeaderView.nameTextField.text;
    newGoods.remark = _addTableHeaderView.remarkTextField.text;
   
    if (isTakePhoto) {
         newGoods.imageData = UIImagePNGRepresentation(_addTableHeaderView.headPictureSetButton.imageView.image);
        isTakePhoto = NO;
       
    }else{
        int index = arc4random_uniform(22);
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"goods%d",index]];
        newGoods.imageData = UIImagePNGRepresentation(image);
    }
    
    
    NSIndexPath *indexpathForZero = [NSIndexPath indexPathForRow:0 inSection:0];
    ZDClassPickerTableViewCell *cellForZero = [_addTableView cellForRowAtIndexPath:indexpathForZero];
    newGoods.family = cellForZero.textField.text;
    
    NSIndexPath *indexpathForOne = [NSIndexPath indexPathForRow:1 inSection:0];
    ZDAddDefaultCell *cellForOne = [_addTableView cellForRowAtIndexPath:indexpathForOne];
    newGoods.dateOfStart = cellForOne.textField.text;
    
    NSIndexPath *indexpathForTwo = [NSIndexPath indexPathForRow:2 inSection:0];
    ZDAddDefaultCell *cellForTwo = [_addTableView cellForRowAtIndexPath:indexpathForTwo];
    newGoods.dateOfEnd = cellForTwo.textField.text;
    
    NSIndexPath *indexpathForThree = [NSIndexPath indexPathForRow:3 inSection:0];
    ZDAddDefaultCell *cellForThree = [_addTableView cellForRowAtIndexPath:indexpathForThree];
    newGoods.saveTime = cellForThree.textField.text;
    
//    ZDPickerViewCell *cellForFour = [_addTableView cellForRowAtIndexPath:indexpathForFour];
    //newGoods.sum = cellForFour.textField.text;
        //默认为1
    newGoods.sum = @"1";
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

            NSString *str = [ZDStringManager addDate:newGoods.dateOfStart str:newGoods.saveTime];
            newGoods.dateOfEnd = str;

//            NSDateComponents *dateComponentsOfSaveTime = [calender components: unitsave fromDate:dateOfSaveTime];
//            NSDate *dateOfEnd = [calender dateByAddingComponents:dateComponentsOfSaveTime toDate:dateOfStart options:0];
//            NSString *stringOfEnd = [_dateFormatter stringFromDate:dateOfEnd];
//            newGoods.dateOfEnd = stringOfEnd;
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
        

    [[ZDAllDataBase sharedDataBase]addGoods:newGoods];
        //回收所有输入框
        [self.addTableView endEditing:YES];
        
    [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate exhibitSucceed];
        
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

- (void)setGoodsInfo:(ZDGoods *)goods{
    
    _goods = [[ZDGoods alloc]init];
    _goods = goods;
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImage *image = info[@"UIImagePickerControllerEditedImage"];
        //图片存入相册
        [_addTableHeaderView.headPictureSetButton setImage:image forState:UIControlStateNormal];
        isTakePhoto = YES;
               
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
    return 5;
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
    
    //单独实现row=0和row=4的cell
    if (indexPath.row==0 ) {
       _classPickerViewCell = [tableView dequeueReusableCellWithIdentifier:@"classPickerViewCell"];
        _classPickerViewCell.pickerViewDataArray = _classPickerViewDataArray;
        
        [_classPickerViewCell.pickerView reloadAllComponents];
        _classPickerViewCell.tabLabel.text = [_cellTabArray objectAtIndex:indexPath.row];
        _classPickerViewCell.textField.placeholder = [NSString stringWithFormat:@"请输入%@",[_cellTabArray objectAtIndex:indexPath.row]];
        return _classPickerViewCell;
    }else if (indexPath.row==4) {
        _pickerViewCell = [tableView dequeueReusableCellWithIdentifier:@"pickerViewCell"];
        _pickerViewCell.pickerViewDataArray = _sumPickerViewDataArray;
        
        [_pickerViewCell.pickerView reloadAllComponents];
        _pickerViewCell.tabLabel.text = [_cellTabArray objectAtIndex:indexPath.row];
        _pickerViewCell.textField.placeholder = [NSString stringWithFormat:@"请输入%@",[_cellTabArray objectAtIndex:indexPath.row]];
        return _pickerViewCell;
    }else{

    
    _addDefaultCell = [tableView dequeueReusableCellWithIdentifier:@"addDefaultCell"];
    if (indexPath.row == 1) {
        
        _addDefaultCell.datePicker.datePickerMode = UIDatePickerModeDate;
        [_addDefaultCell.datePicker addTarget:self action:@selector(indexOneDateChanged:) forControlEvents:UIControlEventValueChanged];
    }else if (indexPath.row == 2){
        
        _addDefaultCell.datePicker.datePickerMode = UIDatePickerModeDate;
        [_addDefaultCell.datePicker addTarget:self action:@selector(indexTwoDateChanged:) forControlEvents:UIControlEventValueChanged];
    }else if (indexPath.row == 3){
        
        NSDate *maxDate = [_saveTimeFormatter dateFromString:@"4-12-31"];
        NSDate *minDate = [_saveTimeFormatter dateFromString:@"1-1-1"];
        _addDefaultCell.datePicker.maximumDate = maxDate;
        _addDefaultCell.datePicker.minimumDate = minDate;
        _addDefaultCell.datePicker.datePickerMode = UIDatePickerModeDate;
        [_addDefaultCell.datePicker addTarget:self action:@selector(indexThreeDateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    _addDefaultCell.tabLabel.text = [_cellTabArray objectAtIndex:indexPath.row];
    _addDefaultCell.textField.placeholder = [NSString stringWithFormat:@"请输入%@",[_cellTabArray objectAtIndex:indexPath.row]];
    return _addDefaultCell;
        
    }
    
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)indexOneDateChanged:(UIDatePicker *)datePicker{
    
    NSDate *date = datePicker.date;
    NSString  *string = [[NSString alloc]init];
    string = [_dateFormatter stringFromDate:date];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    ZDAddDefaultCell *cell = [_addTableView cellForRowAtIndexPath:indexPath];
    cell.textField.text = string;
}
- (void)indexTwoDateChanged:(UIDatePicker *)datePicker{
    
    NSDate *date = datePicker.date;
    NSString  *string = [[NSString alloc]init];
    string = [_dateFormatter stringFromDate:date];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    ZDAddDefaultCell *cell = [_addTableView cellForRowAtIndexPath:indexPath];
    cell.textField.text = string;
}
- (void)indexThreeDateChanged:(UIDatePicker *)datePicker{
    
    NSDate *date = datePicker.date;
    NSString  *string = [[NSString alloc]init];
    string = [_saveTimeFormatter stringFromDate:date];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    ZDAddDefaultCell *cell = [_addTableView cellForRowAtIndexPath:indexPath];
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
