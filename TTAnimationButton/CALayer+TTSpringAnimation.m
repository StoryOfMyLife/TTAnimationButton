//
//  CALayer+TTSpringAnimation.h.m
//  TTAnimationButton
//
//  Created by liuty on 16/7/25.
//  Copyright © 2016年 liuty. All rights reserved.
//

#import "CALayer+TTSpringAnimation.h"

@implementation CALayer (TTSpringAnimation)

- (void)animateWithKeypath:(NSString *)keypath fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(CGFloat)duration delay:(CGFloat)delay usingDamping:(double)damping initialSpringVelocity:(double)velocity completion:(nullable void (^)(void))completion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    
    CAKeyframeAnimation *animation = [self keyframeAnimationWithKeypath:keypath fromValue:fromValue toValue:toValue duration:duration usingDamping:damping initialSpringVelocity:velocity];
    CFTimeInterval currentTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    animation.beginTime = currentTime + delay;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self addAnimation:animation forKey:@"layer spring animation"];
    [CATransaction commit];
}

- (CAKeyframeAnimation *)keyframeAnimationWithKeypath:(NSString *)keypath fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(CGFloat)duration usingDamping:(double)damping initialSpringVelocity:(double)velocity
{
    NSArray *values = [self animationValuesFromValue:fromValue toValue:toValue usingDamping:damping initialSpringVelocity:velocity];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keypath];
    animation.values = values;
    animation.duration = duration;
    
    return animation;
}

- (NSArray *)animationValuesFromValue:(double)fromValue toValue:(double)toValue usingDamping:(double)damping initialSpringVelocity:(double)velocity
{
    CGFloat numberOfPoints = 500;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numberOfPoints];
    
    double delta = toValue - fromValue;
    
    for (int point = 0; point < numberOfPoints; point++) {
        double x = (double)point / (double)numberOfPoints;
        double y = [self animationValuesNormalized:x usingDamping:damping initialSpringVelocity:velocity];
        
        double value = toValue - delta * y;
        [values addObject:@(value)];
    }
    return values;
}

- (double)animationValuesNormalized:(double)x usingDamping:(double)damping initialSpringVelocity:(double)velocity
{
    return pow(M_E, -damping * x) * cos(velocity * x);
}

@end
