//
//  GestureSettingViewController.m
//  TemplatesProject
//
//  Created by OYXJ on 15/8/4.
//  Copyright (c) 2015年 OYXJ. All rights reserved.
//  手势设置页面

#import "GestureSettingViewController.h"

#import "TouchIdUnlock.h"//指纹解锁
#import "DrawPatternLockViewController.h"//绘制手势
#import "GestureTool_Public.h"//手势工具
#import "GestureIntroduceViewController.h"//手势密码介绍页面

#import "SystemDefine.h"


@interface CMSwitch : UISwitch
@property (nonatomic, retain) NSIndexPath * indexPath;
@end
@implementation CMSwitch
- (void)dealloc {
    self.indexPath = nil;
    [super dealloc];
}
@end


@interface GestureSettingViewController ()<
UITableViewDataSource,
UITableViewDelegate>
{
    UITableView * _tableView;
    BOOL          _isShowOther;
    BOOL          _isTouchIdAllowBySystem;
}
@end

@implementation GestureSettingViewController

- (void)dealloc
{
    if (_tableView) {
        [_tableView release];
        _tableView = nil;
    }
    
    if (_popBackBlock) {
        Block_release(_popBackBlock);
        _popBackBlock = nil;
    }
    
    [super dealloc];
}

- (UIView *)mainContentView
{
    _isTouchIdAllowBySystem = [[TouchIdUnlock sharedInstance] isTouchIdEnabledOrNotBySystem];
    
    
    UIView * mainView = [[UIView alloc] initWithFrame:m_mainContentViewFrame];
    
    _tableView = [[UITableView alloc] initWithFrame:mainView.bounds style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor clearColor];

    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
    [mainView addSubview:_tableView];
    return [mainView autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationLeftButtonWithTitle:nil
                                            image:[UIImage imageNamed:@"nav_btn_back_nor"]
                                  hightlightImage:[UIImage imageNamed:@"nav_btn_back_pre"]];
}


#pragma mark- 按钮事件
- (void)onNavigationLeftButtonClicked:(UIButton *)sender
{
    BOOL isHasGestureInNSUserDefaults = [GestureTool_Public isHasGesturePwdStringWhichSavedInNSUserDefaults];
    if (isHasGestureInNSUserDefaults)
    {
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index -2 >= 0)
        {
            UIViewController * previousVC = [self.navigationController.viewControllers objectAtIndex:index -1];
            UIViewController * formerVC =   [self.navigationController.viewControllers objectAtIndex:index -2];
            if ([previousVC isKindOfClass:[GestureIntroduceViewController class]]) {
                //越过GestureIntroduceViewController，即“手势密码介绍页面”。
                [self.navigationController popToViewController:formerVC animated:YES];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
       [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    if (_popBackBlock)
    {
        _popBackBlock();
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * num = [defaults objectForKey:KEY_UserDefaults_isGestureLockEnabledOrNotByUser];
    
    _isShowOther = [num boolValue];
    

    if (_isShowOther) {
        if (_isTouchIdAllowBySystem) {
            return 4;
        }else{
            return 4;
        }
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            if (_isTouchIdAllowBySystem) {
                return 1;
            }else{
                return 0;
            }
            break;
            
        case 3:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:identifier]
                autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    
    CMSwitch * sw = [[[CMSwitch alloc] init] autorelease];
    sw.onTintColor = SystemBlue;
    
    [sw addTarget:self action:@selector(sw:) forControlEvents:UIControlEventValueChanged];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:{
                    cell.textLabel.text = @"开启密码锁定";
                    cell.accessoryView = sw;
                    
                    /**
                     用户是否 想使用手势锁屏，这个配置，保存在NSUserDefaults。
                     */
                    NSNumber * num = [defaults objectForKey: KEY_UserDefaults_isGestureLockEnabledOrNotByUser];
                    
                    sw.on = [num boolValue];
                    sw.indexPath = indexPath;
                }break;
                    
                default:
                    break;
            }
        }break;
            
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:{
                    cell.textLabel.text = @"显示手势轨迹";
                    cell.accessoryView = sw;
                    
                    /**
                     显示手势轨迹
                     */
                    NSNumber * num = [defaults objectForKey: KEY_UserDefaults_isShowGestureTrace];

                    sw.on = [num boolValue];
                    sw.indexPath = indexPath;
                }break;
                    
                default:
                    break;
            }
        }break;
            
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:{
                    cell.textLabel.text = @"开启Touch ID指纹解锁";
                    cell.accessoryView = sw;
                    
                    /**
                     用户是否 想使用touchID解锁，这个配置，保存在NSUserDefaults。
                     */
                    NSNumber * num = [defaults objectForKey: KEY_UserDefaults_isTouchIdEnabledOrNotByUser];
                    
                    sw.on = [num boolValue];
                    sw.indexPath = indexPath;
                }break;
                    
                default:
                    break;
            }
            
        }break;
            
        case 3:
        {
            switch (indexPath.row)
            {
                case 0:{
                    cell.textLabel.text = @"修改手势密码";
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                }break;
                    
                default:
                    break;
            }
        }break;
            
        default:
        {
            cell.textLabel.text = nil;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.accessoryView = nil;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }break;
    }
    
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 2:
            if (_isTouchIdAllowBySystem) {
                return @"开启后,可使用Touch ID解锁";
            }else{
                return nil;
            }
            break;
            
        default:
            return nil;
            break;
    }
}



