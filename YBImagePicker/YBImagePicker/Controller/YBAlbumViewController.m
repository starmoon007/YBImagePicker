//
//  YBAlbumViewController.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/15.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBAlbumViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "YBPhotePickerManager.h"

#import "YBPhotoListViewController.h"

#import "YBAlbumCell.h"


@interface YBAlbumViewController ()<YBPhotoListViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) YBPhotoListViewController *photoListVC;

@property (strong, nonatomic) NSMutableArray * assetsGroups;

@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;

@property (weak, nonatomic) IBOutlet UITableView *album_tableView;

@end

@implementation YBAlbumViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self uiConfig];
    
    [self prepareData];
    
    self.photoListVC.showAll_photo = YES;
    
    [self.navigationController pushViewController:self.photoListVC animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.album_tableView reloadData];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.photoListVC.showAll_photo == NO){
        self.photoListVC = nil;
    }
}


- (void)uiConfig{
    self.title = @"照片";
    
    self.album_tableView.tableFooterView = [[UIView alloc]init];
    self.album_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
}

- (void)cancel{
    [self releaseSubViewController];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareData{
    void (^assetsGroupsEnumerationBlock)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
        if(assetsGroup) {
            [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
            if(assetsGroup.numberOfAssets > 0) {
                [self.assetsGroups addObject:assetsGroup];
                [self.album_tableView reloadData];
            }
        }
    };
    
    void (^assetsGroupsFailureBlock)(NSError *) = ^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    };
    
    // Enumerate Camera Roll
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
//    // Photo Stream
//    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Album
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Event
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupEvent usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Faces
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupFaces usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
}

- (void)releaseSubViewController{
    self.photoListVC = nil;
}


#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YBAlbumCell *cell = [YBAlbumCell cellWithTableView:tableView];
    ALAssetsGroup *assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    cell.assetsGroup = assetsGroup;
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.assetsGroups.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ALAssetsGroup *assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    
    self.photoListVC.assetsGroup = assetsGroup;
    [self.navigationController pushViewController:self.photoListVC animated:YES];
}


#pragma mark - YBPhotoListViewControllerDelegate

- (void)didCancelwithYBPhotoListViewController:(YBPhotoListViewController *)photoListVC{
    [self cancel];
}


#pragma mark - Set and Get

-(void)setShowList:(BOOL)showList{
    _showList = showList;
    if (_showList){
        self.photoListVC.showAll_photo = YES;
        [self.navigationController pushViewController:self.photoListVC animated:NO];
    }
}


-(NSMutableArray *)assetsGroups{
    if (_assetsGroups == nil){
        _assetsGroups = [[NSMutableArray alloc]init];
    }
    return _assetsGroups;
}

-(ALAssetsLibrary *)assetsLibrary{
    if (_assetsLibrary == nil){
        _assetsLibrary = [[ALAssetsLibrary alloc]init];
    }
    return _assetsLibrary;
}

-(YBPhotoListViewController *)photoListVC{
    if (_photoListVC == nil){
        _photoListVC = [[YBPhotoListViewController alloc]initWithNibName:@"YBPhotoListViewController" bundle:nil];
        _photoListVC.delegate = self;
    }
    return _photoListVC;
    
}



@end
