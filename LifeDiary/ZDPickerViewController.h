//
//  ZDPickerViewController.h
//  LifeDiary
//
//  Created by Jack on 2018/8/31.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDImageRecognitionDelegate <NSObject>
@optional
- (void)textButtonWasClicked;
- (void)imageButtonWasClicked;
@end

@interface ZDPickerViewController : UIImagePickerController
@property(nonatomic,weak) id <ZDImageRecognitionDelegate> imageRecognitionDelegate;

/**
 隐藏mode选项
 */
- (void)setHiddenMode;
@end
