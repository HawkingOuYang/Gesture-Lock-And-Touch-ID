//
//  GestureSettingViewController.h
//  TemplatesProject
//
//  Created by OYXJ on 15/8/4.
//  Copyright (c) 2015年 OYXJ. All rights reserved.
//  手势设置页面

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

/**
 用户是否 想使用手势锁屏，这个配置，保存在NSUserDefaults。
 */
#ifndef KEY_UserDefaults_isGestureLockEnabledOrNotByUser
    #define KEY_UserDefaults_isGestureLockEnabledOrNotByUser @"KEY_UserDefaults_isGestureLockEnabledOrNotByUser"
#endif

/**
 显示手势轨迹
 */
#ifndef KEY_UserDefaults_isShowGestureTrace
    #define KEY_UserDefaults_isShowGestureTrace              @"KEY_UserDefaults_isShowGestureTrace"
#endif

/**
 用户是否 想使用touchID解锁，这个配置，保存在NSUserDefaults。
 */
#ifndef KEY_UserDefaults_isTouchIdEnabledOrNotByUser
    #define KEY_UserDefaults_isTouchIdEnabledOrNotByUser     @"KEY_UserDefaults_isTouchIdEnabledOrNotByUser"
#endif



typedef void (^PopBackBlock)(void);
/**
 手势设置页面
 */
@interface GestureSettingViewController : BaseViewController
/**
 返回上一级页面时调用。请使用的人，注意避免 block造成retain-cycle
 */
@property (nonatomic, copy) PopBackBlock popBackBlock;
@end
