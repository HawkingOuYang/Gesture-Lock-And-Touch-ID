//
//  BaseViewController.h
//  GestureSDK_Demo
//
//  Created by OYXJ on 15/8/9.
//  Copyright (c) 2015年 OYXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    CGRect  m_mainContentViewFrame;
}

/**
 *  显示导航栏左侧的按钮
 *
 *  @param aTitle
 *  @param aImage
 *  @param hImage
 */
- (void)showCustomNavigationLeftButtonWithTitle:(NSString *)aTitle
                                          image:(UIImage *)aImage
                                hightlightImage:(UIImage *)hImage;

@end
