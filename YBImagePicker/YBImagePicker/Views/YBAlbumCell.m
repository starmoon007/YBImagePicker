//
//  YBAlbumCell.m
//  YBImagePicker
//
//  Created by Starmoon on 15/7/1.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBAlbumCell.h"

@interface YBAlbumCell ()

@property (weak, nonatomic) IBOutlet UIImageView *poto_imageView;

@property (weak, nonatomic) IBOutlet UILabel *title_label;

@property (weak, nonatomic) IBOutlet UILabel *number_label;

@end


@implementation YBAlbumCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"YBAlbumCellID";
    YBAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YBAlbumCell" owner:self options:nil] lastObject];
    }
    return cell;
}


#pragma mark - Set and Get


-(void)setAssetsGroup:(ALAssetsGroup *)assetsGroup{
    _assetsGroup = assetsGroup;
    
    self.poto_imageView.image = [UIImage imageWithCGImage:assetsGroup.posterImage];
    
    self.title_label.text = [NSString stringWithFormat:@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    
    self.number_label.text = [NSString stringWithFormat:@"%d", assetsGroup.numberOfAssets];
}

@end
