//
//  YBSelected_imageView.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/21.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBSelected_imageView.h"
#import "UIView+YBImagePickerAnimation.h"

@implementation YBSelected_imageView


-(void)setIsSelected:(BOOL)isSelected{
    [self setIsSelected:isSelected animate:YES];
}


- (void)setIsSelected:(BOOL)isSelected animate:(BOOL)animate{
    _isSelected = isSelected;
    
    if (animate){
        if (_isSelected){
            NSArray *duration_array = @[@(0.1),@(0.1),@(0.1),@(0.1),@(0.1)];
            self.image = [UIImage imageNamed:@"icon_find_addshare_pitch"];
            
            NSArray *scale_array = @[@(1.1),@(0.9),@(1.05),@(0.95),@(1.0)];
            self.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(0.01, 0.01));
            [UIView animateWithDuration_array:[NSMutableArray arrayWithArray:duration_array] withView:self withScale_array:[NSMutableArray arrayWithArray:scale_array]];
            
        }else{
            self.image = [UIImage imageNamed:@"icon_find_addshare"];
        }

    }else{
        if (_isSelected){
            self.image = [UIImage imageNamed:@"icon_find_addshare_pitch"];
        }else{
            self.image = [UIImage imageNamed:@"icon_find_addshare"];
        }
    }
}





@end
