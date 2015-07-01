//
//  YBPhotoListViewController.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBPhotoListViewController;

@protocol YBPhotoListViewControllerDelegate <NSObject>

@optional
- (void)didCancelwithYBPhotoListViewController:(YBPhotoListViewController *)photoListVC ;


@end


@interface YBPhotoListViewController : UIViewController

@property (weak, nonatomic) id <YBPhotoListViewControllerDelegate> delegate;

@end
