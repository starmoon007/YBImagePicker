//
//  YBImagePickerView_photoView.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/6/26.
//  Copyright © 2015年 macbook air. All rights reserved.

//  图片选择控件中间的单个照片的view

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    YBImagePickerView_photoView_StateNormal,
    YBImagePickerView_photoView_StateEditing
} YBImagePickerView_photoView_State;

@class YBPhotoModel;
@class YBImagePickerView_photoView;


@protocol YBImagePickerView_photoViewDelegate <NSObject>

@optional
/** 照片控件变成可编辑状态时调用 */
- (void)imagePickerView_photoView:(YBImagePickerView_photoView *)photoView beganEditingWithPhotModel:(YBPhotoModel *)photo_model;

/** 照片控件结束编辑状态时调用 */
- (void)imagePickerView_photoView:(YBImagePickerView_photoView *)photoView endEditingWithPhotModel:(YBPhotoModel *)photo_model;


/** 照片控件点击删除按钮事调用 */
- (void)imagePickerView_photoView:(YBImagePickerView_photoView *)photoView deletedPhotoWithPhotModel:(YBPhotoModel *)photo_model;


/** 照片控件点击事件 */
- (void)imagePickerView_photoView:(YBImagePickerView_photoView *)photoView didClickPhotoWithPhotModel:(YBPhotoModel *)photo_model;

@end



@interface YBImagePickerView_photoView : UIView

@property (assign, nonatomic) id <YBImagePickerView_photoViewDelegate> delegate;

@property (strong, nonatomic) YBPhotoModel * photo_model;

@property (assign, nonatomic) YBImagePickerView_photoView_State state;


+ (instancetype)photoView;

@end
