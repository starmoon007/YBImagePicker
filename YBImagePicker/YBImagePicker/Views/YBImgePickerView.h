//
//  YBImgePickView.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/6/26.
//  Copyright © 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YBImagePickerScreenW [UIScreen mainScreen].bounds.size.width
#define YBImagePickerScreenH [UIScreen mainScreen].bounds.size.height

// RGB颜色
#define YBImagePickerColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define YBImagePickerRandomColor YBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@class YBImgePickerView;

@protocol YBImgePickerViewDelegate <NSObject>

@optional
- (void)imagePickerView:(YBImgePickerView *)imagePickerView changeFrame:(CGRect) frame;


@end




@interface YBImgePickerView : UIView

/** 照片控件的尺寸 默认 70 * 70*/
//@property (assign, nonatomic) CGSize photo_view_size;

/** 一行多少个 默认 4个*/
@property (assign, nonatomic) NSUInteger number_of_column;

@property (assign, nonatomic) id <YBImgePickerViewDelegate> delegate;


/** 照片数据源模型数组 */
@property (strong, nonatomic) NSMutableArray * selected_image_array;



+ (instancetype)imagePickerView;

@end
