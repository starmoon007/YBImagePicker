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
    _isSelected = isSelected;
    
    if (_isSelected){
        NSArray *duration_array = @[@(0.1),@(0.1),@(0.1),@(0.1),@(0.1)];
        self.image = [UIImage imageNamed:@"icon_find_addshare_pitch"];
                      
        NSArray *scale_array = @[@(1.2),@(0.8),@(1.1),@(0.9),@(1.0)];
        self.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(0.01, 0.01));
        [UIView animateWithDuration_array:[NSMutableArray arrayWithArray:duration_array] withView:self withScale_array:[NSMutableArray arrayWithArray:scale_array]];
        
    }else{
        self.image = [UIImage imageNamed:@"icon_find_addshare"];
    }
}




@end
