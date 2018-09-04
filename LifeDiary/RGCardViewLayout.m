//
//  RGCardViewLayout.m
//  RGCardViewLayout
//
//  Created by ROBERA GELETA on 1/23/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "RGCardViewLayout.h"

@implementation RGCardViewLayout
{
    CGFloat previousOffset;
    NSIndexPath *mainIndexPath;
    NSIndexPath *movingInIndexPath;
    CGFloat difference;
}

- (instancetype)init{
    self=[super init];
    if (self) {

    }
    return self;
}
# pragma mark 缩小放大滑动
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout{

    [super prepareLayout];
//    CGFloat inset  = self.collectionView.bounds.size.width * (10/64.0f);
//    inset = floor(inset);

    self.itemSize = CGSizeMake([self cellWidth],self.collectionView.bounds.size.height * 0.7);
//    self.sectionInset = UIEdgeInsetsMake(0,inset*1.2,inset/2,inset*1.2);

    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     self.sectionInset = UIEdgeInsetsMake(-50, [self collectionInset], 0, [self collectionInset]);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{

    //扩大控制范围，防止出现闪屏现象
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2*[self cellWidth];
    bigRect.origin.x = rect.origin.x - [self cellWidth];
    
    NSArray *attributes = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
//    // 获得super已经计算好的布局属性
//    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];

    // 计算collectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in attributes) {
//        // cell的中心点x 和 collectionView最中心点的x值 的间距
//        CGFloat delta = ABS(attrs.center.x - centerX);
//        // 根据间距值 计算 cell的缩放比例
//        CGFloat scale = 1.2 - delta / self.collectionView.frame.size.width;
//        attrs.alpha =scale;
//        // 设置缩放比例
//        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        
 
        CGFloat distance = fabs(attrs.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }

    return  attributes;

}
//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}
//卡片宽度
- (CGFloat)cellWidth {
    return self.collectionView.bounds.size.width * 0.7f;
}
//卡片间隔
- (float)cellMargin {
    return (self.collectionView.bounds.size.width - [self cellWidth])/9;
}
//设置左右缩进
- (CGFloat)collectionInset {
    return self.collectionView.bounds.size.width/2.0f - [self cellWidth]/2.0f;
}
//最小纵向间距
- (CGFloat)minimumLineSpacing {
    return [self cellMargin];
}


@end

