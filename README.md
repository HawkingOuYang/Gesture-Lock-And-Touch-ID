# Gesture Lock Screen Like QQ  And Touch ID
Gesture Lock Screen like QQ And Touch ID，高仿QQ手势锁屏，指纹解锁。

Note:
备注：

There are two conditions for Touch ID:
指纹解锁 需要满足条件：

 1 run on iOS Device (not iOS Simulator)
 1 用真机调试，
 
 2 run with iOS 8.0 and later
 2 手机系统 iOS8.0以及之后
 
With the above two conditions, my code is automatically adapted, and you can see and use "Touch ID".
才能看到指纹解锁的功能。

By the way, the "Gesture password" is recored as "digit numbers 0~9", and the "digit numbers 0~9" are stored in NSUserDefaults, which is not safe if somebody Hack into SandBox, so you need to encrypt the "digit numbers 0~9" using md5 or other RSA. 
这个手势密码，是用数字0~9记录的，保存在NSUserDefaults，如果有人黑进了您的沙盒，这个密码很容易被拿走，所以您可以用md5或者其它RSA进行加密。


![gesturelockscreen](https://cloud.githubusercontent.com/assets/12937445/9153494/badf1c56-3e8c-11e5-918f-e6082cc0c536.gif)

