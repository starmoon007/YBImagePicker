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

@property (strong, nonatomic)  YBPhotoListViewController *photoListVC;


@end

@implementation YBAlbumViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self uiConfig];
    
    [self.navigationController pushViewController:self.photoListVC animated:NO];
}


- (void)uiConfig{
    self.title = @"照片";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark - Set and Get 
-(YBPhotoListViewController *)photoListVC{
    if (_photoListVC == nil){
        _photoListVC = [[YBPhotoListViewController alloc]initWithNibName:@"YBPhotoListViewController" bundle:nil];
        _photoListVC.delegate = self;
    }
    return _photoListVC;
}

-(void)setShowList:(BOOL)showList{
    _showList = showList;
    if (_showList){
        [self.navigationController pushViewController:self.photoListVC animated:NO];
    }
}

#pragma mark - YBPhotoListViewControllerDelegate

- (void)didCancelwithYBPhotoListViewController:(YBPhotoListViewController *)photoListVC{
    [self cancel];
}

@end
