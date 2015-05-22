//
//  UIView+YBImagePickerAnimation.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/21.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YBImagePickerAnimation)

+ (void)animateWithDuration_array:(NSMutableArray *)duration_array withView:(UIView *)view withScale_array:(NSMutableArray *)scale_array;

@end
