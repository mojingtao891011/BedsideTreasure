//
//  FeedbackViewController.m
//  iSpace
//
//  Created by 莫景涛 on 14-5-9.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "FeedbackViewController.h"
#import "GTMBase64.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

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
    _arrCell = [[NSArray alloc]initWithObjects:_conOurCell, _ratingCell , _feedbackCell , _submitCell, nil];
    [self setExtraCellLineHidden:_feedbackTableView];
    _content.layer.borderWidth = 1.0 ;
    _content.layer.borderColor = buttonBackgundColor.CGColor ;
    _content.layer.cornerRadius = 5.0 ;
    
    _clearBgView.clipsToBounds = YES ;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBgViewAction:)];
    [self.view addGestureRecognizer:tap];
    UITapGestureRecognizer *tap_nomalView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclearBgViewAction:)];
    [_normalStarView addGestureRecognizer:tap_nomalView];
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-------note
- (void)keyboardWillShow:(NSNotification*)showNote
{
    if (ScreenHeight > 480) {
        return ;
    }
    CGRect rect =[[showNote userInfo][@"UIKeyboardFrameEndUserInfoKey"]CGRectValue] ;
    _changeheight = _feedbackCell.bottom - rect.size.height +20;
    [UIView animateWithDuration:0.3 animations:^{
        _feedbackTableView.top = - _changeheight ;
    }];
    
}
- (void)keyboardWillHide:(NSNotification*)hideNote
{
    
    [UIView animateWithDuration:0.3 animations:^{
        _feedbackTableView.top = _feedbackTableView.top + _changeheight ;
    }];
}
#pragma mark-------TapGestureRecognizer
- (void)tapBgViewAction:(UITapGestureRecognizer*)tap
{
    [_content resignFirstResponder];
}
- (void)tapclearBgViewAction:(UITapGestureRecognizer*)tap
{
    CGPoint point = [tap locationInView:_clearBgView];
    _clearBgView.width = point.x ;
    _scores = [NSString stringWithFormat:@"%0.1f" ,point.x /150 *5 ] ;
    
}
#pragma mark-------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID" ;
    UITableViewCell *feedbackCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (feedbackCell == nil) {
       
        feedbackCell = _arrCell[indexPath.row];
    }
    
    return feedbackCell ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *heightArr = @[@"100" , @"50" , @"150" , @"44"];
    return [heightArr[indexPath.row] floatValue];
}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
#pragma mark----- 提交反馈信息
- (IBAction)submitAction:(id)sender {
    NSString *sumbitContent = _content.text ;
    if (_content.text.length == 0 && _scores == nil) {
        UIAlertView *alertView =[ [UIAlertView alloc]initWithTitle:nil message:@"亲～，您还未输入反馈信息哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        return ;
    }if (_scores == nil) {
        _scores = @"-1" ;
    }
    NSData *data = [sumbitContent dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseStr = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [NetDataService needCommand:@"2077" andNeedUserId:@"79" AndNeedBobyArrKey:@[@"level" , @"suggest"] andNeedBobyArrValue:@[ _scores,baseStr]];
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        
        int error = [result[@"message_body"][@"error"] intValue] ;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == 0) {
                UIAlertView *alertView =[ [UIAlertView alloc]initWithTitle:nil message:@"亲～，感谢您反馈信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
                return ;
            }

        });
}];

}
@end
