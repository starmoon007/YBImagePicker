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

@interface YBImagePickerView_photoView ()


@property (weak, nonatomic) UIImageView * photo_imageView;



@end




@implementation YBImagePickerView_photoView


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.photo_imageView.frame = self.bounds;
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


-(UIImageView *)photo_imageView{
    if (_photo_imageView == nil){
        UIImageView *photo_imageView = [[UIImageView alloc]init];
        photo_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:photo_imageView];
        _photo_imageView = photo_imageView;
    }
    return _photo_imageView;
}



#pragma mark - 构造方法

+ (instancetype)photoView{
    return [[self alloc] init];
}

@end
