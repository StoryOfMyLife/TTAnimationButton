![image](https://github.com/StoryOfMyLife/TTAnimationButton/blob/master/TTAnimationButtonExample/TTAnimationButtonExample/ScreenShot.gif)

# TTAnimationButton
A vivid button with beautiful selected animation like twitter like button.

Support custom image shaping using UIButton setImage:forState:.

[![Build Status](https://travis-ci.org/facebook/pop.svg)](https://travis-ci.org/facebook/pop)

## Installation

TTAnimationButton is available on [CocoaPods](http://cocoapods.org). Just add the following to your project Podfile:

```ruby
pod 'TTAnimationButton'
```

## Usage

Use like UIButton:

```objective-c
TTAnimationButton *button = [TTAnimationButton buttonWithType:UIButtonTypeCustom];
button.explosionRate = 100;
[button setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
[button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
[button sizeToFit];
```

### Properties

```objective-c
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
```
