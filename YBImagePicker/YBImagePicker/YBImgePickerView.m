//
//  YBImgePickView.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/6/26.
//  Copyright © 2015年 macbook air. All rights reserved.
//

#import "YBImgePickerView.h"
#import "UIView+Extension.h"

#import "YBImagePickerView_photoView.h"

#import "YBImagePickerViewController.h"



@interface YBImgePickerView ()<UINavigationControllerDelegate,YBImagePickerViewControllerDelegate>



/** 照片控件数组 */
@property (strong, nonatomic) NSMutableArray * imageShowView_array;

/** 添加照片按钮 */
@property (weak, nonatomic) UIButton * add_button;

/** 相册选取控制器 */
@property (strong, nonatomic) YBImagePickerViewController * pickerViewController;



@end


@implementation YBImgePickerView



-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSMutableArray *imageShowView_array = self.imageShowView_array;
    
    NSMutableArray *selected_image_array = self.selected_image_array;
    
    NSUInteger count = (imageShowView_array.count > selected_image_array.count) ? imageShowView_array.count : selected_image_array.count;
    
    NSUInteger activiated_count = 0;// 显示的控件数量
    
    // 内边距
    CGFloat reset = 10;
    // 照片间的间距
    CGFloat spacing = 5;
    // 照片控件 宽高
    CGFloat photo_image_view_WH = (self.width - 2.0 * reset - spacing * (self.number_of_column - 1)) / self.number_of_column;
    
    // 1. 照片排列
    for(int i=0; i<count; i++){
        YBImagePickerView_photoView *photoView = nil;
        YBPhotoModel *photo_model = nil;
        if (imageShowView_array.count <= i){// 照片控件数组中没有有视图控件 需要创建一个新的控件
            photoView = [YBImagePickerView_photoView photoView];
            photo_model = self.selected_image_array[i];
            photoView.photo_model = photo_model;
            [self addSubview:photoView];
            [imageShowView_array addObject:photoView];
        }else if (selected_image_array.count <= i){// 照片数据数组中没有数据,需要将多余的控件隐藏 ，将里面数据清空
            photoView = self.imageShowView_array[i];
            photoView.photo_model = nil;
            photoView.hidden = YES;
        }else{// 根据数据改变控件位置和显示图片
            photoView = self.imageShowView_array[i];
            photoView.hidden = NO;
            photo_model = self.selected_image_array[i];
            photoView.photo_model = photo_model;
        }
        
        if (photoView != nil && photo_model != nil){// 控件可用 数据可用
            //1. 排列子控件
            photoView.width = photoView.height =photo_image_view_WH;
            
            photoView.x = reset + (photo_image_view_WH + spacing ) * (activiated_count % self.number_of_column) ;
            
            NSUInteger number_of_line = activiated_count/ self.number_of_column;
            
            photoView.y = reset + (spacing + photo_image_view_WH) * number_of_line ;
            
            activiated_count ++;
        }
    }
    
    // 2.添加 按钮控件
    self.add_button.width = self.add_button.height = photo_image_view_WH;
    
    self.add_button.x = reset + (photo_image_view_WH + spacing ) * (activiated_count % self.number_of_column) ;
    NSUInteger number_of_line = activiated_count/ self.number_of_column;
    self.add_button.y = reset + (spacing + photo_image_view_WH) * number_of_line ;
    
    
    // 3.修改self 的size
    CGFloat height = reset * 2 + ( number_of_line + 1) * photo_image_view_WH + number_of_line * spacing;
    self.height = height;
    if ([self.delegate respondsToSelector:@selector(imagePickerView: changeFrame:)]){
        [self.delegate imagePickerView:self changeFrame:self.frame];
    }
}

// 点击添加按钮
- (void)addPhoto:(UIButton *)add_button{
    if ([self.delegate isKindOfClass:[UIViewController class]]){
        UIViewController *vc = (UIViewController *)self.delegate;
        [vc presentViewController:self.pickerViewController animated:YES completion:nil];
    }
}

#pragma mark - YBImagePickerViewControllerDelegate

- (void)YBImagePickerViewController:(YBImagePickerViewController *)imagePickerVC selectedPhotoArray:(NSArray *)selected_photo_array{
    
    NSMutableArray *selected_image_array = [[NSMutableArray alloc]initWithArray:selected_photo_array];
    
    self.selected_image_array = selected_image_array;
}



#pragma mark - Set and Get

-(void)setSelected_image_array:(NSMutableArray *)selected_image_array{
    _selected_image_array = selected_image_array;
    
    [self setNeedsLayout];
}


-(NSUInteger)number_of_column{
    if (_number_of_column <=0){
        _number_of_column = 4;
    }
    return _number_of_column;
}

-(UIButton *)add_button{
    if (_add_button == nil){
        UIButton *add_button = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *add_button_image = [[UIImage imageNamed:@"timeline_add_photo.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [add_button setImage:add_button_image forState:UIControlStateNormal];
        
        [add_button addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:add_button];
        _add_button = add_button;
    }
    return _add_button;
}

-(YBImagePickerViewController *)pickerViewController{
    if (_pickerViewController == nil){
        _pickerViewController = [[YBImagePickerViewController alloc]init];
        _pickerViewController.max_count = 9;
        _pickerViewController.delegate = self;
    }
    return _pickerViewController;
}

-(NSMutableArray *)imageShowView_array{
    if (_imageShowView_array == nil){
        _imageShowView_array = [[NSMutableArray alloc]init];
    }
    return _imageShowView_array;
}


#pragma mark - 构造方法
+ (instancetype)imagePickerView{
    return [[self alloc] init];
}




@end
