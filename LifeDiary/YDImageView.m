//
//  YDImageView.m
//  famyidemo
//
//  Created by lilu on 2017/7/4.
//  Copyright © 2017年 网易有道. All rights reserved.
//

#import "YDImageView.h"
#import "ocrSDK/OCRSDK.h"

@interface YDView ()
@property (nonatomic, strong) YDOCRResult *result;
@property (nonatomic, assign) CGFloat xScale;
@property (nonatomic, assign) CGFloat yScale;
@end

@implementation YDView
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.result) {
        for (YDOCRRegion *region in self.result.regions) {
            for (YDOCRLine *line in region.lines) {
                for (YDOCRWord *word in line.words) {
                    [self drawRect:word.boundingBox color:[UIColor redColor]];
                }
                [self drawRect:line.boundingBox color:[UIColor greenColor]];
            }
            [self drawRect:region.boundingBox color:[UIColor blueColor]];
        }
        CGFloat textAngle = [self.result.textAngle floatValue];
        self.transform = CGAffineTransformMakeRotation(textAngle * M_PI / 180);
    }
}

- (void)drawRect:(NSString *)boundingBox color:(UIColor *)color {
    if (!boundingBox.length) {
        return;
    }
    
    NSArray *subStrs = [boundingBox componentsSeparatedByString:@","];
    if (!(subStrs.count == 4)) {
        return;
    }
    
    CGFloat x = [subStrs[0] floatValue] * self.xScale;
    CGFloat y = [subStrs[1] floatValue] * self.yScale;;
    CGFloat w = [subStrs[2] floatValue] * self.xScale;;
    CGFloat h = [subStrs[3] floatValue] * self.yScale;;
    CGRect rect = CGRectMake(x, y, w, h);
    
    // 1取得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2画矩形，先添加到上下文
    CGContextAddRect(context, rect);
    
    // 3设置线宽
    CGContextSetLineWidth(context, 1.0);//线的宽度
    
    // 4设置颜色
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    // 5渲染
    CGContextStrokePath(context);
}
@end

@implementation YDImageView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        YDView *bgView = [[YDView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        self.bgView = bgView;
    }
    return self;
}

- (void)setResult:(YDOCRResult *)result {
    _result = result;
    self.bgView.result = result;
    self.bgView.xScale = self.xScale;
    self.bgView.yScale = self.yScale;
}
@end
