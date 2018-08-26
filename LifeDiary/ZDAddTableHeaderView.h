//
//  ZDAddTableHeaderView.h
//  LifeDiary
//
//  Created by JACK on 2018/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDUnderLineTextField.h"
//@class ZDUnderLineTextField;

@interface ZDAddTableHeaderView : UIView

@property(nonatomic,strong) UIButton *headPictureSetButton;
@property(nonatomic,strong) ZDUnderLineTextField *nameTextField;
@property(nonatomic,strong) ZDUnderLineTextField *remarkTextField;

@end
