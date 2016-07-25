//
//  TTAnimationButton.h
//  TTAnimationButton
//
//  Created by liuty on 16/7/22.
//  Copyright © 2016年 liuty. All rights reserved.
//

#import "TTAnimationButton.h"
#import "CALayer+TTSpringAnimation.h"

static const CGFloat imageScale = 0.65;

@interface TTEmitterImageView : UIImageView

@property (nonatomic, strong) CAShapeLayer *circleShape;
@property (nonatomic, strong) CAShapeLayer *circleMask;

@property (nonatomic, strong) CAShapeLayer *imageShape;
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, strong) UIColor *imageNormalColor;
@property (nonatomic, strong) UIColor *imageSelectedColor;

@property (nonatomic, strong) UIImage *emitterImage;

@end

@implementation TTEmitterImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLayer];
    }
    return self;
}

- (void)createLayer
{
    [self.layer addSublayer:self.circleShape];
    [self.layer addSublayer:self.imageShape];
    [self.layer addSublayer:self.emitterLayer];
}

- (void)select
{
    CGFloat duration = 0.3;
    CGFloat delayed = duration / 2;
    CGFloat scale = self.bounds.size.width / 2 + 1;
    
    //1. image hide
    CABasicAnimation *imageHideAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    imageHideAnimation.duration = duration / 2;
    imageHideAnimation.toValue = @0;
    [self.imageShape addAnimation:imageHideAnimation forKey:@"hide"];
    //image color selected
    self.imageShape.fillColor = self.imageSelectedColor.CGColor;
    
    //4. image scale out
    [self.imageShape animateWithKeypath:@"transform.scale" fromValue:0 toValue:1 duration:1 delay:(duration - delayed) usingDamping:7 initialSpringVelocity:10 completion:nil];
    
    //2. circle scale out
    [CATransaction setAnimationDuration:duration];
    self.circleShape.transform = CATransform3DIdentity;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayed * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //3. circle mask scale out
        [CATransaction setAnimationDuration:duration - delayed];
        self.circleShape.mask.transform = CATransform3DMakeScale(scale, scale, 1);
        self.circleShape.fillColor = [self circleEndColor].CGColor;//circle color end
        
        //5. emitter animation
        CABasicAnimation *emitterAnimation = [CABasicAnimation animationWithKeyPath:@"emitterCells.fire.birthRate"];
        emitterAnimation.beginTime = CACurrentMediaTime() + duration / 2;
        emitterAnimation.fromValue = @(30);
        emitterAnimation.toValue = @(0);
        emitterAnimation.duration = 0.1;
        [self.emitterLayer addAnimation:emitterAnimation forKey:@"emitter"];
    });
}

- (void)deselect
{
    [CATransaction setDisableActions:YES];
    self.circleShape.mask.transform = CATransform3DIdentity;
    self.circleShape.transform = CATransform3DMakeScale(0, 0, 1);//circle scale in
    self.circleShape.fillColor = self.circleColor.CGColor;// circle color begin
    
    //image color deselected
    self.imageShape.fillColor = self.imageNormalColor.CGColor;
    
    //image scale normal
    [self.imageShape animateWithKeypath:@"transform.scale" fromValue:1.3 toValue:1 duration:1 delay:0 usingDamping:7 initialSpringVelocity:10 completion:nil];
}

- (CAShapeLayer *)circleShape
{
    if (!_circleShape) {
        _circleShape = [CAShapeLayer layer];
        _circleShape.frame = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        _circleShape.path = path.CGPath;
        _circleShape.fillColor = self.circleColor.CGColor;
        _circleShape.transform = CATransform3DMakeScale(0, 0, 1);
        _circleShape.mask = self.circleMask;
    }
    return _circleShape;
}

- (CAShapeLayer *)circleMask
{
    if (!_circleMask) {
        _circleMask = [CAShapeLayer layer];
        _circleMask.frame = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        [path addArcWithCenter:self.center radius:1 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        _circleMask.path = path.CGPath;
        _circleMask.fillRule = kCAFillRuleEvenOdd;
    }
    return _circleMask;
}

- (CAShapeLayer *)imageShape
{
    if (!_imageShape) {
        _imageShape = [CAShapeLayer layer];
        _imageShape.frame = self.imageFrame;
        _imageShape.position = self.center;
        _imageShape.fillColor = self.imageNormalColor.CGColor;
        _imageShape.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        CALayer *maskLayer = [CALayer layer];
        maskLayer.contents = (id)[UIImage imageNamed:@"like"].CGImage;
        maskLayer.frame = _imageShape.bounds;
        _imageShape.mask = maskLayer;
    }
    return _imageShape;
}

- (CAEmitterLayer *)emitterLayer
{
    if (!_emitterLayer) {
        _emitterLayer = [CAEmitterLayer layer];
        _emitterLayer.emitterPosition = self.center;
        _emitterLayer.emitterSize = CGSizeMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.9);
        _emitterLayer.emitterMode = kCAEmitterLayerOutline;
        _emitterLayer.emitterShape = kCAEmitterLayerCircle;
        _emitterLayer.renderMode = kCAEmitterLayerAdditive;
        _emitterLayer.emitterCells = [self emitterCells];
    }
    return _emitterLayer;
}

