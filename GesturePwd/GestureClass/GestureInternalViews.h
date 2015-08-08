//
//  GestureInternalViews.h
//  v1.0
//  by OYXJ, Hawking.HK@gmail.com

#import <UIKit/UIKit.h>

/*
 界面，仿照 QQ的手势锁屏
 */
@interface GestureInternalViews : NSObject

@property(nonatomic, retain) UILabel     * titleLabel;         //页面标题

@property(nonatomic, retain) UIImageView * headImageView;      //顶部图片
@property(nonatomic, retain) UILabel     * headLabel;          //顶部文字

@property(nonatomic, retain) UILabel     * autoDismissLabel;   //自动消失的提示语

@property(nonatomic, retain) UIButton    * btnForgetGesturePwd; //忘记手势密码
@property(nonatomic, retain) UIView      * lineView;            //细线
@property(nonatomic, retain) UIButton    * btnTouchIdUnlock;    //指纹解锁

@end
