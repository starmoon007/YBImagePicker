//
//  YBOriginalPhotoVC.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBOriginalPhotoVC.h"

#import "YBPhotoOriginalCell.h"

#import "YBSeletedPotoNumberLabel.h"
#import "YBSelected_imageView.h"

#import "YBPhotePickerManager.h"

#import "YBPhotoModel.h"

@interface YBOriginalPhotoVC ()<YBPhotoOriginalCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *photo_collectionView;

@property (weak, nonatomic) IBOutlet UIButton *selected_buttom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *back_buttom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *done_buttom;

@property (assign, nonatomic) int activiteCell_index;

@property (weak, nonatomic) IBOutlet YBSeletedPotoNumberLabel *number_label;

@property (weak, nonatomic) IBOutlet YBSelected_imageView *selected_imageView;

@end

@implementation YBOriginalPhotoVC




- (void)viewDidLoad {
    [super viewDidLoad];

    [self uiConfig];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.photo_collectionView scrollToItemAtIndexPath:self.selected_indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO]; 
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)uiConfig{
    
    self.title = @"相册";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 20;
    layout.itemSize = CGSizeMake(width , height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    
    self.photo_collectionView.collectionViewLayout = layout;
    
    
    [self.photo_collectionView registerNib:[UINib nibWithNibName:@"YBPhotoOriginalCell" bundle:nil] forCellWithReuseIdentifier:@"YBPhotoOriginalCell"];
    
    
    self.number_label.text =[NSString stringWithFormat:@"%ld", [YBPhotePickerManager sharedYBPhotePickerManager].selected_photo_count] ;
    
    self.selected_imageView.userInteractionEnabled = YES;
    [self.selected_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)]];
}


- (void)selectedAction:(UITapGestureRecognizer *)tap{
    YBPhotoModel *photo_model = self.photo_model_array[self.activiteCell_index];
    
    photo_model.isSelected = !photo_model.isSelected;
    
    if (photo_model.isSelected){
        
        BOOL success = [[YBPhotePickerManager sharedYBPhotePickerManager] addPhoto:photo_model];
        
        if (success){
            self.selected_imageView.isSelected = YES;
        }else{
            self.selected_imageView.isSelected = NO;
            photo_model.isSelected = !photo_model.isSelected;
            return ;
        }
        
        
    }else{
        [[YBPhotePickerManager sharedYBPhotePickerManager] removePhoto:photo_model];
        
        self.selected_imageView.isSelected = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(YBOriginalPhotoVC:changePhotoSelectedStatewithIndexx:)]){
        [self.delegate YBOriginalPhotoVC:self changePhotoSelectedStatewithIndexx:self.activiteCell_index];
    }
    
    self.number_label.text =[NSString stringWithFormat:@"%ld", [YBPhotePickerManager sharedYBPhotePickerManager].selected_photo_count] ;
    
    
}


- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectedImage:(id)sender {
    
    YBPhotoModel *photo_model = self.photo_model_array[self.activiteCell_index];
    
    photo_model.isSelected = !photo_model.isSelected;
    
    if (photo_model.isSelected){
        
        BOOL success = [[YBPhotePickerManager sharedYBPhotePickerManager] addPhoto:photo_model];
        
        if (success){
            [self.selected_buttom setTitleColor:[UIColor colorWithRed:0.1 green:0.67 blue:0.94 alpha:1] forState:UIControlStateNormal];
        }else{
            [self.selected_buttom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            photo_model.isSelected = !photo_model.isSelected;
            return ;
        }
        
        
    }else{
        [[YBPhotePickerManager sharedYBPhotePickerManager] removePhoto:photo_model];
        
        [self.selected_buttom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    if ([self.delegate respondsToSelector:@selector(YBOriginalPhotoVC:changePhotoSelectedStatewithIndexx:)]){
        [self.delegate YBOriginalPhotoVC:self changePhotoSelectedStatewithIndexx:self.activiteCell_index];
    }
    
    self.number_label.text =[NSString stringWithFormat:@"%ld", [YBPhotePickerManager sharedYBPhotePickerManager].selected_photo_count] ;
}


- (IBAction)doneAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:GetSelectedPhotoArray object:nil];
}



#pragma mark - UICollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YBPhotoOriginalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YBPhotoOriginalCell" forIndexPath:indexPath];
    YBPhotoModel *photo_model = self.photo_model_array[indexPath.row];
    cell.photo_model = photo_model;
    cell.delegate = self;
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photo_model_array.count;
}




#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}



#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int  offSetX = (int)(scrollView.contentOffset.x + [UIScreen mainScreen].bounds.size.width /2);
    
    int index = offSetX / ((int)[UIScreen mainScreen].bounds.size.width);
    
    YBPhotoModel *photo_model = self.photo_model_array[index];
    self.selected_imageView.isSelected = photo_model.isSelected;
    
    self.activiteCell_index = index;
    
}






@end
