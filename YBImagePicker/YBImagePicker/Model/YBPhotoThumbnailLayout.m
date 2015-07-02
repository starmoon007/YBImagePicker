//
//  YBPhotoThumbnailLayout.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBPhotoThumbnailLayout.h"

@interface YBPhotoThumbnailLayout ()

@property (nonatomic,assign) CGFloat widths;// 合计宽度

@property (nonatomic,assign) CGFloat heights;// 合计高度

@property (nonatomic,assign) CGFloat widthOfLine;// 当前item的宽度

@property (nonatomic,assign) CGFloat heightOfLine;// 当前item的高度

@property (nonatomic,assign) CGSize collectionViewSize;

@end

@implementation YBPhotoThumbnailLayout



-(void)prepareLayout{
    [super prepareLayout];
    _collectionViewSize = self.collectionView.bounds.size;
    
}



// 返回collectionViewContent的 size
-(CGSize)collectionViewContentSize
{
    CGFloat newCollectionViewSize = _heightOfLine + _heights;
    _heightOfLine = 0;
    _heights = 0;
    _widthOfLine = 0;
    _widths = 0;
//    [self.collectionView layoutIfNeeded];
    return CGSizeMake(_collectionViewSize.width, newCollectionViewSize);
}

//UICollectionViewLayoutAttributes:是指第一个cell的属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建一个属性,并指向对应的cell
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    if (indexPath.row == 0){
        _heightOfLine = 0;
        _heights = 0;
        _widthOfLine = 0;
        _widths = 0;
    }
    _heightOfLine = self.itemSize.height ;
    if ((_widthOfLine + self.itemSize.width) >= _collectionViewSize.width){
        _widthOfLine = 0;
        _heights = _heights + _heightOfLine + self.section_Spacing;
    }
    
    attribute.frame = CGRectMake(_widthOfLine + self.row_Spacing, _heights,self.itemSize.width , _heightOfLine);
    _widthOfLine = _widthOfLine + self.itemSize.width + self.row_Spacing;
    return attribute;
}

//返回所有cell的属性的数组
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [arr addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return arr;
}

@end
