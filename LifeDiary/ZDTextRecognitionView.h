//
//  ZDTextRecognitionView.h
//  LifeDiary
//
//  Created by Jack on 2018/8/29.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDImageView;
@interface ZDTextRecognitionView : UIView
@property (nonatomic, strong) YDImageView *imgView;

- (void)recognitionForText;
- (void)setData:(UIImage *)image;
@end
