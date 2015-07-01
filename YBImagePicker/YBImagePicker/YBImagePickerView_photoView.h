//
//  YBImagePickerView_photoView.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/6/26.
//  Copyright © 2015年 macbook air. All rights reserved.

//  图片选择控件中间的单个照片的view

#import <UIKit/UIKit.h>

@class YBPhotoModel;

@interface YBImagePickerView_photoView : UIView

@property (strong, nonatomic) YBPhotoModel * photo_model;


+ (instancetype)photoView;

@end
