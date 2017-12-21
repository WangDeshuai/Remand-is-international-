//
//  AreaView.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/20.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "AreaView.h"
#import "LeftMyAdressCell.h"
@interface AreaView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * leftTableView;
@property(nonatomic,strong)UITableView * centerTableView;
@property(nonatomic,strong)UITableView * rightTableView;
@property(nonatomic,assign)CGFloat heightSelf;//高度
@property(nonatomic,copy)NSString *name;//选择好的name
@property(nonatomic,strong)NSMutableArray * provincesArr;//存放省
@property(nonatomic,strong)NSMutableArray * cityArr;//存放市
@property(nonatomic,strong)NSMutableArray * xianArr;//存放县
@property (nonatomic,assign)CGFloat width;//表的宽度
@property (nonatomic,copy)NSString * nameText;//最终选择的结果(name)
@property (nonatomic,copy)NSString * codeText;//最终结果对应的code(code)
@end
@implementation AreaView

-(id)initWithFrame:(CGRect)frame TitleName:(NSString*)titlename  AndDataArr:(NSMutableArray*)dataArr{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _heightSelf=frame.size.height;
        _cityArr=[NSMutableArray new];
        _xianArr=[NSMutableArray new];
        _provincesArr=dataArr;//省(里面包含了所有的数据源)
        _nameText=@"";
        _codeText=@"";
        //1.从省中取出市的数组进行判断
        NSDictionary * dic =_provincesArr[0];
        NSArray * arr =[dic objectForKey:@"areas"];//城市的数组
        //2.如果数组=0,说明没有市,tableView只有1个
        if (arr.count==0) {
            //只有1层
            _width=ScreenWidth;
        }else{
        //3.如果数组有值,说明有城市,从城市中在取出 县的数组
            NSDictionary * dic2 =arr[0];
            NSArray * arr2 =[dic2 objectForKey:@"areas"];//县的数组
        //4.如果县的数组个数=0 说明没有县城,tableView只有2个
            if (arr2.count==0) {
                //只有2层,改变宽度
                _width=ScreenWidth/2;
            }else{
       //5.如果县数组个数有值,则说明有县城,tableView只有3个
                _width=ScreenWidth/3;
            }
            
        }
        
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
        
        [self CreatLeftTableView];
        
        
    }
    
    return self;
}
#pragma  mark ---tbaleView创建
-(void)CreatLeftTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 44, _width, _heightSelf-44) style:UITableViewStylePlain];

    tableView.dataSource=self;
    tableView.delegate=self;
    _leftTableView=tableView;
    tableView.rowHeight=50;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=[UIColor whiteColor];
    [self addSubview:tableView];
    
}
//中间的tableView
-(void)CreatCenterTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(_width, 44, _width, _heightSelf-44) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _centerTableView=tableView;
    tableView.rowHeight=50;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=[UIColor whiteColor];
    [self addSubview:tableView];
    
}
//右边的tableView
-(void)CreatRightTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(_width*2, 44, _width, _heightSelf-44) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _rightTableView=tableView;
    tableView.rowHeight=50;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=[UIColor whiteColor];
    [self addSubview:tableView];
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (_leftTableView==tableView) {
        return _provincesArr.count;
    }else if (_centerTableView==tableView){
        return _cityArr.count;
    }else{
        return _xianArr.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftMyAdressCell * cell =[LeftMyAdressCell cellWithTableView:tableView];

    if (_leftTableView==tableView) {
       NSDictionary * proDic =_provincesArr[indexPath.row];
        cell.name=[proDic objectForKey:@"area_name"];
        if (_width!=ScreenWidth) {
             cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }else if (_centerTableView==tableView){
        NSDictionary * cityDic =_cityArr[indexPath.row];
        cell.name=[cityDic objectForKey:@"area_name"];
        if (_width!=ScreenWidth/2) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
       NSDictionary * xianDic =_xianArr[indexPath.row];
        cell.name= [xianDic objectForKey:@"area_name"];
    }
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*
     1.当点击最左边的tableView的时候,要把中间和最右边的tableView移除,同时移除对应的数据源
     2.当点击中间tableView的时候,要把最右边的数组 和tableView移除
     3.当_width==ScreenWidth说明只有一行tableView,依次类推
     
     */
    
    
    
    if (_leftTableView==tableView) {
        [_centerTableView removeFromSuperview];
        [_rightTableView removeFromSuperview];
        [self CreatCenterTableView];
        NSDictionary * proDic =_provincesArr[indexPath.row];
        NSArray * cityArr =[proDic objectForKey:@"areas"];
        [_cityArr removeAllObjects];
        [_xianArr removeAllObjects];
        [_cityArr addObjectsFromArray:cityArr];
        if (_width==ScreenWidth) {
            NSLog(@"name=%@>>>code=%@",[proDic objectForKey:@"area_name"],[proDic objectForKey:@"area_code"]);
            _nameText=[proDic objectForKey:@"area_name"];
            _codeText=[proDic objectForKey:@"area_code"];
        }
        
    }else if (_centerTableView==tableView){
        [_rightTableView removeFromSuperview];
        [self CreatRightTableView];
        NSDictionary * xianDic =_cityArr[indexPath.row];
        NSArray * cityArr =[xianDic objectForKey:@"areas"];
        [_xianArr removeAllObjects];
        [_xianArr addObjectsFromArray:cityArr];
        if (_width==ScreenWidth/2) {
            NSLog(@"name=%@>>>code=%@",[xianDic objectForKey:@"area_name"],[xianDic objectForKey:@"area_name"]);
            _nameText=[xianDic objectForKey:@"area_name"];
            _codeText=[xianDic objectForKey:@"area_code"];
        }
    }else{
        NSDictionary * xianDic =_xianArr[indexPath.row];
        NSLog(@"name>>>%@>>>code%@",[xianDic objectForKey:@"area_name"],[xianDic objectForKey:@"area_code"]);
        _nameText=[xianDic objectForKey:@"area_name"];
        _codeText=[xianDic objectForKey:@"area_code"];
    }
}

//取消
-(void)canBtnClink{
//    int g =ScreenHeight/2;
    self.frame=CGRectMake(0, ScreenHeight-_heightSelf, ScreenWidth, _heightSelf);
    [UIView animateWithDuration:animationTime animations:^{
        self.frame=CGRectMake(0, ScreenHeight, ScreenWidth, _heightSelf);
    } completion:^(BOOL finished) {
        [self dissmiss];
    }];
}
//确认
-(void)sureBtnClick{

    if ([_nameText isEqualToString:@""] || [_codeText isEqualToString:@""]) {
        [LCProgressHUD showMessage:@"请选择完整的地区"];
        return;
    }
    self.NameCodeBlock(_nameText, _codeText);
    [self canBtnClink];
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
