//
//  YBSeletedPotoNumberLabel.m
//  YBImagePicker
//
//  Created by 杨彬 on 15/5/18.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBSeletedPotoNumberLabel.h"

#import "UIView+YBImagePickerAnimation.h"


@implementation YBSeletedPotoNumberLabel



- (void)uiConfig{
    self.backgroundColor = [UIColor colorWithRed:0.1 green:0.67 blue:0.94 alpha:1];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.width);
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width /2;
    
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    
}



-(void)setText:(NSString *)text{
    [super setText:text];
    
    if ([text isEqualToString:@"0"]){
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    
    NSArray *duration_array = @[@(0.1),@(0.1),@(0.1),@(0.1),@(0.1)];
    NSArray *scale_array = @[@(1.1),@(0.9),@(1.05),@(0.95),@(1.0)];
    self.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(0.01, 0.01));
    [UIView animateWithDuration_array:[NSMutableArray arrayWithArray:duration_array] withView:self withScale_array:[NSMutableArray arrayWithArray:scale_array]];
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self uiConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self uiConfig];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self uiConfig];
    }
    return self;
}


@end
