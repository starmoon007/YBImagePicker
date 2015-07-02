//
//  YBPhotoListViewController.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>

@class YBPhotoListViewController;

@protocol YBPhotoListViewControllerDelegate <NSObject>

@optional
- (void)didCancelwithYBPhotoListViewController:(YBPhotoListViewController *)photoListVC ;


@end


@interface YBPhotoListViewController : UIViewController

@property (weak, nonatomic) id <YBPhotoListViewControllerDelegate> delegate;

@property (strong, nonatomic) ALAssetsGroup *assetsGroup ;

@property (assign, nonatomic) BOOL showAll_photo;


@end
