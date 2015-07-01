//
//  ViewController.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"

#import "YBPhotoListViewController.h"

#import "YBImagePickerViewController.h"

#import "YBImgePickerView.h"


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,YBImagePickerViewControllerDelegate,YBImgePickerViewDelegate>

@property (weak, nonatomic) YBImgePickerView *imagePickerView;

@end

@implementation ViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.imagePickerView;
    
}


- (IBAction)openAlbum {
    
    YBPhotoListViewController *photoListVC = [[YBPhotoListViewController alloc]initWithNibName:@"YBPhotoListViewController" bundle:nil];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:photoListVC];
    [self presentViewController:photoListVC animated:YES completion:nil];
}

- (IBAction)system {

    [self pickImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    
}


- (void)pickImageWithType:(UIImagePickerControllerSourceType)type{
    YBImagePickerViewController *picker = [[YBImagePickerViewController alloc]init];
    picker.max_count = 9;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

-(YBImgePickerView *)imagePickerView{
    if (_imagePickerView == nil){
        YBImgePickerView *imagePickerView = [YBImgePickerView imagePickerView];
        imagePickerView.width = self.view.width;
        imagePickerView.height = 150;
        imagePickerView.x = 0;
        imagePickerView.y = 30;
        imagePickerView.delegate = self;
        [self.view addSubview:imagePickerView];
        _imagePickerView = imagePickerView;
    }
    return _imagePickerView;
}


#pragma mark - YBImagePickerViewControllerDelegate

- (void)YBImagePickerViewController:(YBImagePickerViewController *)imagePickerVC selectedPhotoArray:(NSArray *)selected_photo_array{
    
//    YBPhotoModel *model = [selected_photo_array firstObject];
//    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
//    UIImage *image = model.original_image;
//    imageView.image = image;
//    [self.view addSubview:imageView];
//    
//    imageView.backgroundColor = [UIColor redColor];
    
    NSMutableArray *selected_image_array = [[NSMutableArray alloc]initWithArray:selected_photo_array];
    
    self.imagePickerView.selected_image_array = selected_image_array;
    
    
}




@end
