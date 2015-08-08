//
//  GestureLockScreen.h
//  v1.0
//  by OYXJ, Hawking.HK@gmail.com

#import <UIKit/UIKit.h>
#import "DrawPatternLockViewController.h"//手势界面

typedef enum {
    GestureLockScreenTypeGesturePwdSetup = 0, //登录成功后 --- 设置 手势密码
    GestureLockScreenTypeGesturePwdModify,    //设置页面的 --- 修改 手势密码
    GestureLockScreenTypeGesturePwdVerify,    //已设过手势 --- 验证 手势密码
} GestureLockScreenType;

@interface GestureLockScreen : NSObject <DrawPatternLockViewControllerDelegate>
{
    @private
    UIWindow * _gestureWindow;  //手势Window
    DrawPatternLockViewController * _gestureViewCtl;//手势界面
}
@property (nonatomic, retain) NSString * currentAccountStr;

/**
 单例
 */
+ (instancetype)sharedInstance;

- (void)showGestureWindowByType:(GestureLockScreenType)aGestureLockScreenType;

- (void)hide;

@end
