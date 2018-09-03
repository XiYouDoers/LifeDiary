//
//  ZDTextRecognitionView.h
//  LifeDiary
//
//  Created by Jack on 2018/8/29.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDTextRecognitionViewDelegate<NSObject>
- (void)jumpToAddVC;
@end

@class YDImageView,ZDRecognitionData,ZDGoods;
@interface ZDTextRecognitionView : UIView
@property (nonatomic, strong) YDImageView *imgView;
@property (nonatomic, strong) ZDGoods *goods;
@property (nonatomic, weak) id <ZDTextRecognitionViewDelegate> delegate;
- (void)recognitionForText;
- (void)setData:(UIImage *)image;
@end
