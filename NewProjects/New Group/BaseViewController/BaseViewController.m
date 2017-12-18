//
//  BaseViewController.m
//  Notepad
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.current = 1;
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BG_COLOR;
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self CreatLeftBtn];
    [self CreatRightBtn];
}

#pragma mark --返回按钮
-(void)CreatLeftBtn{
    UIButton * backHomeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backHomeBtn.frame=CGRectMake(0, 0, 50, 40);
    _backHomeBtn=backHomeBtn;
    [backHomeBtn setImage:[UIImage imageNamed:@"backHomeBtn"] forState:0];
    backHomeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [backHomeBtn addTarget:self action:@selector(backHomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftImage =[[UIBarButtonItem alloc]initWithCustomView:backHomeBtn];
    //backBarButtonItem
    self.navigationItem.leftBarButtonItem=leftImage;
}
#pragma mark --右按钮
-(void)CreatRightBtn{
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 50, 40);
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _rightButton=rightBtn;
    UIBarButtonItem * rightBtnItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
}






#pragma mark --返回按钮点击事件
-(void)backHomeBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --导航标题设置
-(void)setTitle:(NSString *)title{
    UILabel * namelabel =[UILabel new];
    namelabel.textColor=[UIColor whiteColor];
    namelabel.text=title;
    namelabel.textAlignment=1;
    if (@available(iOS 8.2, *)) {
        namelabel.font=[UIFont systemFontOfSize:15 weight:.3];
    }
    namelabel.frame=CGRectMake(0, 0, 250, 40);
    self.navigationItem.titleView=namelabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableView *)baseTableView
{
    if (!_baseTableView) {
        UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectZero];
        tableView.dataSource=self;
        tableView.delegate=self;
        tableView.rowHeight=70;
        tableView.tableFooterView=[UIView new];
        tableView.backgroundColor=BG_COLOR;
        tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjHeaderRefresh)];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjFooterRefresh)];
        _baseTableView = tableView;
    }
    return _baseTableView;
}
//下拉刷新触发
- (void)mjHeaderRefresh
{
    
}
//上拉加载更多
- (void)mjFooterRefresh
{
    
}
@end
