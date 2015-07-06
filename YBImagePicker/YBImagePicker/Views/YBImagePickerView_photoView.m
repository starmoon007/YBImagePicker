//
//  YBImagePickerView_photoView.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/6/26.
//  Copyright © 2015年 macbook air. All rights reserved.
//

#import "YBImagePickerView_photoView.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "UIView+Extension.h"

#import "YBPhotoModel.h"

#import "YBPhotoDeleteButton.h"

@interface YBImagePickerView_photoView ()


@property (weak, nonatomic) UIImageView * photo_imageView;


@property (weak, nonatomic) YBPhotoDeleteButton * del_button;





@end




@implementation YBImagePickerView_photoView


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.photo_imageView.frame = self.bounds;
    
    self.del_button.width = self.width / 2.0;
    self.del_button.height = self.height / 2.0;
    self.del_button.y = 0;
    self.del_button.x = self.width - self.del_button.width;
    
    self.state = YBImagePickerView_photoView_StateNormal;
}

/** 长按照片 */
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    if (self.state == YBImagePickerView_photoView_StateEditing)return;
    
//    self.state = YBImagePickerView_photoView_StateEditing;
    
    
    if ([self.delegate respondsToSelector:@selector(imagePickerView_photoView:beganEditingWithPhotModel:)]){
        [self.delegate imagePickerView_photoView:self beganEditingWithPhotModel:self.photo_model];
    }
}


/** 点击图片 */
- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (self.state == YBImagePickerView_photoView_StateEditing && [self.delegate respondsToSelector:@selector(imagePickerView_photoView:endEditingWithPhotModel:)]){
        [self.delegate imagePickerView_photoView:self endEditingWithPhotModel:self.photo_model];
    }else if (self.state == YBImagePickerView_photoView_StateNormal && [self.delegate respondsToSelector:@selector(imagePickerView_photoView:didClickPhotoWithPhotModel:)]){
        [self.delegate imagePickerView_photoView:self didClickPhotoWithPhotModel:self.photo_model];
    }
}

/** 删除 */
- (void)deleteAction:(UIButton *)del_button{
    if (self.state == YBImagePickerView_photoView_StateEditing && [self.delegate respondsToSelector:@selector(imagePickerView_photoView:deletedPhotoWithPhotModel:)]){
        [self.delegate imagePickerView_photoView:self deletedPhotoWithPhotModel:self.photo_model];
    }
}

#pragma mark - Set ang Get

-(void)setPhoto_model:(YBPhotoModel *)photo_model{
    _photo_model = photo_model;
    
    if (photo_model == nil){// photo_model 为空清除原来的图片减小内存
        self.photo_imageView.image = nil;
        return;
    }
    
    if (photo_model.thumbanil_image != nil){// 如果有缩略图显示缩略图
        self.photo_imageView.image = photo_model.thumbanil_image;
        return;
    }
    
    if (photo_model.original_image != nil){// 没有缩略图 有原图显示原图
        self.photo_imageView.image = photo_model.original_image;
        return;
    }
    
    if(photo_model.url != nil){// 原图和缩略图都没有 利用url 去相册获取图片
        ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
        NSURL *url= _photo_model.url;
        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
            self.photo_model.thumbanil_image = [UIImage imageWithCGImage:[asset thumbnail]];
            
            self.photo_imageView.image = self.photo_model.thumbanil_image;
            
        }failureBlock:^(NSError *error) {
            NSLog(@"error=%@",error);
        }];
    }
}

-(void)setState:(YBImagePickerView_photoView_State)state{
    _state = state;
    switch (_state) {
        case YBImagePickerView_photoView_StateNormal:{
            self.del_button.hidden = YES;
        }break;
        case YBImagePickerView_photoView_StateEditing:{
            self.del_button.hidden = NO;
        }break;
        default:
            break;
    }
}


-(UIImageView *)photo_imageView{
    if (_photo_imageView == nil){
        UIImageView *photo_imageView = [[UIImageView alloc]init];
        photo_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:photo_imageView];
        _photo_imageView = photo_imageView;
    }
    return _photo_imageView;
}


-(UIButton *)del_button{
    if (_del_button == nil){
        YBPhotoDeleteButton *del_button = [YBPhotoDeleteButton PhotoDeleteButton];
        [del_button addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:del_button];
        _del_button = del_button;
    }
    return _del_button ;
}


#pragma mark - 构造方法

+ (instancetype)photoView{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)]];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    }
    return self;
}

@end
