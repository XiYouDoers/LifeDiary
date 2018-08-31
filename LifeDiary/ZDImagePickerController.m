//
//  ZDImagePickerController.m
//  LifeDiary
//
//  Created by Jack on 2018/8/27.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDImagePickerController.h"

@interface ZDImagePickerController (){
    UIButton *imageRecognitionButton;
    UIButton *textRecognitionButton;
}

@end

@implementation ZDImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    textRecognitionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    textRecognitionButton.frame = CGRectMake(75, 400, 100, 60);
    textRecognitionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    textRecognitionButton.selected = YES;
    [textRecognitionButton setTitle:@"文字识别" forState:UIControlStateNormal];
    [textRecognitionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [textRecognitionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [textRecognitionButton addTarget:self action:@selector(clickTextRecognitionButton:) forControlEvents:UIControlEventTouchUpInside];
    [textRecognitionButton setBackgroundImage:[UIImage imageNamed:@"buttonSelected"] forState:UIControlStateSelected];
    [self.view addSubview:textRecognitionButton];
    
    
    imageRecognitionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageRecognitionButton.frame = CGRectMake(200, 400, 100, 60);
    imageRecognitionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    imageRecognitionButton.selected = NO;
    [imageRecognitionButton setTitle:@"图像识别" forState:UIControlStateNormal];
    [imageRecognitionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imageRecognitionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [imageRecognitionButton addTarget:self action:@selector(clickImageRecognitionButton:) forControlEvents:UIControlEventTouchUpInside];
    [imageRecognitionButton setBackgroundImage:[UIImage imageNamed:@"buttonSelected"] forState:UIControlStateSelected];
    [self.view addSubview:imageRecognitionButton];
    // Do any additional setup after loading the view.
}
- (void)clickTextRecognitionButton:(UIButton *)button{

    imageRecognitionButton.selected = NO;
    button.selected = YES;
    [self.imageRecognitionDelegate textButtonWasClicked];
}
- (void)clickImageRecognitionButton:(UIButton *)button{

    textRecognitionButton.selected = NO;
    button.selected = YES;
    [self.imageRecognitionDelegate imageButtonWasClicked];
}
- (void)viewWillAppear:(BOOL)animated{
//    imageRecognitionButton.hidden = NO;
//    textRecognitionButton.hidden = NO;
    
}
- (void)setHiddenMode{
//    imageRecognitionButton.hidden = YES;
//    textRecognitionButton.hidden = YES;
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
