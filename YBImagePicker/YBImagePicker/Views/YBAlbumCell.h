//
//  YBAlbumCell.h
//  YBImagePicker
//
//  Created by Starmoon on 15/7/1.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>

@interface YBAlbumCell : UITableViewCell

@property (strong, nonatomic) ALAssetsGroup *assetsGroup;



+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
