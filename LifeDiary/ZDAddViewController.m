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


@interface ZDAddViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate>{
    NSArray *_cellTabArray;
}


@end

@implementation ZDAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加物品";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finsh)];
    
    _addTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _addTableView.dataSource = self;
    _addTableView.delegate = self;
    _addTableHeaderView  = [[ZDAddTableHeaderView alloc]init];
    _addTableHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,150);
    
    [_addTableHeaderView.headPictureSetButton addTarget:self action:@selector(selectWhichStyle) forControlEvents:UIControlEventTouchUpInside];
    _addTableView.tableHeaderView = _addTableHeaderView;
    _addTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_addTableView];
    [_addTableView registerClass:[ZDAddDefaultCell class] forCellReuseIdentifier:@"addDefaultCell"];
    
    
    _cellTabArray = [NSArray arrayWithObjects:@"生产日期",@"截止日期", @"保质期", @"数量",  nil];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_addTableHeaderView.nameTextField resignFirstResponder];
    [_addTableHeaderView.remarkTextField resignFirstResponder];
}

- (void)finsh{
    ZDGoods *newGoods = [[ZDGoods alloc]init];
    newGoods.name = _addTableHeaderView.nameTextField.text;
    newGoods.remark = _addTableHeaderView.remarkTextField.text;
    int index = arc4random_uniform(9);
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"goods%d",index]];
    newGoods.imageData = UIImagePNGRepresentation(image);
    [[ZDAllDataBase sharedDataBase]addGoods:newGoods];
    
    [self.navigationController popViewControllerAnimated:YES];
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

/**
 *  调用照相机
 */

- (void)openCamera

{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = YES; //可编辑
    
    //判断是否可以打开照相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        //摄像头
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
    else
        
    {
        
        NSLog(@"没有摄像头");
        
    }
    
}



/**
 *  打开相册
 */

-(void)openPhotoLibrary

{
    
    // Supported orientations has no common orientation with the application, and [PUUIAlbumListViewController shouldAutorotate] is returning YES
    
    
    
    // 进入相册
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        
    {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        imagePicker.allowsEditing = YES;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
            NSLog(@"打开相册");
            
        }];
        
    }
    
    else
        
    {
        
        NSLog(@"不能打开相册");
        
    }
    
}



#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)

{
    

    
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        
    {
        
        //图片存入相册
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [_addTableHeaderView.headPictureSetButton setImage:image forState:UIControlStateNormal];
        
    }
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
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
    
    _addDefaultCell = [tableView dequeueReusableCellWithIdentifier:@"addDefaultCell"];
    _addDefaultCell.tabLabel.text = [_cellTabArray objectAtIndex:indexPath.row];
    return _addDefaultCell;
    
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
