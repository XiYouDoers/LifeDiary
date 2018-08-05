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
    return CGSizeMake(WIDTH, HEIGHT);
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesMutableArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width =self.collectionView.frame.size.width*0.5;
    CGFloat height =width*1.5;
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    NSInteger i=indexPath.item;
    if (indexPath.item%3==0) {
        attributes.frame = CGRectMake(0, 0, width, height);
    }else if (indexPath.item%3==1){
         attributes.frame = CGRectMake(width, 0, width, height/2);
    }else if (indexPath.item%3==2){
        attributes.frame = CGRectMake( width, height/2, width, height/2);
    }else{
        UICollectionViewLayoutAttributes *lastAttrs = self.attributesMutableArray[i-3];
        CGRect frame  = lastAttrs.frame;
        frame.origin.y += 2 * height;
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
