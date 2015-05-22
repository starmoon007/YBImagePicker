//
//  YBPhotePickerManager.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OMSingleton.h"

#define GetSelectedPhotoArray @"GetSelectedPhotoArray"

@class YBPhotoModel;

@interface YBPhotePickerManager : NSObject

OMSingletonH(YBPhotePickerManager)

@property (assign, nonatomic) int max_selectedPhoto_count;

@property (assign, nonatomic,readonly) NSInteger selected_photo_count;

@property (weak, nonatomic,readonly) NSArray * photo_array;

- (BOOL)addPhoto:(YBPhotoModel *)photo_model;

- (BOOL)removePhoto:(YBPhotoModel *)photo_model;

- (void)removeAllPhotos;


@end
