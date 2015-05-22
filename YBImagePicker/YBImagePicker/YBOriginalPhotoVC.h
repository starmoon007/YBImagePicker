//
//  YBOriginalPhotoVC.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBOriginalPhotoVC;


@protocol YBOriginalPhotoVCDelegate <NSObject>

- (void)YBOriginalPhotoVC:(YBOriginalPhotoVC *)originalPhotoVC changePhotoSelectedStatewithIndexx:(int)index;

@end


@interface YBOriginalPhotoVC : UIViewController

@property (weak, nonatomic) id <YBOriginalPhotoVCDelegate> delegate;

@property (strong, nonatomic) NSMutableArray * photo_model_array;

@property (strong, nonatomic) NSIndexPath * selected_indexPath;


@end
