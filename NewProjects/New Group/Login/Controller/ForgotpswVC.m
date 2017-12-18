//
//  ForgotpswVC.m
//  NewProjects
//
//  Created by Mac on 2017/12/17.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ForgotpswVC.h"
#import "ForgotCell.h"
@interface ForgotpswVC ()<UITextFieldDelegate>
{
    NSString * _usernameText;
    NSString * _emailText;
    NSString * _codeText;
    NSString * _passwordText;
    NSString * _passwordText2;
}
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)NSArray * textArr;
@end

@implementation ForgotpswVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Forget password";
//    self.automaticallyAdjustsScrollViewInsets=NO;
    UIImageView * bgImage =[UIImageView new];
    bgImage.image=[UIImage imageNamed:@"regist_bg"];
    bgImage.userInteractionEnabled=YES;
    bgImage.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight+10);
    [self.view addSubview:bgImage];
    [self CreatData];
    [self CreatTableView];
}
-(void)CreatData{
    _titleArr=@[@"Username",@"E-mail",@"Verification code",@"Enter password",@"Confirm password"];
    _textArr=@[@"Username must contain 8 or more characters",@"Enter e-mail for verification code",@"Enter confirmation code",@"You must enter the password",@"Please confirm the password again"];
}
-(void)CreatTableView{
    self.baseTableView.mj_header=nil;
    self.baseTableView.mj_footer=nil;
    self.baseTableView.frame=CGRectMake(0, 64+30, ScreenWidth, ScreenHeight-64-30);
    self.baseTableView.backgroundColor=[UIColor clearColor];
    self.baseTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.baseTableView.tableFooterView=[self CreatFootView];
    [self.view addSubview:self.baseTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ForgotCell * cell =[ForgotCell cellWithTableView:tableView IndexPath:indexPath];
    cell.titleLabel.text=_titleArr[indexPath.row];
    cell.textField.placeholder=_textArr[indexPath.row];
    cell.textField.delegate=self;
    cell.textField.tag=indexPath.row;
    if (indexPath.row==1) {
        cell.sendBtn.hidden=NO;
        [cell.sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        return 120;
    }else{
        return 80;
    }
}


-(UIView*)CreatFootView{
    UIView * footView =[UIView new];
    footView.backgroundColor=[UIColor  clearColor];
    footView.frame=CGRectMake(0, 0, ScreenWidth, 300);
    
    UIButton * footBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.sd_cornerRadius=@(40/2);
    footBtn.backgroundColor=[UIColor whiteColor];
    [footBtn setTitleColor:Main_Color forState:0];
    [footBtn addTarget:self action:@selector(fooBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footBtn setTitle:@"SUBMIT" forState:0];
    [footView sd_addSubviews:@[footBtn]];
    footBtn.sd_layout
    .leftSpaceToView(footView, 30)
    .rightSpaceToView(footView, 30)
    .topSpaceToView(footView, 20)
    .heightIs(40);
    
    
    
    
    
    return footView;
}

#pragma mark ---网络请求
///获取验证码
-(void)getCodeDic:(NSMutableDictionary*)dic CodeBtn:(UIButton*)btn{
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:RegistApi_Code withParame:dic callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD hide];
            [ToolClass timeDaoJiShi:btn];
        }else{
            [LCProgressHUD showFailure:[item objectForKey:@"resultMessage"]];
        }
    } failedBlock:^(id error) {
        
    }];
}
///修改密码
-(void)xiuGaiPasswordDic:(NSDictionary*)dic{
    
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:PswApi_Psw withParame:dic callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD hide];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showFailure:[item objectForKey:@"resultMessage"]];
        }
    } failedBlock:^(id error) {
        
    }];
    
    
}












#pragma mark ---按钮点击事件
//提交
-(void)fooBtnClick{
    if (![_passwordText2 isEqualToString:_passwordText]) {
        [LCProgressHUD showFailure:@"2次密码不一致,请重新输入"];
        return;
    }
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:_emailText forKey:@"email"];
    [dic setObject:_codeText forKey:@"email_code"];
    [dic setObject:_passwordText forKey:@"login_pwd"];
    [self xiuGaiPasswordDic:dic];
    
}
//获取验证码
-(void)sendBtnClick:(UIButton*)btn{
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:_emailText] forKey:@"email"];
    [dic setObject:@"4497002800010002" forKey:@"msg_type"];
    [self getCodeDic:dic CodeBtn:btn];
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
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==0) {
        //username
        _usernameText=[ToolClass isString:textField.text];
    }else if(textField.tag==1){
        _emailText=[ToolClass isString:textField.text];
    }else if (textField.tag==2){
        _codeText=[ToolClass isString:textField.text];
    }else if (textField.tag==3){
        _passwordText=[ToolClass isString:textField.text];
    }else if (textField.tag==4){
        _passwordText2=[ToolClass isString:textField.text];
    }
}
@end
