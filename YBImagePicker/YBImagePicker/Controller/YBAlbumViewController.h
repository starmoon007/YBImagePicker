//
//  YBAlbumViewController.h
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBAlbumViewController : UIViewController


@property (assign, nonatomic) BOOL showList;

/** 是否掉 子控制器 减少内存消耗*/
- (void)releaseSubViewController;

@end
