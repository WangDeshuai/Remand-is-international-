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
#import "ZJSelectPhotoTool.h"
@interface BasicInforMationVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSString * _companyName;//公司名字
    NSString * _phoneNum;//电话号码
    NSString * _otherPhone;//备用联系方式
    
    NSString * _registName;///注册类型
    NSString * _registCode;//注册code
   
    NSString * _userName;///个人类型(全部,供应商,采购商)
    NSString * _userCode;//个人类型code
    
    NSString * _className;//商品分类name
    NSString * _classCode;//商品分类code
    
    NSString * _addressName;//地区名字
    NSString * _addressCode;//地区code
  
    NSMutableArray * _classNameArr;//其它分类的name
    NSMutableArray * _classCodeArr;//其它分类code (最后,记得添加第一个code)
   
    NSString * _imageStr;//头像地址
    
}
@property(nonatomic,strong)NSMutableArray * nameArray;
@property(nonatomic,strong)NSMutableArray  *imageArr;
@property(nonatomic,copy)NSString * countryStr;//国家str
@property(nonatomic,copy)NSString * countryCode;//国家code
@property(nonatomic,strong)UIImage * headImage;//头像
@end
@implementation BasicInforMationVC
static int MaxMainNum =10;
- (void)viewWillAppear:(BOOL)animated{
    //设置导航栏背景透明(取值范围0~1)
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
    _nameArray=[NSMutableArray array];//label数组创建
    _imageArr=[NSMutableArray array];//最左边图标数组创建
    _classNameArr=[NSMutableArray array];//存放其它分类的name
    _classCodeArr=[NSMutableArray array];//存放其它分类的code
 //标题
    NSArray * arr=@[@"Name",@"My member",@"Company name",@"Phone number",@"Mailbox",@"Other contacts",@"Registration Typle",@"User type",@"Main",@"Country",@"Area"];
    [_nameArray addObjectsFromArray:arr];
//图片
    NSArray * imageAr=@[@"information_0",@"information_1",@"information_2",@"information_3",@"information_4",@"information_5",@"information_6",@"information_7",@"information_8",@"information_9",@"information_10"];
    [_imageArr addObjectsFromArray:imageAr];
    
    
    /*
     要在分类的数组中添加9个占位符,
     因为要在tableView中展示选择的每及分类的名字,
     是通过indexPath.row来取出的,所以需要添加9个
     占位符
     */
    NSArray * class =@[@"",@"",@"",@"",@"",@"",@"",@"",@""];
    [_classNameArr addObjectsFromArray:class];
    
    if (_model.categorys.count>=1) {
        _className=_model.categorys[0];//更换成名字(用来显示)
        _classCode=_model.categorys[0];
        for (int i=0; i<_model.categorys.count-1; i++) {
            NSString * str =_model.categorys[i+1];
            [_nameArray insertObject:[NSString stringWithFormat:@"主营%d",i+1] atIndex:_nameArray.count-2];
            [_classCodeArr addObject:str];
            [_classNameArr insertObject:str atIndex:_classNameArr.count];//更换成名字(用来显示)
            [_imageArr insertObject:@"information_8" atIndex:_nameArray.count-2];
        }
    }
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
    [btnImage sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.headImg] forState:0 placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
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
    cell.addBtn.tag=indexPath.row;
    cell.contentText.delegate=self;
    cell.contentText.tag=indexPath.row;
    [cell.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.leftImage.image=[UIImage imageNamed:_imageArr[indexPath.row]];
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
        cell.contentText.text=[self stingText:_companyName UserInfoBaseClassModel:_model.companyName];
    } else if (indexPath.row==3){
        //电话
        cell.contentText.text=[self stingText:_phoneNum UserInfoBaseClassModel:_model.companyPhone];
    }else if (indexPath.row==4){
        //邮箱
        cell.contentText.text=[NSUSE_DEFO objectForKey:API_Email];
        cell.contentText.enabled=NO;
    }else if (indexPath.row==5){
        //备用联系
        cell.contentText.text=[self stingText:_otherPhone UserInfoBaseClassModel:_model.mobile];
    }else if (indexPath.row==6){
        //注册类型
        cell.contentText.enabled=NO;
         cell.contentText.text=[self stingText:_registName UserInfoBaseClassModel:_model.regType];
        
        
    }else if (indexPath.row==7){
        //个人类型
        cell.contentText.enabled=NO;
//        cell.contentText.text=_userName;
          cell.contentText.text=[self stingText:_userName UserInfoBaseClassModel:_model.memberType];
    }else if (indexPath.row==8){
        //主要营业
        cell.contentText.enabled=NO;
        cell.contentText.text=_className;
        cell.addBtn.hidden=NO;
        [cell.addBtn setImage:[UIImage imageNamed:@"information_add"] forState:0];
    }else if (indexPath.row==_nameArray.count-2){
        //国家
        cell.contentText.enabled=NO;
        cell.contentText.text=_countryStr;
        cell.addBtn.hidden=YES;
    }else if (indexPath.row==_nameArray.count-1){
        //地区
         cell.contentText.enabled=NO;
        cell.contentText.text=_addressName;
        cell.addBtn.hidden=YES;
    }else {
        cell.addBtn.hidden=NO;
        cell.contentText.enabled=NO;
        [cell.addBtn setImage:[UIImage imageNamed:@"information_jian"] forState:0];
        if (_classNameArr.count>indexPath.row) {
             cell.contentText.text=_classNameArr[indexPath.row];
        }
      
        
    }
    

    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0 || indexPath.row==1 || indexPath.row==2 ||indexPath.row==3 || indexPath.row==4 || indexPath.row==5 ) {
    }else  if (indexPath.row==6) {
        [self tanKaungSeleateTitle:@"Registration" DataTitleArr:@[@"Personal",@"Company"] Int:5];
    }else if (indexPath.row==7){
        //个人类型
        [self tanKaungSeleateTitle:@"User typle" DataTitleArr:@[@"全部",@"供应商",@"采购商"] Int:6];
    }else if (indexPath.row==8){
        //主营分类
        [self getClassFenLeiMessageDataInt:8];
    }else if (indexPath.row==_nameArray.count-2){
        //国家
         [self getNationalData];
    }else if (indexPath.row==_nameArray.count-1){
        //地区
         [self getNationalAreaDataCode:_countryCode];
    }else{
        //主营分类(其它)
        [self getClassFenLeiMessageDataInt:indexPath.row];
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
-(void)getClassFenLeiMessageDataInt:(NSInteger)tag{
    NSLog(@">>>>%lu",tag);
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] getwithUrl:@"http://111.198.24.20:8603/getCategoryEn" andParameter:nil withSuccessBlock:^(id item) {
        NSMutableArray * provinceArr=[item objectForKey:@"children"];
        [self tanKuangSeleateDataArray:provinceArr Int:tag];
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
    } andprogressBlock:^(NSProgress *progress) {

    }];
}


