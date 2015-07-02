//
//  YBPhotoThumbanilCell.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBPhotoThumbanilCell.h"

#import "YBPhotoModel.h"

#import "YBPhotePickerManager.h"

#import "YBSelected_imageView.h"

#import <AssetsLibrary/AssetsLibrary.h>


@interface YBPhotoThumbanilCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photo_imageView;

@property (weak, nonatomic) IBOutlet YBSelected_imageView *selected_imageView;

@property (assign, nonatomic) BOOL isSelectedImage;

@property (weak, nonatomic) IBOutlet UIView *tap_view;

@property (strong, nonatomic) ALAssetsLibrary *assetLibrary;

@end

@implementation YBPhotoThumbanilCell

-(void)dealloc{
    
//    NSLog(@"dealloc");
    
}

-(void)setPhoto_model:(YBPhotoModel *)photo_model{
    _photo_model = photo_model;

    NSURL *url= _photo_model.url;
    [self.assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
        
        self.photo_imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
        
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
    
    
    _isSelectedImage = _photo_model.isSelected;
    
    [_selected_imageView setIsSelected:_photo_model.isSelected animate:NO];
}

- (void)tapSelected_imageView{
    self.isSelectedImage = !self.isSelectedImage;
    
    
    if (self.isSelectedImage){
        BOOL success = [[YBPhotePickerManager sharedYBPhotePickerManager] addPhoto:self.photo_model];
        if (success){
            self.isSelectedImage = YES;
        }else{
            self.isSelectedImage = NO;
            return;
        }
        
    }else{
        self.isSelectedImage = NO;
        [[YBPhotePickerManager sharedYBPhotePickerManager] removePhoto:self.photo_model];
    }
    
    if ([self.delegate respondsToSelector:@selector(YBPhotoThumbanilCell:didClickSelectedViewWithSelectedState:WithPhotoModel:)]){
        [self.delegate YBPhotoThumbanilCell:self didClickSelectedViewWithSelectedState:self.isSelectedImage WithPhotoModel:self.photo_model];
    }
}

- (void)awakeFromNib {
    
    self.photo_imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.selected_imageView.userInteractionEnabled = YES;
    self.selected_imageView.isSelected = NO;
    
    
    [self.tap_view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelected_imageView)]];
}

-(void)setIsSelectedImage:(BOOL)isSelectedImage{
    _isSelectedImage = isSelectedImage;
    
    self.selected_imageView.isSelected = _isSelectedImage;
    self.photo_model.isSelected = _isSelectedImage;
}


-(ALAssetsLibrary *)assetLibrary{
    if (_assetLibrary == nil){
        _assetLibrary = [[ALAssetsLibrary alloc]init];
    }
    return _assetLibrary;
}

@end
