//
//  ZDMessageCollectionViewFlowLayout.m
//  LifeDiary
//
//  Created by Jack on 2018/8/4.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMessageCollectionViewFlowLayout.h"

@implementation ZDMessageCollectionViewFlowLayout
-(void)prepareLayout{
    
    [super prepareLayout];
    [self.attributesMutableArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.attributesMutableArray addObject:attrs];
        if (i == count-1) {
            CGRect rectForFinalItem = [self layoutAttributesForItemAtIndexPath:indexpath].frame;
             _sizeForContentSize = CGSizeMake(WIDTH, 0);
             _sizeForContentSize.height = rectForFinalItem.origin.y + rectForFinalItem.size.height + 20;
        }
    }
}
- (NSMutableArray *)attributesMutableArray{
    if (!_attributesMutableArray) {
        _attributesMutableArray = [[NSMutableArray alloc]init];
    }
    return _attributesMutableArray;
}
-(CGSize)collectionViewContentSize
{

    return _sizeForContentSize;
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesMutableArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widthForBigItem = self.collectionView.frame.size.width;
    CGFloat widthForSmallItem = self.collectionView.frame.size.width/2;
    CGFloat heightForBigItem = widthForBigItem * 0.8;
    CGFloat heightForSmallItem = widthForSmallItem * 1.3;
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    NSInteger i = indexPath.item;
    if (i == 0) {
        
        attributes.frame = CGRectMake(0, 5, widthForBigItem, heightForBigItem);
    }else if (i  == 1){
        
        attributes.frame = CGRectMake(0, heightForBigItem+5, widthForSmallItem, heightForSmallItem);
        
    }else if (i == 2){
        
        attributes.frame = CGRectMake( widthForSmallItem, heightForBigItem+5, widthForSmallItem, heightForSmallItem);
    }else{
        UICollectionViewLayoutAttributes *lastAttrs = self.attributesMutableArray[i-3];
        CGRect frame  = lastAttrs.frame;
        frame.origin.y += heightForSmallItem + heightForBigItem;
        
        attributes.frame = frame;
    }

    return attributes;
}
- (id)init{
    
    if (self = [super init]) {
        [self setupLayout];
    }
    return self;
}
- (void)setupLayout{
    
}

@end
