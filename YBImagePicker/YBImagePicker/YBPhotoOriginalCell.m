//
//  YBPhotoOriginalCell.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBPhotoOriginalCell.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "YBPhotoModel.h"

@interface YBPhotoOriginalCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photo_imageView;

@end

@implementation YBPhotoOriginalCell



-(void)setPhoto_model:(YBPhotoModel *)photo_model{
    _photo_model = photo_model;
    
    
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    NSURL *url= _photo_model.url;
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {

        self.photo_imageView.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
        
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
}





- (void)awakeFromNib {
    // Initialization code
}

@end
