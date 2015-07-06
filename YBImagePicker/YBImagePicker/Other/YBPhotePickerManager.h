//
//  YBPhotePickerManager.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OMSingleton.h"

#import "YBOriginalPhotoVC.h"

#define GetSelectedPhotoArray @"GetSelectedPhotoArray"

@class YBPhotoModel;

@interface YBPhotePickerManager : NSObject

OMSingletonH(YBPhotePickerManager)

/** 允许选择照片最大数量 */
@property (assign, nonatomic) int max_selectedPhoto_count;

/** 选中照片的数量 */
@property (assign, nonatomic,readonly) NSInteger selected_photo_count;

/** 所有照片模型数组 */
@property (strong, nonatomic) NSArray * all_photo_array;

/** 选中的照片模型数组 */
@property (weak, nonatomic,readonly) NSMutableArray * selected_photo_array;


- (BOOL)addPhoto:(YBPhotoModel *)photo_model;

- (BOOL)removePhoto:(YBPhotoModel *)photo_model;

- (void)removeAllPhotos;

- (void)removePhotoArray:(NSArray *)photo_array;


@end
