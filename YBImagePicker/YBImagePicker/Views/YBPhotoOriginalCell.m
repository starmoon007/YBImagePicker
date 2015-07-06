//
//  YBPhotoOriginalCell.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBPhotoOriginalCell.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "UIView+Extension.h"

#import "YBPhotoModel.h"

@interface YBPhotoOriginalCell ()


@property (weak, nonatomic) UIScrollView * bgScrollView;

@property (weak, nonatomic) UIImageView *photo_imageView;


@property (assign, nonatomic) BOOL animating;



@end

@implementation YBPhotoOriginalCell

-(void)dealloc{
    _photo_model.original_image = nil;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.bgScrollView.frame = self.bounds;
    self.photo_imageView.frame = self.bgScrollView.bounds;
    self.bgScrollView.contentSize = self.bgScrollView.bounds.size;
}

-(void)setPhoto_model:(YBPhotoModel *)photo_model{
    _photo_model = photo_model;
    
    self.photo_imageView.transform = CGAffineTransformIdentity;
    self.photo_imageView.x = 0;
    self.photo_imageView.y = 0;
    self.bgScrollView.contentSize = self.photo_imageView.frame.size;
    self.bgScrollView.contentOffset = CGPointZero;
    self.photo_imageView.image = nil;
    
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    NSURL *url= _photo_model.url;
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
        
        self.photo_imageView.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
        
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
}


- (void)pinAction:(UIPinchGestureRecognizer *)pin{
    if ((pin.state == UIGestureRecognizerStateEnded
         || pin.state == UIGestureRecognizerStateCancelled
         || pin.state == UIGestureRecognizerStateFailed)
        && self.photo_imageView.width < self.width){
        [UIView animateWithDuration:0.2 animations:^{
            self.photo_imageView.transform = CGAffineTransformIdentity;
            self.bgScrollView.contentSize = self.photo_imageView.frame.size;
            self.photo_imageView.x = 0;
            self.photo_imageView.y = 0;
            self.bgScrollView.contentOffset = CGPointZero;
        }];
        return;
    }else if (pin.state == UIGestureRecognizerStateChanged){
        if (self.animating) return;
        
        self.photo_imageView.transform = CGAffineTransformScale(self.photo_imageView.transform, pin.scale, pin.scale);
        self.bgScrollView.contentSize = self.photo_imageView.frame.size;
        
        self.bgScrollView.contentOffset = CGPointMake(self.bgScrollView.contentOffset.x - self.photo_imageView.x , self.bgScrollView.contentOffset.y - self.photo_imageView.y);
        
        self.photo_imageView.centerX = self.bgScrollView.contentOffset.x + self.bgScrollView.width / 2.0;
        self.photo_imageView.centerY = self.bgScrollView.contentOffset.y + self.bgScrollView.height / 2.0;
        
//        CGPoint point = [pin locationInView:pin.view];
//        CGFloat scale = self.photo_imageView.width / self.bgScrollView.width;
//        if (scale > 3 || scale < 0.5){
//            self.animating = YES;
//            CGFloat reScale = scale > 1 ? 1.5 : 0.8 ;
//            [UIView animateWithDuration:0.5 animations:^{
//                self.photo_imageView.transform = CGAffineTransformScale(self.photo_imageView.transform, 1.0 / scale * reScale, 1.0 / scale * reScale );
//                self.bgScrollView.contentSize = self.photo_imageView.frame.size;
//                
//                self.bgScrollView.contentOffset = CGPointMake(self.bgScrollView.contentOffset.x - self.photo_imageView.x , self.bgScrollView.contentOffset.y - self.photo_imageView.y);
//                
//                self.photo_imageView.centerX = self.bgScrollView.contentOffset.x + self.bgScrollView.width / 2.0;
//                self.photo_imageView.centerY = self.bgScrollView.contentOffset.y + self.bgScrollView.height / 2.0;
//            }completion:^(BOOL finished) {
//                self.animating = NO;
//            }];
//        }else{
//            
//        }
    }
    
    pin.scale  = 1.0;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(photoOriginalCell:didClickPhotoWithPhotoModel:)]){
        [self.delegate photoOriginalCell:self didClickPhotoWithPhotoModel:self.photo_model];
    }
    
}

- (void)tapPhotoAction:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.4 animations:^{
        self.photo_imageView.transform = CGAffineTransformIdentity;
        self.bgScrollView.contentSize = self.photo_imageView.frame.size;
        self.photo_imageView.x = 0;
        self.photo_imageView.y = 0;
        self.bgScrollView.contentOffset = CGPointZero;
    }];

}


- (void)awakeFromNib {
    self.userInteractionEnabled = YES;
    
    [self addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)]];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    
    self.photo_imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhotoAction:)];
    tap.numberOfTapsRequired = 2;
    [self.photo_imageView addGestureRecognizer:tap];
}


#pragma mark - Set and Get

-(UIScrollView *)bgScrollView{
    if (_bgScrollView == nil){
        UIScrollView *bgScrollView = [[UIScrollView alloc]init];
        bgScrollView.bounces = NO;
        bgScrollView.decelerationRate = 0.1f;
        [self addSubview:bgScrollView];
        _bgScrollView =bgScrollView;
    }
    return _bgScrollView;
}

-(UIImageView *)photo_imageView{
    if (_photo_imageView == nil){
        UIImageView *photo_imageView = [[UIImageView alloc]init];
        photo_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.bgScrollView addSubview:photo_imageView];
        _photo_imageView = photo_imageView;
    }
    return _photo_imageView;
}


@end