#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float defaultH = 49;
    
    switch (indexPath.section)
    {
        case 2:
            if (_isTouchIdAllowBySystem) {
                return defaultH;
            }else{
                return 0;
            }
            break;
            
        default:
            return defaultH;
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 2:
            if (_isTouchIdAllowBySystem) {
                return UITableViewAutomaticDimension;
            }else{
                return 0.1;
            }
            break;
            
        default:
            return UITableViewAutomaticDimension;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 2:
            if (_isTouchIdAllowBySystem) {
                return UITableViewAutomaticDimension;
            }else{
                return 0.1;
            }
            break;
            
        default:
            return UITableViewAutomaticDimension;
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.5];
    
    switch (indexPath.section) {
        case 3: {
            switch (indexPath.row) {
                case 0: {
                    
                    DrawPatternLockViewController * dplVC = [[DrawPatternLockViewController alloc] init];
                    dplVC.drawPatternCtlType = kDrawPatternCtlTypeGesturePwdModify;
                    
                    dplVC.title = @"手势密码";
                    [self.navigationController pushViewController:dplVC animated:YES];
                    [dplVC release];
                    
                }break;
                    
                default:
                    break;
            }
        }break;
            
        default:
            break;
    }
}


#pragma mark - 事件

- (void)sw:(CMSwitch *)sender
{
    BOOL isON = sender.isOn;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int section = (int)sender.indexPath.section;
    int row = (int)sender.indexPath.row;
    switch (section) {
        case 0:
        {
            switch (row)
            {
                case 0:{
                    /**
                     用户是否 想使用手势锁屏，这个配置，保存在NSUserDefaults。
                     */
                    [defaults setObject:[NSNumber numberWithBool:isON] forKey:KEY_UserDefaults_isGestureLockEnabledOrNotByUser];
                    [defaults synchronize];
                    
                    _isShowOther = isON;
                    [_tableView reloadData];
                }break;
                    
                default:
                    break;
            }
        }break;
            
        case 1:
        {
            switch (row)
            {
                case 0:{
                    /**
                     显示手势轨迹
                     */
                    [defaults setObject:[NSNumber numberWithBool:isON] forKey:KEY_UserDefaults_isShowGestureTrace];
                    [defaults synchronize];
                }break;
                    
                default:
                    break;
            }
        }break;
            
        case 2:
        {
            switch (row)
            {
                case 0:{
                    /**
                     用户是否 想使用touchID解锁，这个配置，保存在NSUserDefaults。
                     */
                    [defaults setObject:[NSNumber numberWithBool:isON] forKey:KEY_UserDefaults_isTouchIdEnabledOrNotByUser];
                    [defaults synchronize];
                }break;
                    
                default:
                    break;
            }
        }break;
            
        case 3:
        {
            switch (row)
            {
                case 0:{

                }break;
                    
                default:
                    break;
            }
        }break;
            
        default:
            break;
    }
    
}


@end
