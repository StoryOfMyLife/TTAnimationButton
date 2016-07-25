//
//  CALayer+TTSpringAnimation.h
//  TTAnimationButton
//
//  Created by liuty on 16/7/25.
//  Copyright © 2016年 liuty. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (TTSpringAnimation)

- (void)animateWithKeypath:(nonnull NSString *)keypath
                 fromValue:(CGFloat)fromValue
                   toValue:(CGFloat)toValue
                  duration:(CGFloat)duration
                     delay:(CGFloat)delay
              usingDamping:(double)damping
     initialSpringVelocity:(double)velocity
                completion:(nullable void (^)(void))completion;
@end
