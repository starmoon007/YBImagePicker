//
//  YBSelected_imageView.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/21.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBSelected_imageView : UIImageView

@property (assign, nonatomic) BOOL isSelected;

- (void)setIsSelected:(BOOL)isSelected animate:(BOOL)animate;

@end
