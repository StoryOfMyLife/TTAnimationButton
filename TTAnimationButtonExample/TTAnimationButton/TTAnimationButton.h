//
//  TTAnimationButton.h
//  TTAnimationButton
//
//  Created by liuty on 16/7/22.
//  Copyright © 2016年 liuty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTAnimationButton : UIButton

@property (nonatomic, strong) UIColor *imageSelectedColor;
@property (nonatomic, strong) UIColor *imageNormalColor;

/**
 *  YES to allow customize image size, set before setting image, default NO
 */
@property (nonatomic, assign) BOOL enableCustomImageSize;
@property (nonatomic, assign) BOOL disableAnimation;

@end
