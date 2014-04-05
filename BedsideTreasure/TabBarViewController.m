//
//  TabBarViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "TabBarViewController.h"
#import "FriendsViewController.h"
#import "HomeViewController.h"
#import "RingViewController.h"
#import "SettingViewController.h"
#import "BaseNavViewController.h"

@interface TabBarViewController ()
@end

@implementation TabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//初始化视图
- (void)_initViewController
{
    FriendsViewController *friendsCtl = [[FriendsViewController alloc]init];
    HomeViewController *homeCtl = [[HomeViewController alloc]init];
    RingViewController *ringCtl = [[RingViewController alloc]init];
    SettingViewController *settingCtl = [[SettingViewController alloc]init];
    NSArray *ctlArr = @[ friendsCtl , homeCtl , ringCtl , settingCtl ];
    NSMutableArray *navArr = [[NSMutableArray alloc]initWithCapacity:ctlArr.count];
    for (UIViewController *ctl in ctlArr) {
        BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:ctl];
        nav.delegate = self ;
        [navArr addObject:nav];
    }
    self.viewControllers = navArr ;
    self.tabBar.hidden = YES ;
    [self CustomTabbar];
}
- (void)CustomTabbar
{
    _tabbarView = [[UIView alloc]initWithFrame:CGRectMake(-1, ScreenHeight - 48 , ScreenWidth+2, 49)];
    _tabbarView.layer.borderColor = [UIColor colorWithRed:124/255.0 green:214/255.0 blue:208/255.0 alpha:1.0].CGColor ;
    _tabbarView.layer.borderWidth = 1 ;
    _tabbarView.backgroundColor = ViewBackgroundColor;
    [self.view addSubview:_tabbarView];
    NSArray *imgStateNormalArr = @[@"bt_friends_normal" , @"bt_home_normal" , @"bt_ring_normal" , @"bt_setting_normal" ] ;
    NSArray *imgStateSelectedArr = @[@"bt_friends_pressed" , @"bt_home_pressed" , @"bt_ring_pressed" , @"bt_setting_pressed" ] ;
    NSLog(@"===%@" , [UIImage imageNamed:imgStateNormalArr[0]]);
    for (int i = 0 ; i < imgStateNormalArr.count; i++) {
        UIButton *tabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tabBarButton setFrame:CGRectMake( (ScreenWidth/4 - 45) / 2 + i*80, 2, 45, 45)];
        [tabBarButton setBackgroundImage:[UIImage imageNamed:imgStateNormalArr[i]] forState:UIControlStateNormal];
        [tabBarButton setBackgroundImage:[UIImage imageNamed:imgStateSelectedArr[i]] forState:UIControlStateSelected];
        tabBarButton.tintColor = [UIColor clearColor];
        tabBarButton.tag = 100 + i ;
        if (tabBarButton.tag == 100) {
            _selectedButton = tabBarButton ;
            _selectedButton.selected = YES ;
        }
        [tabBarButton addTarget:self action:@selector(selectleViewController:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:tabBarButton];
    }
   
}
- (void)selectleViewController:(UIButton*)button
{
    self.selectedIndex = button.tag - 100 ;
    button.selected = ! button.selected ;
    _selectedButton.selected = NO ;
    _selectedButton = button ;
}
//是否要显示BarItem
- (void)showBarItem:(BOOL)show
{
    [UIView animateWithDuration:0 animations:^{
        if (show) {
            self.tabBar.hidden = YES;
            [_tabbarView setFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth,49)];
        }else{
           
            [_tabbarView setFrame:CGRectMake(-ScreenWidth, ScreenHeight-49, ScreenWidth,49)];
        }
        
    }];
    [self resizeView:show];
}
//隐藏tabBar后调整frame
- (void)resizeView:(BOOL)isFrame{
    
    
    for (UIView *subView in self.view.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (isFrame) {
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, ScreenWidth, ScreenHeight-49)];
            }else{
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, ScreenWidth, ScreenHeight)];
            }
        }
    }}

#pragma mark-----UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    int count = navigationController.viewControllers.count ;
    if (count == 1) {
        [self showBarItem:YES];
    }else{
        [self showBarItem:NO];
    }
}

@end
