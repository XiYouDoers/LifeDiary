//
//  YDImageView.h
//  famyidemo
//
//  Created by lilu on 2017/7/4.
//  Copyright © 2017年 网易有道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDOCRResult;

@interface YDView : UIView

@end

@interface YDImageView : UIImageView

@property (nonatomic, assign) CGFloat xScale;
@property (nonatomic, assign) CGFloat yScale;

@property (nonatomic, strong) YDView *bgView;
@property (nonatomic, strong) YDOCRResult *result;
@end