///获取图片路径
-(void)getImageUrlData{
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] requestUpdatePoto:_headImage photoStr:@"image" urlStr:ImageApi_Name parameters:nil successBlock:^(NSString *urlStr) {
        _imageStr=urlStr;
        [LCProgressHUD hide];
    } failedBlock:nil];
}
///修改会员信息
-(void)getVipMessageDic:(NSDictionary*)dic{
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:VIPApi_Modification withParame:dic callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD showMessage:Message_Success];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showFailure:[dic objectForKey:@"resultMessage"]];
        }
        
    } failedBlock:^(id error) {
        
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
-(void)tanKuangSeleateDataArray:(NSMutableArray*)dataArr Int:(NSInteger)tag{
    int g=ScreenHeight/3;
     BasiMainClassView* view =[[BasiMainClassView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, g) TitleName:@"选择分类" AndDataArr:dataArr];
    view.NameCodeBlock = ^(NSString *name, NSString *code) {
        if (tag==8) {
            _className=name;
            _classCode=code;
        }else{
            [_classNameArr addObject:name];
            [_classCodeArr addObject:code];
        }
        
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
    [ZJSelectPhotoTool showSeletPhotoWith:self NamesArray:@[@"Select from album", @"Take pictures"] IsEditing:NO BackImageBlock:^(UIImage *image) {
        _headImage=image;
        [self getImageUrlData];
        [btn setBackgroundImage:image forState:0];
        
    } IsIcon:NO];
}

///保存
-(void)rightClick{
//    NSLog(@"公司名字>>>>%@",_companyName);
//    NSLog(@"公司电话>>>>>%@",_phoneNum);
//    NSLog(@"备用联系>>>>>%@",_otherPhone);
//    NSLog(@"注册类型>>>%@>>>%@",_registName,_registCode);
//    NSLog(@"用户类型>>>%@>>>%@",_userName,_userCode);
//    NSLog(@"主营类型>>>%@>>>%@>>>%@",_className,_classCode,_classCodeArr);
//    NSLog(@"地区name>>%@>>>>地区code%@",_addressName,_addressCode);
    
    /*
     1.[self stingText:xxx  UserInfoBaseClassModel:xxx];
     判断定义的变量是否有值,如果有就取变量值,如果没有就取model值
     2.[ToolClass  registTyple:xxx];
     是把model中对应的汉字转换为code编码给后台上传
     */
    
    //把第一个主营业务添加到 数组中
    [_classCodeArr insertObject:_classCode atIndex:0];
    
    
    NSString * str1 =[self stingText:_companyName UserInfoBaseClassModel:_model.companyName];
    NSString * str2 =[self stingText:_phoneNum UserInfoBaseClassModel:_model.companyPhone];
    NSString * str3 =[self stingText:_otherPhone UserInfoBaseClassModel:_model.mobile];
    NSString * str4 =[self stingText:_registName UserInfoBaseClassModel:[ToolClass registTyple:_model.regType]];
    NSString * str5 =[self stingText:_userName UserInfoBaseClassModel:[ToolClass registTyple:_model.memberType]];
    NSArray * arr6 = _classCodeArr.count?_classCodeArr:_model.categorys;
    NSString * str7 =[self stingText:_imageStr UserInfoBaseClassModel:_model.headImg];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:str1 forKey:@"company_name"];
    [dic setObject:str2 forKey:@"company_phone"];
    [dic setObject:str3 forKey:@"mobile"];
    [dic setObject:str4 forKey:@"reg_type"];
    [dic setObject:str7 forKey:@"head_img"];
    [dic setObject:[ToolClass isString:_addressCode] forKey:@"area_code"];
    [dic setObject:str5 forKey:@"member_type"];
    [dic setObject:arr6 forKey:@"categorys"];
    [self getVipMessageDic:dic];
    
}
///添加main
-(void)addBtnClick:(UIButton*)btn{
   
    if (btn.tag==8) {
        if (_nameArray.count-10>=MaxMainNum) {
            [LCProgressHUD showMessage:@"已经添加到最大个数"];
            return;
        }
        /*
         增加数据:
         _nameArray.count-10 :_nameArray原始个数是11,去掉10个,主营从1开始,以此类推,主营1,主营2...
         _nameArray.count-2 : 因为最后2个是 国家和地区,所以从-2的位置插入数据
         */
        [_nameArray insertObject:[NSString stringWithFormat:@"主营%lu",_nameArray.count-10] atIndex:_nameArray.count-2];
        [_imageArr insertObject:@"information_8" atIndex:_imageArr.count-2];
    }else{
        //减掉
        [_nameArray removeObjectAtIndex:btn.tag];
        [_imageArr removeObjectAtIndex:btn.tag];
        if (_classNameArr.count>btn.tag) {
             [_classNameArr removeObjectAtIndex:btn.tag];
             [_classCodeArr removeObjectAtIndex:btn.tag-9];
        }
      
    }
   /*
    "667700020002",
    "667700020002",
    "6677000100010001",
    "6677000100020002",-
    "6677000300040003",
    "667700020003"  -
    
    */
    [self.baseTableView reloadData];
}
#pragma mark --------TextFieldDelegate--------------
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==2) {
        //公司name
        _companyName=[ToolClass isString:textField.text];
    }else if (textField.tag==3){
        //电话号码
        _phoneNum=[ToolClass isString:textField.text];
    }else if (textField.tag==5){
        //备用联系方式
        _otherPhone=[ToolClass isString:textField.text];
    }
}

-(NSString*)stingText:(NSString*)str UserInfoBaseClassModel:(NSString*)modelStr{
    
    if ([[ToolClass isString:str] isEqualToString:@""]) {
        return modelStr;
    }else{
        return str;
    }
}




@end
