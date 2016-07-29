//
//  ViewController.m
//  TTAnimationButtonExample
//
//  Created by liuty on 16/7/25.
//  Copyright © 2016年 liuty. All rights reserved.
//

#import "ViewController.h"
#import "TTAnimationButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TTAnimationButton *button = [TTAnimationButton buttonWithType:UIButtonTypeCustom];
    button.enableCustomImageSize = YES;
    button.explosionRate = 100;
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"123" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    [button sizeToFit];
    
    button.center = CGPointMake(self.view.frame.size.width / 5, self.view.center.y);
    
    TTAnimationButton *button1 = [TTAnimationButton buttonWithType:UIButtonTypeCustom];
    button1.imageSelectedColor = [UIColor colorWithRed:53.0/255.0 green:131.0/255.0 blue:215.0/255.0 alpha:1];
    button1.enableCustomImageSize = YES;
    button1.explosionRate = 100;
    button1.frame = CGRectMake(0, 0, 30, 30);
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    
    button1.center = CGPointMake(self.view.frame.size.width / 5 * 2, self.view.center.y);
    
    TTAnimationButton *button2 = [TTAnimationButton buttonWithType:UIButtonTypeCustom];
    button2.imageSelectedColor = [UIColor colorWithRed:70.0/255.0 green:197.0/255.0 blue:85.0/255.0 alpha:1];
    button2.enableCustomImageSize = YES;
    button2.explosionRate = 100;
    button2.frame = CGRectMake(0, 0, 30, 30);
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"smile"] forState:UIControlStateNormal];
    
    button2.center = CGPointMake(self.view.frame.size.width / 5 * 3, self.view.center.y);
    
    TTAnimationButton *button3 = [TTAnimationButton buttonWithType:UIButtonTypeCustom];
    button3.enableCustomImageSize = YES;
    button3.imageSelectedColor = [UIColor colorWithRed:247.0/255.0 green:158.0/255.0 blue:16.0/255.0 alpha:1];
    button3.explosionRate = 100;
    button3.frame = CGRectMake(0, 0, 30, 30);
    [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    
    button3.center = CGPointMake(self.view.frame.size.width / 5 * 4, self.view.center.y);
    
    [self.view addSubview:button];
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
}

- (void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
}

@end
