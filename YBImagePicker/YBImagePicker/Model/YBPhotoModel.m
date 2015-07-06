//
//  YBPhotoModel.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBPhotoModel.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface YBPhotoModel ()

@property (strong, nonatomic) UIImage * shadow_image;

@end


@implementation YBPhotoModel

-(void)dealloc{
    
}


-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    if (_isSelected){
        
        ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
        NSURL *url= self.url;
        
        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
            
//            self.original_image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
//            
//            self.thumbanil_image = [UIImage imageWithCGImage:[asset thumbnail]];
            
        }failureBlock:^(NSError *error) {
            NSLog(@"error=%@",error);
        }];
        
    }else{
        self.thumbanil_image = nil;
        self.original_image = nil;
    }
}

@end
