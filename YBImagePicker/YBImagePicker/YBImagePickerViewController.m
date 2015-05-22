//
//  YBImagePickerViewController.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBImagePickerViewController.h"

#import "YBAlbumViewController.h"

#import "YBPhotePickerManager.h"

#import "YBPhotePickerManager.h"

#import <AVFoundation/AVFoundation.h>


@interface YBImagePickerViewController ()<UIAlertViewDelegate>

@end

@implementation YBImagePickerViewController


-(void)dealloc{
    
    [[YBPhotePickerManager sharedYBPhotePickerManager]removeAllPhotos];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSelectedPhotoArray:) name:GetSelectedPhotoArray object:nil];
    
    YBAlbumViewController *albumView = [[YBAlbumViewController alloc]initWithNibName:@"YBAlbumViewController" bundle:nil];
    
    [self pushViewController:albumView animated:NO];
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex){
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getSelectedPhotoArray:(NSNotification *)notif{
    NSArray *selected_photo_array = [YBPhotePickerManager sharedYBPhotePickerManager].photo_array;
    
    if ([self.photo_delegate respondsToSelector:@selector(YBImagePickerViewController:selectedPhotoArray:)]){
        [self.photo_delegate YBImagePickerViewController:self selectedPhotoArray:selected_photo_array];
        
        [[YBPhotePickerManager sharedYBPhotePickerManager] removeAllPhotos];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)setMax_count:(int)max_count{
    _max_count = max_count;
    
    [[YBPhotePickerManager sharedYBPhotePickerManager] setMax_selectedPhoto_count:max_count];
    
}


-(void)setDelegate:(id<UINavigationControllerDelegate,YBImagePickerViewControllerDelegate>)delegate{
    [super setDelegate:delegate];
    
    self.photo_delegate = delegate;
    
}

@end
