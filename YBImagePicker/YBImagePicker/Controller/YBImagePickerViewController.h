//
//  YBImagePickerViewController.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YBPhotoModel.h"
@class YBImagePickerViewController;

@protocol YBImagePickerViewControllerDelegate <NSObject>

- (void)YBImagePickerViewController:(YBImagePickerViewController *)imagePickerVC selectedPhotoArray:(NSArray *)selected_photo_array;

@end



@interface YBImagePickerViewController : UINavigationController

@property (weak, nonatomic) id <YBImagePickerViewControllerDelegate> photo_delegate;

@property (assign, nonatomic) int max_count;


@end
