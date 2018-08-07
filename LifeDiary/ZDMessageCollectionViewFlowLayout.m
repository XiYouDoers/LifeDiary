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
    return CGSizeMake(WIDTH, HEIGHT*2);
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesMutableArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.collectionView.frame.size.width/2;
    CGFloat height = width * 1.4;
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    NSInteger i = indexPath.item;
    if (i == 0) {
        
        attributes.frame = CGRectMake(0, 5, width*2, height);
    }else if (i  == 1){
        
        attributes.frame = CGRectMake(0, height+5, width, height);
        
    }else if (i == 2){
        
        attributes.frame = CGRectMake( width, height+5, width, height);
    }else{
        UICollectionViewLayoutAttributes *lastAttrs = self.attributesMutableArray[i-3];
        CGRect frame  = lastAttrs.frame;
        frame.origin.y += 2 * height+2*5;
        
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
