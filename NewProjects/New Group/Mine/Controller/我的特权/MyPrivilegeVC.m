//
//  MyPrivilegeVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "MyPrivilegeVC.h"
#import "MyPrivilegeCell.h"
#import "MyPrivilegeList.h"
@interface MyPrivilegeVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UIImageView * imageview;
@property(nonatomic,strong)UIButton * lastBtn;
@property(nonatomic,assign) CGRect  imageRect;
@property(nonatomic,strong)UILabel  *timesLabel;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger tag;
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
    _dataArray=[NSMutableArray new];
    _tag=1;
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
    UILabel * timelabel =[UILabel new];
    timelabel.backgroundColor=[UIColor whiteColor];
    timelabel.text=0;
    timelabel.textAlignment=1;
    if (@available(iOS 8.2, *)) {
        timelabel.font=[UIFont systemFontOfSize:18 weight:.3];
    } else {
        // Fallback on earlier versions
    }
    timelabel.textColor=Main_Color;
    _timesLabel=timelabel;
    timelabel.sd_cornerRadius=@(40);
    [headerView sd_addSubviews:@[timelabel]];
    timelabel.sd_layout
    .centerXEqualToView(headerView)
    .topSpaceToView(headerView, 20+Distance_Top)
    .widthIs(80)
    .heightIs(80);
    //名字
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"Remaining times";
    namelabel.textColor=[UIColor whiteColor];
    if (@available(iOS 8.2, *)) {
        namelabel.font=[UIFont systemFontOfSize:17 weight:.3];
    } else {
    }
    [headerView sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .topSpaceToView(timelabel, 10)
    .centerXEqualToView(timelabel)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];

    //副标题(名字下面label)
    UIButton * namelabel2=[UIButton buttonWithType:UIButtonTypeCustom];
    namelabel2.titleLabel.font=[UIFont systemFontOfSize:15];
    [namelabel2 setTitle:@"Buy privileges" forState:0];
    namelabel2.layer.borderWidth=.5;
    namelabel2.layer.borderColor=[UIColor whiteColor].CGColor;
    namelabel2.sd_cornerRadius=@(25/2);
    [headerView sd_addSubviews:@[namelabel2]];
    namelabel2.sd_layout
    .topSpaceToView(namelabel, 5)
    .centerXEqualToView(timelabel)
    .heightIs(25)
    .widthIs(120);

    
    
    
    return headerView;
}
-(void)CreatTableView{
    
    self.baseTableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.baseTableView.tableFooterView=[UIView new];
    self.baseTableView.backgroundColor=[UIColor clearColor];
    self.baseTableView.rowHeight=80;
    self.baseTableView.sectionHeaderHeight=110;
    self.baseTableView.tableHeaderView=[self CraetTableViewHeader];
    [self.view addSubview:self.baseTableView];
    [self.baseTableView.mj_header beginRefreshing];
}


-(void)mjHeaderRefresh
{
    self.current=1;
    [self getMyPrivilegePage:self.current];
}
-(void)mjFooterRefresh
{
    [self getMyPrivilegePage:++self.current];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPrivilegeCell * cell=[MyPrivilegeCell cellWithTableView:tableView IndexPath:indexPath];
    cell.model=_dataArray[indexPath.row];
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


#pragma mark ---网络请求类
-(void)getMyPrivilegePage:(NSInteger)page{
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:PrivilegeApi_MyPrivilege withParame:@{@"page":[NSString stringWithFormat:@"%lu",page]} callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        if ([code isEqualToString:@"1"]) {
            _timesLabel.text=[item objectForKey:@"tq"];
            NSArray * listArr =[item objectForKey:@"list"];
            if (self.current==1) {
                self.dataArray=[NSMutableArray array];
            }
            for (NSDictionary * dic in listArr) {
                [self.dataArray addObject:[MyPrivilegeList modelObjectWithDictionary:dic]];
            }
            [self.baseTableView reloadData];
        }else{
            self.current--;
        }
        [self.baseTableView.mj_header endRefreshing];
        [self.baseTableView.mj_footer endRefreshing];
    } failedBlock:^(id error) {
         [self.baseTableView.mj_header endRefreshing];
         [self.baseTableView.mj_footer endRefreshing];
    }];
}







#pragma mark --------按钮点击事件--------
-(void)btnClick:(UIButton*)btn{
    _lastBtn.selected=NO;
    btn.selected=YES;
    _lastBtn=btn;
    _tag=btn.tag+1;
    if (_tag==1) {
        //左边
          NSLog(@">>>%lu",self.current);
    }else{
        //右边
    }
  
    
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
