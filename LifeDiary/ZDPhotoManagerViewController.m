//
//  ZDPhotoManagerViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/19.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDPhotoManagerViewController.h"
#import "ZDPickerViewController.h"
#import "ZDAddViewController.h"

@interface ZDPhotoManagerViewController ()< UIScrollViewDelegate>{
    ZDPickerViewController *imagePicker;
}

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
- (void)selectedWayToRecognize{
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
    
    
    [self.delegate presentViewController:actionSheet animated:YES completion:nil];
}
- (void)selectedWay{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *openCameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    
    UIAlertAction *openPhotoLibraryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoLibrary];
    }];
    UIAlertAction *handPhotoLibraryAction = [UIAlertAction actionWithTitle:@"手动" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openAddVC];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    //把action添加到actionSheet里
    [actionSheet addAction:openCameraAction];
    [actionSheet addAction:openPhotoLibraryAction];
    [actionSheet addAction:handPhotoLibraryAction];
    [actionSheet addAction:cancelAction];
    

    [self.delegate presentViewController:actionSheet animated:YES completion:nil];
}

/**
 直接打开添加界面
 */
- (void)openAddVC{
    ZDAddViewController *addVC = [[ZDAddViewController alloc]init];
    [self.delegate presentViewController:addVC animated:YES completion:nil];
     addVC.continueToRecognizeButton.hidden = YES;
}
/**
 *  调用照相机
 */
- (void)openCamera{
    
    imagePicker = [[ZDPickerViewController alloc] init];
    imagePicker.delegate = self.delegate;
    imagePicker.imageRecognitionDelegate = self.delegate;
    imagePicker.allowsEditing = YES; //可编辑

    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        //摄像头
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.delegate presentViewController:imagePicker animated:YES completion:nil];
        
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
        
        imagePicker = [[ZDPickerViewController alloc]init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self.delegate;
//        [imagePicker setHiddenMode];
        [self.delegate presentViewController:imagePicker animated:YES completion:^{
            
            NSLog(@"打开相册");
        }];
        
    }else{
        
        NSLog(@"不能打开相册");
    }
}




//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    [imagePicker setHiddenMode];
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
