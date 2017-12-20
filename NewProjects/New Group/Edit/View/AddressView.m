//
//  AddressView.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/20.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "AddressView.h"
@interface AddressView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,assign)CGFloat heightSelf;//高度
@property(nonatomic,strong)NSArray * dataArray;//传递过来数据源
@property(nonatomic,copy)NSString *name;//选择好的name
@property(nonatomic,copy)NSString * code;
@end
@implementation AddressView

-(id)initWithFrame:(CGRect)frame TitleName:(NSString*)titlename  AndDataArr:(NSArray*)dataArr{
    self=[super initWithFrame:frame];
    if (self) {
        _heightSelf=frame.size.height;
        _dataArray=dataArr;
      
        //灰色背景
        [self jiazaiView];
        UIView * headerView =[UIView new];
        headerView.backgroundColor=Main_Color;
        [self sd_addSubviews:@[headerView]];
        headerView.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .heightIs(44);
        
        
        
        //取消
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"取消" forState:0];
        [btn addTarget:self action:@selector(canBtnClink) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [headerView sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(headerView, 0)
        .topSpaceToView(headerView, 0)
        .heightIs(44)
        .widthIs(50);
        //确认
        UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:0];
        //        [sureBtn setTitleColor:Main_Color forState:0];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView sd_addSubviews:@[sureBtn]];
        sureBtn.sd_layout
        .rightSpaceToView(headerView, 0)
        .topSpaceToView(headerView, 0)
        .heightIs(44)
        .widthIs(50);
        
        //标题
        UILabel * titleLabel =[UILabel new];
        titleLabel.text=titlename;
        titleLabel.textAlignment=1;
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.font=[UIFont systemFontOfSize:16];
        [headerView sd_addSubviews:@[titleLabel]];
        titleLabel.sd_layout
        .leftSpaceToView(btn, 10)
        .rightSpaceToView(sureBtn, 10)
        .topSpaceToView(headerView, 0)
        .heightIs(44);
        
        [self CreatTableView];
        
        
        
        
    }
    
    return self;
}

-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 44, ScreenWidth, _heightSelf-44) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.rowHeight=50;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=[UIColor whiteColor];
    [self addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSDictionary * dic =_dataArray[indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"country_name"];;
    cell.textLabel.textAlignment=1;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic =_dataArray[indexPath.row];
    _name=[dic objectForKey:@"country_name"];
    _code=[dic objectForKey:@"country_code"];
    
}

//取消
-(void)canBtnClink{
//    int g =ScreenHeight/2;
    self.frame=CGRectMake(0, ScreenHeight-_heightSelf, ScreenWidth,_heightSelf);
    [UIView animateWithDuration:animationTime animations:^{
        self.frame=CGRectMake(0, ScreenHeight, ScreenWidth, _heightSelf);
    } completion:^(BOOL finished) {
        [self dissmiss];
    }];
}
//确认
-(void)sureBtnClick{
    if ([[ToolClass isString:_name] isEqualToString:@""]) {
        [LCProgressHUD showMessage:@"请选择类型"];
    }else{
        self.ControlBlock(_name, _code);
        [self dissmiss];
    }
    
}

-(void)jiazaiView{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];//
    view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    view.backgroundColor = [UIColor blackColor];
    [view addTarget:self action:@selector(canBtnClink) forControlEvents:UIControlEventTouchUpInside];
    view.alpha = 0.1;
    view.tag=1000;
    [window addSubview:view];
}
- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
}
-(void)dissmiss{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView * view =[window viewWithTag:1000];
    [view removeFromSuperview];
    [self removeFromSuperview];
    
}
@end
