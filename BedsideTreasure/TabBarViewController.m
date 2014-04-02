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
        [navArr addObject:nav];
    }
    self.viewControllers = navArr ;
    self.tabBar.hidden = YES ;
    [self CustomTabbar];
}
- (void)CustomTabbar
{
    UIView *tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 49 , ScreenWidth, ScreenHeight - 49)];
    [self.view addSubview:tabbarView];
    
    for (int i = 0 ; i < 4; i++) {
        UIButton *tabBarButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [tabBarButton setFrame:CGRectMake(i*ScreenWidth/4, 0, ScreenWidth/4, 49)];
        tabBarButton.tag = 100 + i ;
        [tabBarButton addTarget:self action:@selector(selectleViewController:) forControlEvents:UIControlEventTouchUpInside];
        [tabBarButton setTitle:[NSString stringWithFormat:@"%d" , i] forState:UIControlStateNormal];
        [tabbarView addSubview:tabBarButton];
    }
   
}
- (void)selectleViewController:(UIButton*)button
{
    NSLog(@"%d" , button.tag);
    self.selectedIndex = button.tag - 100 ;
}
@end
