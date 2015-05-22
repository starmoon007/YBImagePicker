//
//  YBPhotoThumbanilCell.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBPhotoModel.h"

@class YBPhotoThumbanilCell;


@protocol YBPhotoThumbanilCellDelegate <NSObject>

- (void)YBPhotoThumbanilCell:(YBPhotoThumbanilCell *)thumbanilCell didClickSelectedViewWithSelectedState:(BOOL)selected WithPhotoModel:(YBPhotoModel *)photoModel;


@end


@interface YBPhotoThumbanilCell : UICollectionViewCell

@property (weak, nonatomic) id <YBPhotoThumbanilCellDelegate>delegate;

@property (strong, nonatomic) YBPhotoModel * photo_model;


@end
