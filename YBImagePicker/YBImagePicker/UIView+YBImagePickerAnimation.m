//
//  UIView+YBImagePickerAnimation.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/21.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "UIView+YBImagePickerAnimation.h"

@implementation UIView (YBImagePickerAnimation)

+ (void)animateWithDuration_array:(NSMutableArray *)duration_array withView:(UIView *)view withScale_array:(NSMutableArray *)scale_array{
    
    NSTimeInterval first_duration = [[duration_array firstObject] doubleValue];
    CGFloat first_scale = [[scale_array firstObject] doubleValue];
    
    [UIView animateWithDuration:first_duration animations:^{
        view.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(first_scale, first_scale));
    }completion:^(BOOL finished) {
        if (duration_array.count != 1 && scale_array.count != 1){
            [duration_array removeObjectAtIndex:0];
            [scale_array removeObjectAtIndex:0];
            [self animateWithDuration_array:duration_array withView:view withScale_array:scale_array];
        }
    }];
}

@end
