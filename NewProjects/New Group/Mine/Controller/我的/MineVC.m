//
//  MineVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/7.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "MineVC.h"
#import "MineCell.h"
#import "LoginVC.h"//登录页
#import "PublishMainVC.h"//发布信息
#import "ViewRecordMainVC.h" //查看记录
#import "MyPrivilegeVC.h"//我的特权
#import "MemberVIPVC.h"//会员VIP
#import "BasicInforMationVC.h"//基本信息
#import "UserInfoBaseClass.h"
#import "ChangePasswordVC.h"//修改密码
@interface MineVC ()
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong) UIImageView * imageview;
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,assign) CGRect  imageRect;
@property(nonatomic,strong)UserInfoBaseClass * model;
@end
@implementation MineVC
static const CGFloat headHeight =248;
static const CGFloat ratio =0.66;


- (void)viewWillAppear:(BOOL)animated{
// 设置导航栏背景透明(取值范围0~1)
   [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
//去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
   
     self.baseTableView.tableHeaderView=[self CraetTableViewHeader];
    
   
}
-(void)viewWillDisappear:(BOOL)animated
{
     [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Personal center";
    
    self.navigationController.automaticallyAdjustsScrollViewInsets=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.backHomeBtn.hidden=YES;
    [self CreatBgImageView];
    [self CreatData];
    [self CreatTabelView];
}
#pragma mark ------创建控件-----------
//数据源
-(void)CreatData{
   NSArray * arr1=@[@"Published Infomation",@"View Records",@"My Privilege",@"Member Purchase",@"Purchase History"];
    NSArray * arr2=@[@"Basic Information",@"Change Password",@"Launch The Current Account"];
    NSArray * image1 =@[@"mine_0",@"mine_1",@"mine_2",@"mine_3",@"mine_4"];
    NSArray * image2=@[@"mine_5",@"mine_6",@"mine_7"];
    _dataArray=@[arr1,arr2];
    _imageArray=@[image1,image2];
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
     [self getVIPmessage];
    UIView * headerView =[UIView new];
    headerView.backgroundColor=[UIColor clearColor];//换颜色就能看出来
    headerView.frame=CGRectMake(0, 0, ScreenWidth, headHeight-54);
    headerView.userInteractionEnabled=YES;
    //头像
    UIButton * headBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.backgroundColor=[UIColor yellowColor];
    [headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headBtn setBackgroundImage:[UIImage imageNamed:@"placeholder_head"] forState:0];
    headBtn.sd_cornerRadius=@(40);
    [headerView sd_addSubviews:@[headBtn]];
    headBtn.sd_layout
    .centerXEqualToView(headerView)
    .topSpaceToView(headerView, 10)
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
    
    
    if ([ToolClass isLogin]) {
        namelabel.text=[NSUSE_DEFO objectForKey:API_UserName];
        namelabel2.hidden=NO;
    }else{
        namelabel.text=@"Login";
        namelabel2.hidden=YES;
    }
    
    
    
    [[Engine sharedEngine]BJPostWithUrl:Main_URL withAPIName:VIPApi_Message withParame:nil callback:^(id item) {
        [LCProgressHUD hide];
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        if ([code isEqualToString:@"1"]) {
            UserInfoBaseClass * model =[UserInfoBaseClass modelObjectWithDictionary:item];
            _model=model;
           [headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.headImg] forState:0 placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
            namelabel2.text=_model.vipType;;
        }else{
            
        }
        
    } failedBlock:^(id error) {
        
    }];
    
    return headerView;
}

//创建tableView
-(void)CreatTabelView{
  
    self.baseTableView.frame=CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-53);
    self.baseTableView.tableFooterView=[UIView new];
    self.baseTableView.backgroundColor=[UIColor clearColor];
    self.baseTableView.rowHeight=50;
    self.baseTableView.mj_header=nil;
    self.baseTableView.mj_footer=nil;
   
    [self.view addSubview:self.baseTableView];
}
#pragma mark -----表代理(tableViewDataSource--tableViewDelegate)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCell * cell =[MineCell cellWithTableView:tableView IndexPath:indexPath];
    cell.namelabel.text=_dataArray[indexPath.section][indexPath.row];
    [cell.leftImage setImage:[UIImage imageNamed:_imageArray[indexPath.section][indexPath.row]] forState:0];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[UIView new];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }  else{
        return 15;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if ([ToolClass isLogin]==NO) {
        LoginVC * vc =[LoginVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //发布信息(publish)
            PublishMainVC * vc =[PublishMainVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //查看记录
            ViewRecordMainVC * vc =[ViewRecordMainVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2){
            //我的特权
            MyPrivilegeVC * vc =[MyPrivilegeVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==3){
            //VIP
            MemberVIPVC * vc =[MemberVIPVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==4){
            
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            //基本信息
            BasicInforMationVC * vc=[BasicInforMationVC new];
            vc.model=_model;
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //改密码
            ChangePasswordVC * vc =[ChangePasswordVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2){
            //退出
            UIAlertController * alertView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否退出" preferredStyle:1];
            UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
            UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
                [NSUSE_DEFO removeObjectForKey:API_Type];
                [NSUSE_DEFO removeObjectForKey:API_Email];
                [NSUSE_DEFO removeObjectForKey:API_Token];
                [NSUSE_DEFO removeObjectForKey:API_UserName];
                [NSUSE_DEFO synchronize];
                 self.baseTableView.tableHeaderView=[self CraetTableViewHeader];
            }];
            [alertView addAction:action1];
            [alertView addAction:action2];
            [self presentViewController:alertView animated:YES completion:nil];
        }
    }
    
   
    
   

}




#pragma  mark ----按钮点击事件----------
-(void)headBtnClick{
   
    if ([ToolClass isLogin]==NO) {
        LoginVC * vc =[LoginVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        BasicInforMationVC * vc=[BasicInforMationVC new];
        vc.hidesBottomBarWhenPushed=YES;
        vc.model=_model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}





#pragma mark ----网络请求
//获取会员信息
-(void)getVIPmessage{
    
   
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







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
