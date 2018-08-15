//
//  ZDMeTableHeaderView.h
//  LifeDiary
//
//  Created by JACK on 2018/5/18.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDMeTableHeaderViewDelegate
@optional

@end
@interface ZDMeTableHeaderView : UIView

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *backgroundImageView;

/**
 用户信息栏
 */
@property(nonatomic,strong) UITextField *nameTextField;
@property(nonatomic,strong) UITextField *personalitySignatureTextField;
@property (nonatomic,strong) UIView *shadowViewForHeadPicture;
@property(nonatomic,strong) UIButton *headPictureButton;
@property(nonatomic,strong) UIView *userInfoView;
@property (nonatomic,strong) UIView *shadowViewForRepertoryView;

/**
  仓促栏
 */
@property(nonatomic,strong) UIView *repertoryView;
@property(nonatomic,strong) UIButton *recycleButton;
@property(nonatomic,strong) UILabel *recycleLabel;
@property(nonatomic,strong) UIButton *expireButton;
@property(nonatomic,strong) UILabel *expireLabel;
@property(nonatomic,strong) UIButton *depleteButton;
@property(nonatomic,strong) UILabel *depleteLabel;

/**
 声明代理
 */
@property(nonatomic,weak) UIViewController <ZDMeTableHeaderViewDelegate>* degegate;

@end
