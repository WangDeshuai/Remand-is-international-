//
//  BasiInfoView.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/14.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "BasiInfoView.h"
@interface BasiInfoView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
//@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,assign)CGFloat heightSelf;//高度
@property(nonatomic,strong)NSArray * dataArray;//传递过来数据源
@property(nonatomic,copy)NSString *name;//选择好的name
@end
@implementation BasiInfoView

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
//        [btn setTitleColor:Main_Color forState:0];
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
    cell.textLabel.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row]];
    cell.textLabel.textAlignment=1;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _name=_dataArray[indexPath.row];
}

//取消
-(void)canBtnClink{
    int g =ScreenHeight/3;
    self.frame=CGRectMake(0, ScreenHeight-g, ScreenWidth, g);
    [UIView animateWithDuration:.6 animations:^{
        self.frame=CGRectMake(0, ScreenHeight, ScreenWidth, g);
    } completion:^(BOOL finished) {
        [self dissmiss];
    }];
}
//确认
-(void)sureBtnClick{
    if ([[ToolClass isString:_name] isEqualToString:@""]) {
        [LCProgressHUD showMessage:@"请选择类型"];
    }else{
        self.NameBlock(_name,[ToolClass registTyple:_name]);
        [self canBtnClink];
    }
   
}



-(void)jiazaiView{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];//
    view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
     view.backgroundColor = [UIColor blackColor];
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
