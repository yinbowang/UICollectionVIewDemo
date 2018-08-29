
//
//  CustomLayout.m
//  UICollectionVIewDemo
//
//  Created by wyb on 2018/8/29.
//  Copyright © 2018年 世纪佳缘. All rights reserved.
//

#import "CustomLayout.h"
#define kScreenWidth       ([UIScreen mainScreen].bounds.size.width)
static CGFloat const lineWidth = 1.0f;

@interface CustomLayout ()

@property (nonatomic,strong) NSMutableArray *attributesArray;

@property (nonatomic,assign) CGFloat y;

@end

@implementation CustomLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.attributesArray = [NSMutableArray array];
    for (int i = 0; i < [self.collectionView numberOfSections]; i++) {
        for (int j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++) {
            [self.attributesArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]]];
        }
        //footer的UICollectionViewLayoutAttributes
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
        [self.attributesArray addObject:attribute];
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat width = kScreenWidth/3.0;
    CGFloat width1 = (kScreenWidth-lineWidth*2)/3.0;
    CGFloat width2 = (kScreenWidth-lineWidth*3)/4.0;
    if (indexPath.section == 0) {
        attribute.frame = CGRectMake(indexPath.item*width, self.y, width, width);
        NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
        if (indexPath.item == count-1) {
            self.y = self.y + width + 10;
        }
        
    }else if (indexPath.section == 1){
        
        if (indexPath.item == 0) { // 4
            attribute.frame = CGRectMake(0, _y, width1, width*2+lineWidth);
        } else if (indexPath.item == 1) {
            attribute.frame = CGRectMake(width1+lineWidth, _y, width1*2, width);
        } else if (indexPath.item == 2) {
            attribute.frame = CGRectMake(width1+lineWidth, width+lineWidth+_y, width1, width);
        } else if (indexPath.item == 3) {
            attribute.frame = CGRectMake((width1+lineWidth)*2, width+lineWidth+_y, width1, width);
        }
        NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
        if (indexPath.item == count-1) {
            self.y = self.y +  width*2+lineWidth + 10;
        }
    }else if (indexPath.section == 2){

        if (indexPath.item < 4) {
            attribute.frame = CGRectMake((width2+lineWidth)*indexPath.item, _y, width2, width);
        } else if (indexPath.item >= 4 && indexPath.item <7) {
            attribute.frame = CGRectMake((width1+lineWidth)*(indexPath.item-4), width+lineWidth+_y, width1, width);
        }
        NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
        if (indexPath.item == count-1) {
            self.y = self.y +  width*2+lineWidth + 10;
        }
        
    }
    else if (indexPath.section == 3){
        NSInteger row = indexPath.item/3;
        NSInteger col = indexPath.item%3;
        attribute.frame = CGRectMake((width1+lineWidth)*col, (width+lineWidth)*row+_y, width1, width);
        NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
        if (indexPath.item == count-1) {
            NSInteger rows = 0;
            if (count%3 == 0) {
                rows = count/3;
            }else{
                rows = count/3 + 1;
            }
            self.y = self.y +  rows * width + (rows-1)*1 + 10;
        }
    }
    
    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    attribute.frame = CGRectMake(0, _y, kScreenWidth, 60);
    _y += 60+10;
    return attribute;
}

- (CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.bounds.size;
    
    size.height = self.y;
    
    return size;
}

@end
