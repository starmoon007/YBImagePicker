//
//  YBAlbumViewController.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBAlbumViewController.h"

#import "YBPhotoListViewController.h"

@interface YBAlbumViewController ()<YBPhotoListViewControllerDelegate>

@end

@implementation YBAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self uiConfig];
    
    
    YBPhotoListViewController *photoListVC = [[YBPhotoListViewController alloc]initWithNibName:@"YBPhotoListViewController" bundle:nil];
    photoListVC.delegate = self;
    [self.navigationController pushViewController:photoListVC animated:NO];
    
    
}


- (void)uiConfig{
    self.title = @"照片";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



#pragma mark - YBPhotoListViewControllerDelegate

- (void)didCancelwithYBPhotoListViewController:(YBPhotoListViewController *)photoListVC{
    [self cancel];
}

@end
