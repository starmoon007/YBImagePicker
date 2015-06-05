# YBImagePicker
1.自定义从系统相册获取多张图片，类似微信选取多张图片。Get photo from album.
 1）初始化 YBImagePickerViewController，并设置代理
    YBImagePickerViewController *picker = [[YBImagePickerViewController alloc]init];
    picker.max_count = 9;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
