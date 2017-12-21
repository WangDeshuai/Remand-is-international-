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
#import "BasiAreaView.h"
#import "AddressView.h"
#import "BasiMainClassView.h"
@interface BasicInforMationVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * _registName;///注册类型
    NSString * _registCode;//注册code
   
    NSString * _userName;///个人类型(全部,供应商,采购商)
    NSString * _userCode;//个人类型code
   
    NSString * _addressName;//地区名字
    NSString * _addressCode;//地区code
   
    NSString * _className;//商品分类name
    NSString * _classCode;//商品分类code
    
    
    NSString * allpeople;
}
@property(nonatomic,strong)NSArray * nameArray;
@property(nonatomic,copy)NSString * countryStr;//国家str
@property (nonatomic,copy)NSString * countryCode;//国家code
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
    _nameArray=@[@"Name",@"My member",@"Corporate name",@"Phone number",@"Mailbox",@"Other contacts",@"Registration Typle",@"User type",@"Main",@"Country",@"Area"];
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

    self.baseTableView.frame=CGRectMake(0, Distance_Top, ScreenWidth, ScreenHeight-64);
    self.baseTableView.rowHeight=65;
    self.baseTableView.tableFooterView=[UIView new];
    self.baseTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.baseTableView.backgroundColor=[UIColor clearColor];
    self.baseTableView.tableHeaderView=[self CreatTabelViewHeader];
    self.baseTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    self.baseTableView.mj_header=nil;
    self.baseTableView.mj_footer=nil;
    [self.view addSubview:self.baseTableView];
    
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
    }else if(indexPath.row==2){
        //公司名称
    } else if (indexPath.row==3){
        //电话
    }else if (indexPath.row==4){
        //邮箱
        cell.contentText.text=[NSUSE_DEFO objectForKey:API_Email];
        cell.contentText.enabled=NO;
    }else if (indexPath.row==5){
        //备用联系
    }else if (indexPath.row==6){
        //注册类型
        cell.contentText.enabled=NO;
        cell.contentText.text=_registName;
    }else if (indexPath.row==7){
        //个人类型
        cell.contentText.enabled=NO;
        cell.contentText.text=_userName;
    }else if (indexPath.row==8){
        //主要营业
        cell.contentText.enabled=NO;
        cell.contentText.text=_className;
    }else if (indexPath.row==9){
        //国家
        cell.contentText.enabled=NO;
        cell.contentText.text=_countryStr;
    }else if (indexPath.row==10){
        //地区
         cell.contentText.enabled=NO;
        cell.contentText.text=_addressName;
    }
    

    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==6) {
        [self tanKaungSeleateTitle:@"Registration" DataTitleArr:@[@"Personal",@"Company"] Int:5];
    }else if (indexPath.row==7){
        //个人类型
        [self tanKaungSeleateTitle:@"User typle" DataTitleArr:@[@"全部",@"供应商",@"采购商"] Int:6];
    }else if (indexPath.row==8){
        //主营分类
        [self getClassFenLeiMessageData];
    }else if (indexPath.row==9){
        //国家
         [self getNationalData];
    }else if (indexPath.row==10){
        //地区
         [self getNationalAreaDataCode:_countryCode];
    }
}



#pragma mark --------获取网络请求数据
///只获取国家数据
-(void)getNationalData{
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] getwithUrl:@"http://111.198.24.20:8603/areaEn" andParameter:nil withSuccessBlock:^(id item) {
        NSArray * array =item;
        [self tanKaungSeleateCountryTitle:@"请选择国家" DataTitleArr:array Int:1];
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
    } andprogressBlock:^(NSProgress *progress) {
    }];
}

///根据国家code获取省市县地区数据
-(void)getNationalAreaDataCode:(NSString*)code{
    if ([[ToolClass isString:code] isEqualToString:@""]) {
        [LCProgressHUD showMessage:@"请先选择国家"];
        return;
    }
    [LCProgressHUD showLoading:Message_Loading];
    NSString *  urlStr =[NSString stringWithFormat:@"http://111.198.24.20:8603/areaEn/all/%@",[ToolClass isString:code]];
    [[Engine sharedEngine] getwithUrl:urlStr andParameter:nil withSuccessBlock:^(id item) {
        //省的数组
        NSMutableArray * provinceArr=[item objectForKey:@"areas"];
        [self tanKaungAreaViewDataArray:provinceArr];
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
    } andprogressBlock:^(NSProgress *progress) {
    }];
}


///获取分类信息数据
-(void)getClassFenLeiMessageData{
    
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] getwithUrl:@"http://111.198.24.20:8603/getCategoryEn" andParameter:nil withSuccessBlock:^(id item) {
        NSMutableArray * provinceArr=[item objectForKey:@"children"];
        [self tanKuangSeleateDataArray:provinceArr];
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
    } andprogressBlock:^(NSProgress *progress) {
        
    }];
}


#pragma mark ---------弹框调用
/// 注册类型 或者 个人类型
-(void)tanKaungSeleateTitle:(NSString*)name DataTitleArr:(NSArray*)dataArr Int:(int)tag{
    int g=ScreenHeight/3;
    BasiInfoView * view =[[BasiInfoView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, g) TitleName:name AndDataArr:dataArr];
        view.NameBlock = ^(NSString *name,NSString*code) {
            if (tag==5) {//注册类型
                _registName=name;
                _registCode=code;
            }else if (tag==6){ //个人类型
                _userName=name;
                _userCode=code;
            }
            [self.baseTableView reloadData];
        };
    [UIView animateWithDuration:.6 animations:^{
        view.frame=CGRectMake(0, ScreenHeight-g, ScreenWidth, g);
        [view show];;
    } completion:^(BOOL finished) {
    }];
    
}

///获取国家弹框调用(tag==1代表国家  tag==2代表失效时间)
-(void)tanKaungSeleateCountryTitle:(NSString*)name DataTitleArr:(NSArray*)dataArr Int:(int)tag{
    int g=ScreenHeight/3;
    AddressView * view =[[AddressView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, g) TitleName:name AndDataArr:dataArr IntType:tag];
    view.ControlBlock = ^(NSString *name, NSString *code) {
        if (tag==1) {
            _countryStr=name;
            _countryCode=code;
        }
        [self.baseTableView reloadData];
    };
    [UIView animateWithDuration:animationTime animations:^{
        view.frame=CGRectMake(0, ScreenHeight-g, ScreenWidth, g);
        [view show];;
    } completion:^(BOOL finished) {
    }];
    
}


///获取省市县(地区)弹框调用
-(void)tanKaungAreaViewDataArray:(NSMutableArray*)dataArr
{
    int g=ScreenHeight/3;
    BasiAreaView * view =[[BasiAreaView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, g) TitleName:@"选择省市县" AndDataArr:dataArr];
    view.NameCodeBlock = ^(NSString *name, NSString *code) {
        _addressName=name;
        _addressCode=code;
        [self.baseTableView reloadData];
    };
    [UIView animateWithDuration:animationTime animations:^{
        view.frame=CGRectMake(0, ScreenHeight-g, ScreenWidth, g);
        [view show];;
    } completion:^(BOOL finished) {
    }];
}

///获取分类弹框调用
-(void)tanKuangSeleateDataArray:(NSMutableArray*)dataArr{
    int g=ScreenHeight/3;
     BasiMainClassView* view =[[BasiMainClassView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, g) TitleName:@"选择分类" AndDataArr:dataArr];
    view.NameCodeBlock = ^(NSString *name, NSString *code) {
        _className=name;
        _classCode=code;
        [self.baseTableView reloadData];
    };
    [UIView animateWithDuration:animationTime animations:^{
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
