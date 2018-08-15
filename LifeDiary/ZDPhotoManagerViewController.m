//
//  ZDPhotoManagerViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/19.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDPhotoManagerViewController.h"

@interface ZDPhotoManagerViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate>


@end

@implementation ZDPhotoManagerViewController

- (id)init{
    self = [super init];
    if (self) {
        _button = [[UIButton alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)selectedWay{
    
    NSLog(@"11");
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
    [self.delegate presentViewController:actionSheet animated:YES completion:nil];
}
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
        [self.delegate presentViewController:picker animated:YES completion:nil];
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
        [self.delegate presentViewController:imagePicker animated:YES completion:^{
            
            NSLog(@"打开相册");
        }];
        
    }else{
        
        NSLog(@"不能打开相册");
    }
}



#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    //
    //无法回调
    //
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        
//        //图片存入相册
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//        NSLog(@"setImage");
//        [_button setImage:image forState:UIControlStateNormal];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
