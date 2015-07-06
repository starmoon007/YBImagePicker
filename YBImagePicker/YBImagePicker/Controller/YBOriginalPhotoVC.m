//
//  YBOriginalPhotoVC.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBOriginalPhotoVC.h"

#import "UIView+Extension.h"

#import "YBPhotoOriginalCell.h"

#import "YBSeletedPotoNumberLabel.h"
#import "YBSelected_imageView.h"

#import "YBPhotePickerManager.h"

#import "YBPhotoModel.h"

@interface YBOriginalPhotoVC ()<YBPhotoOriginalCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *photo_collectionView;

@property (weak, nonatomic) IBOutlet UIButton *selected_buttom;

@property (assign, nonatomic) int activiteCell_index;

@property (weak, nonatomic) IBOutlet YBSeletedPotoNumberLabel *number_label;

@property (weak, nonatomic) IBOutlet YBSelected_imageView *selected_imageView;

@property (weak, nonatomic) IBOutlet UIView *top_bar;

@property (weak, nonatomic) IBOutlet UIView *bottom_bar;

@end

@implementation YBOriginalPhotoVC




- (void)viewDidLoad {
    [super viewDidLoad];

    [self uiConfig];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = [NSString stringWithFormat:@"%d/%lu",self.selected_indexPath.row + 1,(unsigned long)self.photo_model_array.count];
    
    [self.photo_collectionView scrollToItemAtIndexPath:self.selected_indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}


- (void)uiConfig{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(delete)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 20;
    layout.itemSize = CGSizeMake(width , height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.photo_collectionView.collectionViewLayout = layout;
    
    [self.photo_collectionView registerNib:[UINib nibWithNibName:@"YBPhotoOriginalCell" bundle:nil] forCellWithReuseIdentifier:@"YBPhotoOriginalCell"];
    
    self.number_label.text = [NSString stringWithFormat:@"%ld", (long)self.selected_model_array.count];
    
    self.selected_imageView.userInteractionEnabled = YES;
    [self.selected_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)]];
    
    if (self.mode == YBOriginalPhotoVCMode_Seleted){
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        self.top_bar.hidden = NO;
        self.bottom_bar.hidden = NO;
    }else if (self.mode == YBOriginalPhotoVCMode_Deleted){
        self.top_bar.hidden = YES;
        self.bottom_bar.hidden = YES;
    }
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)delete{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"确认要删除照片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    
    [alertView show];
    
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
    
    if ([self.delegate respondsToSelector:@selector(originalPhotoVC:changePhotoSelectedStatewithPhotoModel:)]){
        [self.delegate originalPhotoVC:self changePhotoSelectedStatewithPhotoModel:photo_model];
    }
    
    self.number_label.text =[NSString stringWithFormat:@"%ld", (long)self.selected_model_array.count] ;
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
    
    self.number_label.text =[NSString stringWithFormat:@"%ld", (long)[YBPhotePickerManager sharedYBPhotePickerManager].selected_photo_count] ;
}


- (IBAction)doneAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:GetSelectedPhotoArray object:nil];
}


#pragma mark - toolbar 显示隐藏
- (void)toolbarIsShow:(BOOL)show{
    if (show){
        [UIView animateWithDuration:0.5 animations:^{
            self.top_bar.hidden = NO;
            self.bottom_bar.hidden = NO;
            self.top_bar.y = 0;
            self.bottom_bar.y = self.view.height - self.bottom_bar.height;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.top_bar.y = - self.top_bar.height;
            self.bottom_bar.y = self.view.height;
        }completion:^(BOOL finished) {
            self.top_bar.hidden = YES;
            self.bottom_bar.hidden = YES;
        }];
    }
}

#pragma mark - YBPhotoOriginalCellDelegate
- (void)photoOriginalCell:(YBPhotoOriginalCell *)photoOriginalCell didClickPhotoWithPhotoModel:(YBPhotoModel *)photo_model{
    if (self.mode == YBOriginalPhotoVCMode_Deleted){
        
        [self.navigationController setNavigationBarHidden: !self.navigationController.navigationBarHidden animated:YES];
        
    }else if (self.mode == YBOriginalPhotoVCMode_Seleted){
        [self toolbarIsShow:self.top_bar.hidden];
    }
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
    if (self.mode == YBOriginalPhotoVCMode_Deleted){
        
        [self.navigationController setNavigationBarHidden: !self.navigationController.navigationBarHidden animated:YES];
        
    }else if (self.mode == YBOriginalPhotoVCMode_Seleted){
        [self toolbarIsShow:self.top_bar.hidden];
    }
}



#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int  offSetX = (int)(scrollView.contentOffset.x + [UIScreen mainScreen].bounds.size.width /2);
    
    int index = offSetX / ((int)[UIScreen mainScreen].bounds.size.width);
    
    YBPhotoModel *photo_model = self.photo_model_array[index];
    [self.selected_imageView setIsSelected:photo_model.isSelected animate:NO];
    
    self.activiteCell_index = index;
    
    self.title = [NSString stringWithFormat:@"%d/%lu",index + 1,(unsigned long)self.photo_model_array.count];
    
    if (! self.navigationController.navigationBarHidden){
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate


-(void)alertView:(nonnull UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 0){
        YBPhotoModel *photo_model = self.photo_model_array[self.activiteCell_index];
        
        [self.photo_model_array removeObject:photo_model];
        
        if (self.photo_model_array.count == 0){
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        [self.photo_collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.activiteCell_index inSection:0]]];
        
        int  offSetX = (int)(self.photo_collectionView.contentOffset.x + [UIScreen mainScreen].bounds.size.width /2);
        
        int index = offSetX / ((int)[UIScreen mainScreen].bounds.size.width);
        
        self.title = [NSString stringWithFormat:@"%d/%lu",index + 1,(unsigned long)self.photo_model_array.count];
        
        self.activiteCell_index = index;
        
        if ([self.delegate respondsToSelector:@selector(originalPhotoVC:deletedSeletedPhotoWithPhotModel:)]){
            [self.delegate originalPhotoVC:self deletedSeletedPhotoWithPhotModel:photo_model];
        }
    }
}

#pragma mark - Set and Get 

-(NSIndexPath *)selected_indexPath{
    if (_selected_indexPath == nil){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        _selected_indexPath = indexPath;
    }
    return _selected_indexPath;
}





@end
