//
//  TTAnimationButton.h
//  TTAnimationButton
//
//  Created by liuty on 16/7/22.
//  Copyright © 2016年 liuty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTAnimationButton : UIButton

/**
 *  Set button selected image color, default red.
 */
@property (nonatomic, strong) UIColor *imageSelectedColor;

/**
 *  Set button normal image color, default lightGray.
 */
@property (nonatomic, strong) UIColor *imageNormalColor;

/**
 *  Explosion density, higher leads more particles, default 0 with no explosion.
 */
@property (nonatomic, assign) NSInteger explosionRate;

/**
 *  YES to allow customize image size, set before setting image, default NO.
 */
@property (nonatomic, assign) BOOL enableCustomImageSize;

/**
 *  YES to disable the animation, default NO.
 */
@property (nonatomic, assign) BOOL disableAnimation;

@end
