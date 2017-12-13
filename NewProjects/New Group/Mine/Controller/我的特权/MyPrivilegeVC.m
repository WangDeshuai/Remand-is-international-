//
//  MyPrivilegeVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "MyPrivilegeVC.h"
#import "MyPrivilegeCell.h"
@interface MyPrivilegeVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UIImageView * imageview;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * lastBtn;
@property(nonatomic,assign) CGRect  imageRect;
@end

@implementation MyPrivilegeVC
static const CGFloat headHeight =248;
static const CGFloat ratio =0.66;
- (void)viewWillAppear:(BOOL)animated{
    // 设置导航栏背景透明(取值范围0~1)
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"My privilege";
    [self CreatBgImageView];
    [self CreatTableView];
}
//创建背景拉伸图
-(void)CreatBgImageView{
    _imageview =[UIImageView new];
    _imageview.image=[UIImage imageNamed:@"privilege_bg"];
    _imageview.userInteractionEnabled=YES;
    _imageview.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth*ratio);
    _imageRect=_imageview.frame;
    [self.view addSubview:_imageview];
}
//创建表头
-(UIView*)CraetTableViewHeader{
    UIView * headerView =[UIView new];
    headerView.backgroundColor=[UIColor clearColor];
    headerView.frame=CGRectMake(0, 0, ScreenWidth, headHeight+10);
    headerView.userInteractionEnabled=YES;
    //头像
    UIButton * headBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.backgroundColor=[UIColor yellowColor];
//    [headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:0 placeholderImage:[UIImage imageNamed:@"mine_head"]];
    headBtn.sd_cornerRadius=@(40);
    [headerView sd_addSubviews:@[headBtn]];
    headBtn.sd_layout
    .centerXEqualToView(headerView)
    .topSpaceToView(headerView, 10+64)
    .widthIs(80)
    .heightIs(80);
    //名字
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"Alexandra";
    namelabel.textColor=[UIColor whiteColor];
    if (@available(iOS 8.2, *)) {
        namelabel.font=[UIFont systemFontOfSize:17 weight:.3];
    } else {
    }
    [headerView sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .topSpaceToView(headBtn, 10)
    .centerXEqualToView(headBtn)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];

    //副标题(名字下面label)
    UILabel * namelabel2=[UILabel new];
    namelabel2.text=@"Memvership level 3";
    namelabel2.textColor=[[UIColor whiteColor]colorWithAlphaComponent:.5];
    if (@available(iOS 8.2, *)) {
        namelabel2.font=[UIFont systemFontOfSize:15 weight:.3];
    } else {
    }
    [headerView sd_addSubviews:@[namelabel2]];
    namelabel2.sd_layout
    .topSpaceToView(namelabel, 5)
    .centerXEqualToView(headBtn)
    .heightIs(20);
    [namelabel2 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
//
    
    
    
    return headerView;
}
-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=[UIColor clearColor];
    tableView.rowHeight=80;
    tableView.sectionHeaderHeight=110;
    tableView.tableHeaderView=[self CraetTableViewHeader];
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPrivilegeCell * cell=[MyPrivilegeCell cellWithTableView:tableView IndexPath:indexPath];
    return cell;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgview =[UIView new];
    bgview.backgroundColor=[UIColor clearColor];
    UIView * view =[UIView new];
    view.sd_cornerRadius=@(5);
    view.backgroundColor=[UIColor whiteColor];
    [bgview sd_addSubviews:@[view]];
    view.sd_layout
    .leftSpaceToView(bgview, 10)
    .rightSpaceToView(bgview, 10)
    .topSpaceToView(bgview, 0)
    .bottomSpaceToView(bgview, 0);
    //铅笔按钮
    UIButton * nameBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [nameBtn setImage:[UIImage imageNamed:@"privilege_jilu"] forState:0];
    [nameBtn setTitle:@"Published Information" forState:0];
    nameBtn.adjustsImageWhenHighlighted=NO;
    [nameBtn setTitleColor:[UIColor blackColor] forState:0];
    nameBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    nameBtn.frame=CGRectMake(15, 10, ScreenWidth-20, 40);
    [nameBtn SG_imagePositionStyle:SGImagePositionStyleDefault spacing:8];
    [view addSubview:nameBtn];
    //btn背景
    UIView * btnView =[UIView new];
    btnView.backgroundColor=[UIColor whiteColor];
    btnView.sd_cornerRadius=@(45/2);
    btnView.layer.borderWidth=1;
    btnView.layer.borderColor=BG_COLOR.CGColor;
    [view sd_addSubviews:@[btnView]];
    btnView.sd_layout
    .leftSpaceToView(view, 15)
    .rightSpaceToView(view, 15)
    .topSpaceToView(nameBtn, 10)
    .heightIs(45);
    
    NSArray *twoArr =@[@"Supply",@"Purchase"];
    int k=(ScreenWidth-20-20)/2;
    for (int i=0; i<twoArr.count; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:twoArr[i] forState:0];
        btn.tag=i;
        btn.sd_cornerRadius=@(40/2);
        [btn setBackgroundImage:[UIImage imageNamed:@"privilege_btnbg"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"privilege_btnbg1"] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        if (i==0) {
            btn.selected=YES;
            _lastBtn=btn;
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        [btnView sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(btnView, k*i)
        .centerYEqualToView(btnView)
        .widthIs(k)
        .heightIs(40);
        
    }
    
    
    
    return bgview;
}

#pragma mark --按钮点击事件
-(void)btnClick:(UIButton*)btn{
    _lastBtn.selected=NO;
    btn.selected=YES;
    _lastBtn=btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -------ScrollViewDelegate--------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<headHeight) {//向上滑offsetY+
        CGFloat aipat =offsetY/headHeight;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:aipat];
    }else{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    }
    
    if (offsetY>0) {
        //往上移动
        _imageview.frame=({
            CGRect frame =_imageRect;
            frame.origin.y=_imageRect.origin.y-offsetY;
            frame;
        });
    }else
    {
        _imageview.frame=({
            CGRect frame=_imageRect;
            frame.size.height=_imageRect.size.height-offsetY;
            frame.size.width=frame.size.height/ratio;
            frame.origin.x=_imageRect.origin.x-(frame.size.width-_imageRect.size.width)/2;
            frame;
        });
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
