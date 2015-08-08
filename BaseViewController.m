//
//  BaseViewController.m
//  GestureSDK_Demo
//
//  Created by OYXJ on 15/8/9.
//  Copyright (c) 2015年 OYXJ. All rights reserved.
//

#import "BaseViewController.h"


/**
 状态栏高度
 #define heightOfStatusBar   20
 */
#define heightOfStatusBar   20
//#define heightOfStatusBar   [[UIApplication sharedApplication] statusBarFrame].size.height



@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark -
/**
 *  是否显示导航栏；默认显示导航栏,如果不显示导航栏，则在子类中重写。
 */
- (BOOL)showNavigationBar
{
    return YES;
}

/**
 *  是否显示底部标签菜单栏；默认不显示,如果显示底部标签菜单栏，则在子类中重写。
 */
- (BOOL)showBottomTabBar
{
    return NO;
}

/**
 *  导航栏的高度；默认值44，如果高度不等于44，则在子类中重写。
 */
- (float)heightOfNavigationBar
{
    return 44;
}

/**
 *  底部标签菜单栏的高度；默认值50；如果高度不等于50，则在子类中重写。
 */
- (float)heightOfBottomTabBar
{
    return 50;
}

/**
 *  返回主内容视图，默认值为空，如果继承BaseViewController，一般都需要重写此方法。
 *  重写此方法后，则不能重写loadView方法，不然会导致此方法失效。
 *  如果不重写此方法，一定要重写loadView方法，这样才能保证视图初始化成功。
 */
#warning 注意这里
- (UIView *)mainContentView
{
    return nil;
}



#pragma mark - init
- (void)initMainContentViewFrame
{
    float statusBarHeight = heightOfStatusBar;
    
    float navHeight = [self heightOfNavigationBar];
    if (![self showNavigationBar])
    {
        navHeight = 0;
    }
    float tabbarHeight = [self heightOfBottomTabBar];
    if (![self showBottomTabBar])
    {
        tabbarHeight = 0;
    }
    
    UIScreen *scr = [UIScreen mainScreen];
    CGRect rect = scr.bounds;
    if(self.interfaceOrientation == UIDeviceOrientationLandscapeLeft ||
       self.interfaceOrientation == UIDeviceOrientationLandscapeRight )
    {
        float width  = MAX(scr.bounds.size.width, scr.bounds.size.height);
        float height = MIN(scr.bounds.size.width, scr.bounds.size.height);
        rect.size.width  = width;
        rect.size.height = height;
    }
    
    BOOL isShowNavBar = [self showNavigationBar];
    if (isShowNavBar)
    {
        m_mainContentViewFrame = CGRectMake(0, 0,
                                            rect.size.width,
                                            rect.size.height - (statusBarHeight + navHeight) - tabbarHeight);
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    else
    {
        m_mainContentViewFrame = CGRectMake(0, 0,
                                            rect.size.width,
                                            rect.size.height - statusBarHeight - tabbarHeight);
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            m_mainContentViewFrame.origin.y = heightOfStatusBar;
        }
    }
}


#pragma mark - life cycle

- (id)init
{
    if(self = [super init])
    {
        /**
         初始化主内容视图位置
         */
        [self initMainContentViewFrame];
    }
    return self;
}

- (void)loadView
{
    /**
     注释[super loadView];
     by OYXJ on 2015/06/15
     
     1. 官方文档：UIViewController Reference，对 - (void)loadView 说明：
     You can override this method in order to create your views manually. If you choose to do so, assign the root view of your view hierarchy to the view property. The views you create should be unique instances and should not be shared with any other view controller object. Your custom implementation of this method should not call super.
     
     2. 个人推测：[super loadView];
     由于系统的惰性加载 和 当前loadView的写法，会泄漏一个view的内存。
     
     3. 实操已证：注释[super loadView];之后的风险:
     子类可能在重写 - (UIView *)mainContentView 时，直接access(读取)self.view，
     即，如 UIView *someView = [[UIView alloc] initWithFrame:self.view.bounds];
     造成 - (void)loadView 与 - (UIView *)mainContentView的死循环。
     
     4. 对于3的风险，截至2015/06/15，本人OYXJ已经规避此风险。
     **/
    
    /**
     [super loadView];
     */
    
    
    UIView *contentView = [self mainContentView];
    NSAssert(contentView!=nil, @"Subclass must implepment mainContentView.");
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [view addSubview:contentView];
    
    self.view = view;
    
    view.backgroundColor = [UIColor redColor];
    
    [view release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)dealloc
{
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 自定义

/**
 *  显示导航栏左侧的按钮
 *
 *  @param aTitle
 *  @param aImage
 *  @param hImage
 */
- (void)showCustomNavigationLeftButtonWithTitle:(NSString *)aTitle image:(UIImage *)aImage hightlightImage:(UIImage *)hImage
{
    //导航栏的左边按钮
    UIBarButtonItem *leftBarButtonItem = [[[UIBarButtonItem alloc] init] autorelease];
    [leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
    [leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    if (aTitle.length > 0)
    {
        NSString * titleStr = aTitle;
        if ([titleStr length] < 3)
        {
            titleStr = [NSString stringWithFormat:@"   %@",aTitle];
        }
        
        [leftBarButtonItem setTitle:titleStr];
        
        NSMutableDictionary *titleTextAttributes = [[NSMutableDictionary alloc] init];
        [titleTextAttributes setObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
        [titleTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [leftBarButtonItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        [titleTextAttributes release];
    }
    
    if (aImage)
    {
        //        [leftBarButtonItem setBackgroundImage:aImage forState:UIControlStateNormal barMetrics:UIBarMetricsCompactPrompt];
        [leftBarButtonItem setImage:aImage];
    }
    
    if (hImage)
    {
        //        [leftBarButtonItem setBackgroundImage:hImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsCompactPrompt];
    }
    
    
    [leftBarButtonItem setTarget:self];
    [leftBarButtonItem setAction:@selector(onNavigationLeftButtonClicked:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    /**
     *  The gesture recognizer responsible for popping the top view controller off the navigation stack. (read-only)
     */
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}


#pragma mark - 按钮事件

- (void)onNavigationLeftButtonClicked:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