- (NSArray *)emitterCells
{
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    
    CGFloat duration = 0.5;
    
    //粒子的名字
    emitterCell.name = @"fire";
    //粒子参数的速度乘数因子
    emitterCell.birthRate = 0;
    emitterCell.lifetime = duration;
    
    //粒子速度!!!关键   < 0 会往圆心飞
    emitterCell.velocity = self.bounds.size.width / 2;
    
    emitterCell.scale = 0.1;
    emitterCell.scaleSpeed = -(emitterCell.scale / duration);
    
    emitterCell.greenRange = 1;
    emitterCell.redRange = 1;
    emitterCell.blueRange = 1;
    
    emitterCell.alphaRange = 1;
    emitterCell.alphaSpeed = -(emitterCell.alphaRange / duration);
    
    CGRect rect = self.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [[self imageSelectedColor] setFill];
    //    [[UIColor whiteColor] setFill];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    emitterCell.contents = (id)[image CGImage];
    
    return @[emitterCell];
}

- (UIColor *)circleColor
{
    if (!_circleColor) {
        _circleColor = self.imageSelectedColor;
    }
    return _circleColor;
}

- (UIColor *)circleEndColor
{
    return self.imageSelectedColor;
//    return [UIColor colorWithRed:205.0/255.0 green:83.0/255.0 blue:166.0/255.0 alpha:1];
}

- (CGRect)imageFrame
{
    CGRect frame = self.bounds;
    CGRect rect = CGRectMake(frame.size.width / 2 - frame.size.width * imageScale / 2,
                             frame.size.height / 2 - frame.size.height * imageScale / 2,
                             frame.size.width * imageScale,
                             frame.size.height * imageScale);
    return rect;
}

- (CGPoint)imageCenter
{
    return CGPointMake(CGRectGetMidX(self.imageFrame), CGRectGetMidY(self.imageFrame));
}

- (void)setEmitterImage:(UIImage *)emitterImage
{
    if (_emitterImage != emitterImage) {
        _emitterImage = emitterImage;
        self.imageShape.mask.contents = (id)emitterImage.CGImage;
    }
}

- (void)setImageNormalColor:(UIColor *)imageNormalColor
{
    if (_imageNormalColor != imageNormalColor) {
        _imageNormalColor = imageNormalColor;
        _imageShape.fillColor = imageNormalColor.CGColor;
    }
}

- (void)setImageSelectedColor:(UIColor *)imageSelectedColor
{
    if (_imageSelectedColor != imageSelectedColor) {
        _imageSelectedColor = imageSelectedColor;
        //update emitterCell color
        self.emitterLayer.emitterCells = [self emitterCells];
    }
}

@end




@interface TTAnimationButton ()

@property (nonatomic, strong) TTEmitterImageView *emitterImageView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation TTAnimationButton

@synthesize imageSelectedColor = _imageSelectedColor;
@synthesize imageNormalColor = _imageNormalColor;

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [UIView animateWithDuration:0.3 animations:^{
        if (highlighted) {
            self.alpha = 0.5;
        } else {
            self.alpha = 1;
        }
    }];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self.emitterImageView select];
    } else {
        [self.emitterImageView deselect];
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:[self placeholdImage:image] forState:state];
    self.image = image;
    if (!self.enableCustomImageSize) {
        [self sizeToFit];
    }
    [self updateEmitter];
}

- (UIColor *)imageSelectedColor
{
    if (!_imageSelectedColor) {
        _imageSelectedColor = [UIColor colorWithRed:221.0/255.0 green:22.0/255.0 blue:72.0/255.0 alpha:1];
    }
    return _imageSelectedColor;
}

- (void)setImageSelectedColor:(UIColor *)imageSelectedColor
{
    if (_imageSelectedColor != imageSelectedColor) {
        _imageSelectedColor = imageSelectedColor;
        self.emitterImageView.imageSelectedColor = imageSelectedColor;
    }
}

- (UIColor *)imageNormalColor
{
    if (!_imageNormalColor) {
        _imageNormalColor = [UIColor lightGrayColor];
    }
    return _imageNormalColor;
}

- (void)setImageNormalColor:(UIColor *)imageNormalColor
{
    if (_imageNormalColor != imageNormalColor) {
        _imageNormalColor = imageNormalColor;
        self.emitterImageView.imageNormalColor = imageNormalColor;
    }
}

//clear background placehold image for button imageView
- (UIImage *)placeholdImage:(UIImage *)image
{
    CGRect rect = self.bounds;
    rect.size = image.size;
    UIGraphicsBeginImageContext(rect.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [[UIColor clearColor] setFill];
    [path fill];
    UIImage *clearImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clearImage;
}

- (void)updateEmitter
{
    if (!self.image) {
        return;
    }
    CGSize imageSize = self.imageView.bounds.size;
    [self.emitterImageView removeFromSuperview];
    self.emitterImageView = [[TTEmitterImageView alloc] initWithFrame:CGRectMake(0, 0, ceil(imageSize.width / imageScale), ceil(imageSize.height / imageScale))];
    
    self.emitterImageView.imageNormalColor = self.imageNormalColor;
    self.emitterImageView.imageSelectedColor = self.imageSelectedColor;
    
    self.emitterImageView.emitterImage = self.image;
    self.emitterImageView.center = self.imageView.center;
    self.imageView.clipsToBounds = NO;
    [self.imageView addSubview:self.emitterImageView];
}

- (void)sizeToFit
{
    [super sizeToFit];
    self.emitterImageView.center = self.imageView.center;
}

@end
