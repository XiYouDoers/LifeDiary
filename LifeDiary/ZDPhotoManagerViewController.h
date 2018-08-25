//
//  ZDPhotoManagerViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/19.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDPhotoManagerViewControllerDelegate
- (void)returnImage:(UIImage *)image;
@end
@interface ZDPhotoManagerViewController : UIViewController
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,weak)   UIViewController <ZDPhotoManagerViewControllerDelegate> *delegate;
- (id)init;
- (void)selectedWay;
@end
