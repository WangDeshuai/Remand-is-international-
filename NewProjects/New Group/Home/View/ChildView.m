//
//  ChildView.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ChildView.h"
#import "ToolClass.h"
@interface ChildView ()
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,assign)CGFloat WIDTH_X;//记录宽度
@property(nonatomic,assign)CGFloat HEIGHT_Y;//记录高度
@property(nonatomic,strong)NSArray * dataArray;//数据源
@property(nonatomic,strong)UIButton * titleBtn;
@property(nonatomic,strong)UIView * lineView;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,strong)NSMutableArray * nameArray;
@end
@implementation ChildView

-(id)initWithFrame:(CGRect)frame TitleName:(NSString*)titlename AndDataArr:(NSArray*)dataArr{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5;
        self.clipsToBounds=YES;
        self.layer.borderColor=Main_Color.CGColor;
        self.layer.borderWidth=1;
        _nameArray=[NSMutableArray array];
        _title=titlename;
        _dataArray=dataArr;
        _WIDTH_X=frame.size.width;
        _HEIGHT_Y=frame.size.height;
        [self titleBtn];
        [self lineView];
        [self CreatTabelView];
        [self sureBtn];
    }
    
    return self;
}


-(void)sureBtn{
    NSArray * btnArr =@[@"Cancel",@"OK"];
    int d =10;
    int k =(_WIDTH_X-d*2);
    int g=25;
    for (int i =0; i<btnArr.count; i++) {
        UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.layer.cornerRadius=g/2;
        sureBtn.clipsToBounds=YES;
        [sureBtn setTitle:btnArr[i] forState:0];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        sureBtn.frame=CGRectMake(d, _HEIGHT_Y-15-(d+g)*i-g, k, g);
        [self addSubview:sureBtn];

        sureBtn.tag=i?0:1;
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==1) {
            sureBtn.backgroundColor=Main_Color;
        }else{
            sureBtn.backgroundColor=[UIColor whiteColor];
            sureBtn.layer.borderColor=[[UIColor lightGrayColor]colorWithAlphaComponent:.4].CGColor;
            sureBtn.layer.borderWidth=.5;
            [sureBtn setTitleColor:[[UIColor lightGrayColor]colorWithAlphaComponent:.7] forState:0];
        }
        
    }
}




#pragma mark --创建表头
-(UIButton*)titleBtn
{
    if (!_titleBtn) {
        _titleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_titleBtn setTitle:_title forState:0];
        _titleBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_titleBtn setTitleColor:Main_Color forState:0];
        [_titleBtn setImage:[UIImage imageNamed:@"arrows"] forState:0];
        [self sd_addSubviews:@[_titleBtn]];
        _titleBtn.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .heightIs(35);
        
        _titleBtn.imageView.sd_layout
        .rightSpaceToView(_titleBtn, 10)
        .centerYEqualToView(_titleBtn)
        .widthIs(16)
        .heightIs(16);
        
        _titleBtn.titleLabel.sd_layout
        .leftSpaceToView(_titleBtn, 10)
        .rightSpaceToView(_titleBtn.imageView, 5)
        .centerYEqualToView(_titleBtn)
        .heightIs(20);
    }
    return _titleBtn;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView=[UIView new];
        _lineView.backgroundColor=[[UIColor lightGrayColor]colorWithAlphaComponent:.6];
        [self sd_addSubviews:@[_lineView]];
        _lineView.sd_layout
        .leftSpaceToView(self, 10)
        .rightSpaceToView(self, 10)
        .topSpaceToView(self, 35)
        .heightIs(1);
    }
    return _lineView;
}


#pragma mark ---创建表头内容
-(UIView*)CreatTableViewHeader{
    UIView * headerView =[UIView new];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.sd_cornerRadius=@(5);
    headerView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .heightIs(360);
  //按钮内容排序
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 20;//用来控制button距离父视图的高
    UIButton * btn=nil;
    for (int i =0; i<_dataArray.count; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        [button setTitleColor:[[UIColor blackColor]colorWithAlphaComponent:.5] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searBtnClink:)
         forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        CGFloat length=[ToolClass WidthForString:_dataArray[i] withSizeOfFont:15];
        [button setTitle:_dataArray[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(10 + w, h, length , 30);
        //当button的位置超出屏幕边缘时换行
        if(10 + w + length  >  (ScreenWidth-15*3)/2){
            //换行时将w置为0
            w = 0;
            //距离父视图也变化
            h = h + button.frame.size.height + 10;
            //重设button的frame
            button.frame = CGRectMake(10 + w, h, length , 30);
        }
        w = button.frame.size.width + button.frame.origin.x;
        btn=button;
        [headerView addSubview:button];
    }

//确认
   
    
   
    [headerView setupAutoHeightWithBottomView:btn bottomMargin:50];
    __weak __typeof(headerView)weakSelf = headerView;
    headerView.didFinishAutoLayoutBlock=^(CGRect rect){
        weakSelf.sd_layout
        .heightIs(rect.size.height);
        [self.tableView setTableHeaderView:weakSelf];
    };
    
    return headerView;
}









-(void)CreatTabelView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 36, _WIDTH_X ,_HEIGHT_Y-120) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.tableFooterView=[UIView new];
    tableView.tableHeaderView=[self CreatTableViewHeader];
    [self addSubview:tableView];
}




-(void)sureBtnClick:(UIButton*)btn{
    if (btn.tag==0) {
        if (_nameArray.count==0) {
            [LCProgressHUD showMessage:@"您还没有选择"];
        }else{
             self.NameBlock(_nameArray);
             [self dissmiss];
        }
    }else{
        //取消
        [self dissmiss];
    }
}


//点击选中
-(void)searBtnClink:(UIButton*)btn{
    btn.selected=!btn.selected;
    NSString * str =_dataArray[btn.tag-100];
    if (btn.selected==YES) {
        [btn setTitleColor:[UIColor whiteColor] forState:0];
         btn.backgroundColor=Main_Color;
        [_nameArray addObject:str];
    }else{
        [btn setTitleColor:[[UIColor blackColor]colorWithAlphaComponent:.5] forState:0];
        btn.backgroundColor=[UIColor whiteColor];
        [_nameArray removeObject:str];
    }
    
   
}
- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];//
    view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [view addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.1;
    view.tag=1000;
    [window addSubview:view];
    [window addSubview:self];
}
-(void)dissmiss{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView * view =[window viewWithTag:1000];
    
    [view removeFromSuperview];
    [self removeFromSuperview];
    
}
@end
