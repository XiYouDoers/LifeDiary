//
//  ZDAddTableHeaderView.m
//  LifeDiary
//
//  Created by JACK on 2018/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAddTableHeaderView.h"
#import "ZDUnderLineTextField.h"

@implementation ZDAddTableHeaderView
- (id)init{
    self= [super init];
    if (self) {
        //_headPictureSetButton
        _headPictureSetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headPictureSetButton.frame = CGRectMake(WIDTH/16, WIDTH/16, WIDTH/8, WIDTH/8);
        [_headPictureSetButton setImage:[UIImage imageNamed:@"addPicture"] forState:UIControlStateNormal];
        [self addSubview:_headPictureSetButton];
        
        //_nameTextField
        _nameTextField = [[ZDUnderLineTextField alloc]init];
        _nameTextField.frame = CGRectMake(WIDTH/4*1, 20, WIDTH/4*3, 30);
        NSAttributedString *nameTextFieldAttrString = [[NSAttributedString alloc] initWithString:@"名称" attributes:
                                                       @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                                         NSFontAttributeName:_nameTextField.font
                                                         }];
        _nameTextField.attributedPlaceholder = nameTextFieldAttrString;
        [self addSubview:_nameTextField];
        
        //_remarkTextField
        _remarkTextField = [[ZDUnderLineTextField alloc]init];
        _remarkTextField.frame = CGRectMake(WIDTH/4*1, 80, WIDTH/4*3, 30);
        NSAttributedString *remarkTextFieldAttrString = [[NSAttributedString alloc] initWithString:@"备注" attributes:
                                                         @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                                           NSFontAttributeName:_remarkTextField.font
                                                           }];
        _remarkTextField.attributedPlaceholder = remarkTextFieldAttrString;
        [self addSubview:_remarkTextField]; 
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
