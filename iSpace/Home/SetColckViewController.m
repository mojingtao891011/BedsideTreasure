//
//  SetColckViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-4.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "SetColckViewController.h"
#import "ListViewController.h"

@interface SetColckViewController ()

@end

@implementation SetColckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"闹钟设置" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _repeatView.layer.borderWidth = 1.0 ;
    _repeatView.layer.borderColor = [UIColor lightGrayColor].CGColor ;
    //_repeatView.layer.cornerRadius = 5.0 ;
    _styleVIew.clipsToBounds = YES ;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark------设置音量是否慢慢变大
- (IBAction)selectedButton:(id)sender {
    UIButton *button = (UIButton*)sender ;
    button.selected = !button.selected ;
}
#pragma mark------点击响铃方式列表框
- (IBAction)clickstyleButton:(id)sender {
    
    UIButton *button = (UIButton*)sender ;
    if (!_isOpenRingType) {
        [UIView animateWithDuration:0.5 animations:^{
            _styleVIew.height = 90 ;
        }];

    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _styleVIew.height = 30 ;
        }];
    }
    if (button.tag == 1) {
        _isOpenRingType = !_isOpenRingType ;
        return ;
    }
    
    NSString *titleStr = [button titleForState:UIControlStateNormal];
    NSString *changeTitle = [_showButton titleForState:UIControlStateNormal];
    [_showButton setTitle:titleStr forState:UIControlStateNormal];
    [button setTitle:changeTitle forState:UIControlStateNormal];
    _isOpenRingType = !_isOpenRingType ;
    //kvo 来监听响铃方式改变时对应列表也跟着变
    [self titleCorrespondList:titleStr];
}
#pragma mark----根据响铃方式标题对应相应列表
- (void)titleCorrespondList:(NSString*)title
{
    _musicArr = [NSMutableArray arrayWithObjects:@"江南stlye", nil] ;
    _recordArr = [NSMutableArray arrayWithObjects:@"20140415", nil];
    _FMArr = [NSMutableArray arrayWithObjects:@"深圳交通", nil];
    NSString *showStr ;
    if ([title isEqualToString:@"音乐"]) {
       showStr = _musicArr[0];
    }else if ([title isEqualToString:@"广播"]){
        showStr = _FMArr[0];
    }else if ([title isEqualToString:@"语音"]){
        showStr = _recordArr[0];
    }
   
    _showTitle.text = showStr ;
  
}
#pragma mark----保存闹钟设置
- (IBAction)getDate:(id)sender {
  
    NSDate *date = [_dataPicker date];
    NSLog(@"date = %@" , date);
    NSString *tagStr = [NSString stringWithFormat:@"%d" , _clockButtonTag];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:date forKey:tagStr];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"123" object:dict];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView ;
    hud.labelText = @"loading" ;
    [self performSelector:@selector(hideHud) withObject:nil afterDelay:2.0];
}
#pragma mark----设置重复日期
- (IBAction)repeatAction:(id)sender {
    UIButton *button = (UIButton*)sender ;
    button.selected = !button.selected ;
    [button setBackgroundImage:[self imageWithColor:buttonBackgundColor] forState:UIControlStateSelected];
    
}
#pragma mark----响铃方式－－内容列表
- (IBAction)listActin:(id)sender {
    
    ListViewController *listViewCtl = [[ListViewController alloc]init];
    //设置listViewCtl导航栏标题
    NSString *titleStr = [NSString stringWithFormat:@"%@列表" , [_showButton titleForState:UIControlStateNormal]];
    listViewCtl.titleLabel.text = titleStr ;
    [listViewCtl.titleLabel sizeToFit];
    [self.navigationController pushViewController:listViewCtl animated:YES];
}
#pragma mark----重复－－点击时的背景色
-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)hideHud
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
