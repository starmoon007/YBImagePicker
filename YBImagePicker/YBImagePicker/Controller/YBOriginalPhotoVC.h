//
//  YBOriginalPhotoVC.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBOriginalPhotoVC;

typedef enum : NSUInteger {
    YBOriginalPhotoVCMode_Seleted,
    YBOriginalPhotoVCMode_Deleted
} YBOriginalPhotoVCMode;

@class YBPhotoModel;

@protocol YBOriginalPhotoVCDelegate <NSObject>

@optional
- (void)YBOriginalPhotoVC:(YBOriginalPhotoVC *)originalPhotoVC changePhotoSelectedStatewithIndexx:(int)index;

- (void)originalPhotoVC:(YBOriginalPhotoVC *)originalPhotoVC changePhotoSelectedStatewithPhotoModel:(YBPhotoModel *)photo_model;

/** 删除已选中的照片 */
- (void)originalPhotoVC:(YBOriginalPhotoVC *)originalPhotoVC deletedSeletedPhotoWithPhotModel:(YBPhotoModel *)photo_model;

@end


@interface YBOriginalPhotoVC : UIViewController

@property (weak, nonatomic) id <YBOriginalPhotoVCDelegate> delegate;

@property (assign, nonatomic) YBOriginalPhotoVCMode mode;

/** 所有预览的照片模型数组 */
@property (strong, nonatomic) NSMutableArray * photo_model_array;

/** 选中的照片模型数组 */
@property (strong, nonatomic) NSMutableArray * selected_model_array;

/** 首先展示的照片序号 */
@property (strong, nonatomic) NSIndexPath * selected_indexPath;


@end
