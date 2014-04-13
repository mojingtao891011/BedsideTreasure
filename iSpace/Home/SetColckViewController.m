//
//  SetColckViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-4.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "SetColckViewController.h"

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
    _styleVIew.clipsToBounds = YES ;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (IBAction)selectedButton:(id)sender {
    UIButton *button = (UIButton*)sender ;
    button.selected = !button.selected ;
}

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
}

- (IBAction)getDate:(id)sender {
  
    NSDate *date = [_dataPicker date];
    NSString *tagStr = [NSString stringWithFormat:@"%d" , _clockButtonTag];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:date forKey:tagStr];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"123" object:dict];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView ;
    hud.labelText = @"loading" ;
    [self performSelector:@selector(hideHud) withObject:nil afterDelay:2.0];
}
- (void)hideHud
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
