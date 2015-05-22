//
//  ViewController.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "ViewController.h"

#import "YBPhotoListViewController.h"

#import "YBImagePickerViewController.h"


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,YBImagePickerViewControllerDelegate>

@end

@implementation ViewController


- (IBAction)openAlbum {
    
    YBPhotoListViewController *photoListVC = [[YBPhotoListViewController alloc]initWithNibName:@"YBPhotoListViewController" bundle:nil];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:photoListVC];
    [self presentViewController:photoListVC animated:YES completion:nil];
}

- (IBAction)system {

    [self pickImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    
}
- (IBAction)CT:(id)sender {
    
}


- (void)pickImageWithType:(UIImagePickerControllerSourceType)type{
    YBImagePickerViewController *picker = [[YBImagePickerViewController alloc]init];
    picker.max_count = 9;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - YBImagePickerViewControllerDelegate

- (void)YBImagePickerViewController:(YBImagePickerViewController *)imagePickerVC selectedPhotoArray:(NSArray *)selected_photo_array{
    
    YBPhotoModel *model = [selected_photo_array firstObject];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
    UIImage *image = model.original_image;
    imageView.image = image;
    [self.view addSubview:imageView];
    
    imageView.backgroundColor = [UIColor redColor];
    
    
}




@end
