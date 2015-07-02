//
//  YBPhotoDeleteButton.m
//  YBImagePicker
//
//  Created by Starmoon on 15/7/2.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBPhotoDeleteButton.h"
#import "UIView+Extension.h"

@implementation YBPhotoDeleteButton

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.x = self.width - self.imageView.width;
    self.imageView.y = 0;
}

+ (instancetype)PhotoDeleteButton{
    YBPhotoDeleteButton *button = [[YBPhotoDeleteButton alloc] init];
    UIImage *image = [[UIImage imageNamed:@"remove_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

@end
