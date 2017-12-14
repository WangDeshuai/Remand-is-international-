//
//  BasicInforMationVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "BasicInforMationVC.h"
#import "BasicInforMationCell.h"
#import "BasiInfoView.h"
@interface BasicInforMationVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * _registName;///注册类型
    NSString * _userName;///userType
    NSString * allpeople;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * nameArray;
@end

@implementation BasicInforMationVC
- (void)viewWillAppear:(BOOL)animated{
    // 设置导航栏背景透明(取值范围0~1)
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Basic Information";
    UIImageView * bgImage =[[UIImageView alloc]init];
    bgImage.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight+5);
    bgImage.image=[UIImage imageNamed:@"information_bg"];
    [self.view sd_addSubviews:@[bgImage]];
    [self.rightButton setImage:[UIImage imageNamed:@"information_save"] forState:0];
    [self.rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
    
    [self CreatImageArr];
    [self CreatTableView];
}


#pragma mark ---创建控件


-(void)CreatImageArr{
    _nameArray=@[@"Name",@"My member",@"Phone number",@"Mailbox",@"Other contacts",@"Registration Typle",@"User type",@"Main",@"Area"];
}

-(UIView*)CreatTabelViewHeader{
    UIView * headerView =[UIView new];
    headerView.backgroundColor=[UIColor clearColor];
    headerView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(120);
    
    UIButton * btnImage =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnImage addTarget:self action:@selector(btnImageClick:) forControlEvents:UIControlEventTouchUpInside];
    btnImage.sd_cornerRadius=@(40);
    [btnImage sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:0 placeholderImage:[UIImage imageNamed:@"mine_head"]];
    [headerView sd_addSubviews:@[btnImage]];
    btnImage.sd_layout
    .centerXEqualToView(headerView)
    .widthIs(80)
    .heightIs(80)
    .centerYEqualToView(headerView);
    
    
    
    return headerView;
}


-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.rowHeight=65;
    tableView.tableFooterView=[UIView new];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor=[UIColor clearColor];
    tableView.tableHeaderView=[self CreatTabelViewHeader];
    tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nameArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasicInforMationCell * cell =[BasicInforMationCell cellWithTableView:tableView IndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.titleLabel.text=_nameArray[indexPath.row];
    cell.leftImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"information_%lu",indexPath.row]];
    if (indexPath.row==0) {
        //用户名
        cell.contentText.text=[NSUSE_DEFO objectForKey:API_UserName];
        cell.contentText.enabled=NO;
    }else if (indexPath.row==1){
        //会员类型
         cell.contentText.text=[NSUSE_DEFO objectForKey:API_Type];
         cell.contentText.enabled=NO;
    }else if (indexPath.row==2){
        //电话
    }else if (indexPath.row==3){
        //邮箱
        cell.contentText.text=[NSUSE_DEFO objectForKey:API_Email];
        cell.contentText.enabled=NO;
    }else if (indexPath.row==4){
        //备用联系
    }else if (indexPath.row==5){
        //注册类型
        cell.contentText.enabled=NO;
        cell.contentText.text=_registName;
    }else if (indexPath.row==6){
        //个人类型
        cell.contentText.enabled=NO;
        cell.contentText.text=_userName;
    }else if (indexPath.row==7){
        //主要营业
        cell.contentText.enabled=NO;
    }else if (indexPath.row==8){
        //地区
        cell.contentText.enabled=NO;
    }
    

    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==5) {
        [self tanKaungSeleateTitle:@"Registration" DataTitleArr:@[@"Personal",@"Company"] Int:5];
    }else if (indexPath.row==6){
        //个人类型
        [self tanKaungSeleateTitle:@"User typle" DataTitleArr:@[@"全部",@"供应商",@"采购商"] Int:6];
    }
}



#pragma mark --弹框调用
-(void)tanKaungSeleateTitle:(NSString*)name DataTitleArr:(NSArray*)dataArr Int:(int)tag{
    int g=ScreenHeight/3;
    BasiInfoView * view =[[BasiInfoView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, g) TitleName:name AndDataArr:dataArr];

        //注册
        view.NameBlock = ^(NSString *name) {
            if (tag==5) {//注册类型
                _registName=name;
            }else if (tag==6){ //个人类型
                _userName=name;
            }
            [_tableView reloadData];
        };
   
    
    
    
    
    [UIView animateWithDuration:.6 animations:^{
        view.frame=CGRectMake(0, ScreenHeight-g, ScreenWidth, g);
        [view show];;
    } completion:^(BOOL finished) {
    }];
    
}





#pragma mark --按钮点击事件---
//头像选择
-(void)btnImageClick:(UIButton*)btn{
    
}

//保存
-(void)rightClick{
    
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
