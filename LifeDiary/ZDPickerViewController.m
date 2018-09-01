//
//  ZDPickerViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/8/31.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDPickerViewController.h"

@interface ZDPickerViewController (){
    UIButton *imageRecognitionButton;
    UIButton *textRecognitionButton;
}

@end

@implementation ZDPickerViewController

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

@end
