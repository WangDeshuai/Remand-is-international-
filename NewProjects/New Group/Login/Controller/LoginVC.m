//
//  LoginVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "LoginVC.h"
#import "RegistVC.h"//注册
#import "LoginModel.h"//登录
#import "ForgotpswVC.h"//忘记密码
@interface LoginVC ()
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UITextField * phoneText;
@property(nonatomic,strong)UITextField * pswText;
@end

@implementation LoginVC


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
     self.navigationController.navigationBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bgView=self.view;
    self.backHomeBtn.hidden=YES;
    [self CreatUI];
}

-(void)CreatUI{
    UIImageView * imageView =[UIImageView new];
    imageView.image=[UIImage imageNamed:@"login_bg"];
    imageView.userInteractionEnabled=YES;
    imageView.frame=self.view.bounds;
    [_bgView addSubview:imageView];
    
    //logo  75 73
    UIImageView * logoImage =[UIImageView new];
    logoImage.image=[UIImage imageNamed:@"login_logo1"];
    [imageView sd_addSubviews:@[logoImage]];
    logoImage.sd_layout
    .centerXEqualToView(imageView)
    .topSpaceToView(imageView, 43+44)
    .widthIs(100)
    .heightIs(100*73/75);
    
    //view
    UIView * textView =[UIView new];
    textView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.2];
    textView.sd_cornerRadius=@(5);
    [imageView sd_addSubviews:@[textView]];
    textView.sd_layout
    .leftSpaceToView(imageView, 20)
    .rightSpaceToView(imageView, 20)
    .topSpaceToView(logoImage, 43)
    .heightIs(120);
    
    
    //白线
    UIView * lineView =[UIView new];
    lineView.backgroundColor=[UIColor whiteColor];
    [textView sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(textView, 50)
    .rightSpaceToView(textView, 15)
    .centerYEqualToView(textView)
    .heightIs(1);
    
    //账号
    UITextField * accountText =[UITextField new];
    accountText.placeholder=@"Telephone number";
    accountText.textColor=[UIColor whiteColor];
    accountText.placeholderColor=[UIColor whiteColor];
    accountText.font=[UIFont systemFontOfSize:15];
    accountText.leftView=[ToolClass imageViewNameStr:@"login_phone"];
    accountText.leftViewMode=UITextFieldViewModeAlways;
    _phoneText=accountText;
    [textView sd_addSubviews:@[accountText]];
    accountText.sd_layout
    .leftSpaceToView(textView, 5)
    .rightSpaceToView(textView, 5)
    .topSpaceToView(textView, 0)
    .bottomSpaceToView(lineView, 0);
    
    //密码
    UITextField * pswText =[UITextField new];
    _pswText=pswText;
    pswText.placeholder=@"Password";
    pswText.placeholderColor=[UIColor whiteColor];
    pswText.textColor=[UIColor whiteColor];
    pswText.leftView=[ToolClass imageViewNameStr:@"login_psw"];
    pswText.leftViewMode=UITextFieldViewModeAlways;
    pswText.font=[UIFont systemFontOfSize:15];
    [textView sd_addSubviews:@[pswText]];
    pswText.sd_layout
    .leftEqualToView(accountText)
    .rightEqualToView(accountText)
    .topSpaceToView(lineView, 0)
    .bottomSpaceToView(textView, 0);
    
    
    //登录按钮
    UIButton * loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.2];
    [loginBtn setTitle:@"Login" forState:0];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if (@available(iOS 8.2, *)) {
        loginBtn.titleLabel.font=[UIFont systemFontOfSize:17 weight:5];
    } else {
        // Fallback on earlier versions
    }
    loginBtn.sd_cornerRadius=@(5);
    [imageView sd_addSubviews:@[loginBtn]];
    loginBtn.sd_layout
    .leftEqualToView(textView)
    .rightEqualToView(textView)
    .topSpaceToView(textView, 20)
    .heightIs(50);
    
    //忘记密码
    UIButton * forgetBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"Forget your details?" forState:0];
    forgetBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView sd_addSubviews:@[forgetBtn]];
    forgetBtn.sd_layout
    .centerXEqualToView(loginBtn)
    .topSpaceToView(loginBtn, 10)
    .widthIs(200)
    .heightIs(20);
    
    //注册按钮
    UIButton * registBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [registBtn setTitle:@"Creat an account" forState:0];
    if (@available(iOS 8.2, *)) {
        registBtn.titleLabel.font=[UIFont systemFontOfSize:17 weight:.3];
    } else {
    }
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView sd_addSubviews:@[registBtn]];
    registBtn.sd_layout
    .centerXEqualToView(imageView)
    .bottomSpaceToView(imageView, 40)
    .widthIs(200)
    .heightIs(20);
    
    
}


#pragma mark -----------按钮点击事件---------
//忘记密码
-(void)forgetBtnClick{
    ForgotpswVC * vc =[ForgotpswVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
//注册按钮
-(void)registBtnClick{
    RegistVC * vc =[RegistVC new];
    vc.hidesBottomBarWhenPushed=YES;
    vc.registBlock = ^(NSString *username, NSString *psw) {
        _phoneText.text=username;
        _pswText.text=psw;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//登录按钮
-(void)loginBtnClick{
    NSString * user =[ToolClass isString:_phoneText.text];
    NSString * psw =[ToolClass isString:_pswText.text];
    NSLog(@">>>%@>>>>%@",user,psw);
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:_phoneText.text] forKey:@"email"];
    [dic setObject:[ToolClass isString:_pswText.text] forKey:@"pwd"];
    [dic setObject:@"4497002900130002" forKey:@"loginpath"];
    [self loginDic:dic];
}



#pragma mark --网络请求类
-(void)loginDic:(NSMutableDictionary*)dic{
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:LoginApi_Login withParame:dic callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD showMessage:@"登录成功"];
            LoginModel * model =[[LoginModel alloc]initWithLoginDic:item];
            [NSUSE_DEFO setObject:model.access_token forKey:API_Token];
            [NSUSE_DEFO setObject:model.email forKey:API_Email];
            [NSUSE_DEFO setObject:model.account_typeName forKey:API_Type];
            [NSUSE_DEFO setObject:[ToolClass isString:_phoneText.text] forKey:API_UserName];
            [NSUSE_DEFO synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showFailure:[item objectForKey:@"resultMessage"]];
        }
    } failedBlock:^(id error) {
        
    }];
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
