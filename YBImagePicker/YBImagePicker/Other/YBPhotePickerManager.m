//
//  YBPhotePickerManager.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBPhotePickerManager.h"

#import <UIKit/UIKit.h>
#import "YBPhotoModel.h"


@interface YBPhotePickerManager ()


/** 选中照片模型数组 */
@property (strong, nonatomic) NSMutableArray * selected_photo_model_array;






@end



@implementation YBPhotePickerManager


OMSingletonM(YBPhotePickerManager)

- (BOOL)addPhoto:(YBPhotoModel *)photo_model{
    NSInteger current_selectedPhoto_count = self.selected_photo_array.count;
    
    if (current_selectedPhoto_count >= self.max_selectedPhoto_count){
        NSString *message_str = [NSString stringWithFormat:@"最多选取%d张照片",self.max_selectedPhoto_count];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message_str delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return NO;
    }
    
    [self.selected_photo_model_array addObject:photo_model];
    return YES;
}


- (BOOL)removePhoto:(YBPhotoModel *)photo_model{
    [self.selected_photo_model_array removeObject:photo_model];
    return YES;
}


- (void)removeAllPhotos{
    [self.selected_photo_model_array removeAllObjects];
    self.all_photo_array = nil;
}


- (void)removePhotoArray:(NSArray *)photo_array{
    [self.selected_photo_model_array removeObjectsInArray:photo_array];
}


#pragma mark - Set and Get

-(NSMutableArray *)selected_photo_array{
    if (_selected_photo_model_array == nil){
        _selected_photo_model_array = [[NSMutableArray alloc]init];
    }
    
    return _selected_photo_model_array;
}

-(NSInteger)selected_photo_count{
    return self.selected_photo_model_array.count;
}

-(NSMutableArray *)photo_array{
    return self.selected_photo_model_array;
}


@end
