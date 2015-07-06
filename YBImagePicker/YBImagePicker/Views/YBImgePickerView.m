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
#import "YBOriginalPhotoVC.h"

#import "YBPhotePickerManager.h"



@interface YBImgePickerView ()<UINavigationControllerDelegate,YBImagePickerViewControllerDelegate,YBImagePickerView_photoViewDelegate,YBOriginalPhotoVCDelegate>



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
            photoView.delegate = self;
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
    [self changePhotState:YBImagePickerView_photoView_StateNormal];
}

#pragma mark - YBImagePickerViewControllerDelegate

- (void)YBImagePickerViewController:(YBImagePickerViewController *)imagePickerVC selectedPhotoArray:(NSArray *)selected_photo_array{
    self.selected_image_array = [YBPhotePickerManager sharedYBPhotePickerManager].selected_photo_array;
}

#pragma mark - YBImagePickerView_photoViewDelegate

- (void)imagePickerView_photoView:(YBImagePickerView_photoView *)photoView beganEditingWithPhotModel:(YBPhotoModel *)photo_model{
    
    [self changePhotState:YBImagePickerView_photoView_StateEditing];
}

- (void)imagePickerView_photoView:(YBImagePickerView_photoView *)photoView endEditingWithPhotModel:(YBPhotoModel *)photo_model{
    
    [self changePhotState:YBImagePickerView_photoView_StateNormal];
}

- (void)imagePickerView_photoView:(YBImagePickerView_photoView *)photoView deletedPhotoWithPhotModel:(YBPhotoModel *)photo_model{
    
    NSUInteger deleted_index = [self.selected_image_array indexOfObject:photo_model];
    
    
    if (deleted_index < self.selected_image_array.count){
        
        [UIView animateWithDuration:0.2 animations:^{
            photoView.hidden = YES;
            // 1.讲后面的照片前移
            for (int i = (self.selected_image_array.count - 1); i > deleted_index; i--){
                YBImagePickerView_photoView *photoView = self.imageShowView_array[i];
                
                YBImagePickerView_photoView *photoView_front = self.imageShowView_array[i - 1];
                
                photoView.frame = photoView_front.frame;
            }
            
            
        }completion:^(BOOL finished) {
            // 2.将照片删除
            [photoView removeFromSuperview];
            [self.imageShowView_array removeObject:photoView];
            [[YBPhotePickerManager sharedYBPhotePickerManager] removePhoto:photo_model];
        }];
    }
    
//    [self changePhotState:YBImagePickerView_photoView_StateNormal];
}

- (void)imagePickerView_photoView:(YBImagePickerView_photoView *)photoView didClickPhotoWithPhotModel:(YBPhotoModel *)photo_model{
    //1. 预览页面
    if ([self.delegate isKindOfClass:[UIViewController class]]){
        NSUInteger index = [self.selected_image_array indexOfObject:photo_model];
        YBOriginalPhotoVC *originalPhotoVC = [[YBOriginalPhotoVC alloc]initWithNibName:@"YBOriginalPhotoVC" bundle:nil];
        originalPhotoVC.mode = YBOriginalPhotoVCMode_Deleted;
        originalPhotoVC.photo_model_array = self.selected_image_array;
        originalPhotoVC.selected_indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        originalPhotoVC.delegate = self;
        UIViewController *vc = (UIViewController *)self.delegate;
        if (vc.navigationController == nil){
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:originalPhotoVC];
            [vc presentViewController:navi animated:YES completion:nil];
        }else{
           [vc.navigationController pushViewController:originalPhotoVC animated:YES];
        }
        
    }
}



-(void)changePhotState:(YBImagePickerView_photoView_State )state{
    
    NSUInteger count = self.imageShowView_array.count;
    for (int i=0; i<count; i++){
        YBImagePickerView_photoView *photoView = self.imageShowView_array[i];
        photoView.state = state;
    }
}

#pragma mark - YBOriginalPhotoVCDelegate

- (void)originalPhotoVC:(YBOriginalPhotoVC *)originalPhotoVC deletedSeletedPhotoWithPhotModel:(YBPhotoModel *)photo_model{
    
    self.selected_image_array = [YBPhotePickerManager sharedYBPhotePickerManager].selected_photo_array;
    
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
