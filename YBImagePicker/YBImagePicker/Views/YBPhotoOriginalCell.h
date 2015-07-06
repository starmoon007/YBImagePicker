//
//  YBPhotoOriginalCell.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YBPhotoModel;
@class YBPhotoOriginalCell;

@protocol YBPhotoOriginalCellDelegate <NSObject>

@optional
- (void)photoOriginalCell:(YBPhotoOriginalCell *)photoOriginalCell didClickPhotoWithPhotoModel:(YBPhotoModel *)photo_model;

@end


@interface YBPhotoOriginalCell : UICollectionViewCell

@property (weak, nonatomic) id <YBPhotoOriginalCellDelegate>delegate;

@property (strong, nonatomic) YBPhotoModel * photo_model;

@end
