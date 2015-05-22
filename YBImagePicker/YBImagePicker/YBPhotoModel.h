//
//  YBPhotoModel.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface YBPhotoModel : NSObject

@property (strong, nonatomic) NSURL * url;

@property (strong, nonatomic) UIImage * original_image;

@property (strong, nonatomic) UIImage * thumbanil_image;

@property (assign, nonatomic) BOOL isSelected;

@property (strong, nonatomic) NSIndexPath * indexPath;



@end
