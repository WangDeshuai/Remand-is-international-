//
//  RegistVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "RegistVC.h"
#import "RegistCell.h"
@interface RegistVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString * _userName;//用户名
    NSString * _password;//密码
    NSString * _password2;//确认密码
    NSString * _emailText;//邮箱
    NSString * _codeText;//验证码
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArr;
@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Registration page";
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIImageView * bgImage =[UIImageView new];
    bgImage.image=[UIImage imageNamed:@"regist_bg"];
    bgImage.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight+10);
    [self.view addSubview:bgImage];
    [self CreatData];
    [self CreatTableView];
    
}


-(void)CreatData{
    _titleArr=@[@"Username",@"Enter password",@"Confirm password",@"E-mail",@"Verification code"];
}



-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64+20, ScreenWidth, ScreenHeight-64-20) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.tableFooterView=[self CreatTableViewFootView];
    tableView.backgroundColor=[UIColor clearColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegistCell * cell =[RegistCell cellWithTableView:tableView IndexPath:indexPath];
    cell.contentView.clipsToBounds = YES;
    cell.titleLabel.text=_titleArr[indexPath.row];
    cell.contentText.delegate=self;
    cell.contentText.tag=indexPath.row;
    cell.tishiBtn.sd_layout.topSpaceToView(cell.lineView, 10);
    cell.tishiBtn.hidden=YES;
    if (indexPath.row==0) {
        cell.contentText.placeholder=@"Username must contain 8 or more  characters";
    }else if(indexPath.row==1){
        cell.contentText.placeholder=@"You must enter the password";
        cell.contentText.secureTextEntry=YES;
    }else if (indexPath.row==2){
        cell.contentText.placeholder=@"Please confirm the password again";
        cell.contentText.secureTextEntry=YES;
    }else if (indexPath.row==3){
        cell.contentText.placeholder=@"Enter e-mail for verfication code";
        cell.contentText.keyboardType=UIKeyboardTypeEmailAddress;
        cell.confirmBtn.hidden=NO;
        [cell.confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.tishiBtn.sd_layout.topSpaceToView(cell.confirmBtn, 10);
    }else if (indexPath.row==4) {
        cell.contentText.placeholder=@"Enter confirmation code";
        cell.contentText.keyboardType=UIKeyboardTypeNumberPad;
    }
    cell.contentText.placeholderColor=[[UIColor whiteColor]colorWithAlphaComponent:.6];
//    if (indexPath.row==0 || indexPath.row==2|| indexPath.row==4) {
//         cell.backgroundColor=[UIColor magentaColor];
//    }else{
//         cell.backgroundColor=[UIColor greenColor];
//    }
   
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_tableView cellHeightForIndexPath:indexPath cellContentViewWidth:[ToolClass cellContentViewWith] tableView:tableView];
}





#pragma mark -----创建提交按钮
-(UIView*)CreatTableViewFootView{
    UIView * footView =[UIView new];
    footView.backgroundColor=[UIColor clearColor];
    footView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(200);
    
    UIButton * footBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.backgroundColor=[UIColor whiteColor];
    footBtn.layer.borderWidth=.5;
    footBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    [footBtn addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footBtn setTitle:@"SUBMIT" forState:0];
    [footBtn setTitleColor:Main_Color forState:0];
    footBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    footBtn.sd_cornerRadius=@(45/2);
    [footView sd_addSubviews:@[footBtn]];
    footBtn.sd_layout
    .leftSpaceToView(footView, 30)
    .rightSpaceToView(footView, 30)
    .topSpaceToView(footView, 30)
    .heightIs(45);
    
    return footView;
}




#pragma mark ---按钮点击事件
//注册
-(void)footBtnClick:(UIButton*)btn{
//    NSLog(@">>>>%@>>>%@>>>>%@>>>>%@>>>%@",_userName,_password,_password2,_emailText,_codeText);
    if (![_password isEqualToString:_password2]) {
        [LCProgressHUD showFailure:@"两次密码不一致!"];
        return;
    }
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:_codeText] forKey:@"email_code"];
    [dic setObject:[ToolClass isString:_emailText] forKey:@"email"];
    [dic setObject:[ToolClass isString:_userName] forKey:@"login_name"];
    [dic setObject:[ToolClass isString:_password] forKey:@"login_pwd"];
    [self registDic:dic];
    
}
///获取验证码
-(void)confirmBtnClick:(UIButton*)btn{
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:_emailText] forKey:@"email"];
    [dic setObject:@"4497002800010001" forKey:@"msg_type"];
    [self getCodeDic:dic CodeBtn:btn];

}

///实现倒计时
-(void)timeDaoJiShi:(UIButton*)btn{
  
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
        }
        else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [btn setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                btn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}




#pragma mark --textFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
  
    
    if (textField.tag==0) {
        //用户名
        _userName=textField.text;
         [self NetworkRequestParametersTextSting:textField.text Tag:textField.tag];
    }else if (textField.tag==1){
        //密码
        _password=textField.text;
    }else if (textField.tag==2){
        //确认密码
        _password2=textField.text;
    }else if (textField.tag==3){
        //邮箱
        _emailText=textField.text;
    }else if (textField.tag==4){
        //验证码
        _codeText=textField.text;
    }
}





#pragma mark -----网络请求参数
///验证用户名
-(void)NetworkRequestParametersTextSting:(NSString*)str Tag:(NSInteger)tag{
    
    RegistCell * cell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tag inSection:0]];
    [[Engine sharedEngine]BJPostWithUrl:Main_URL withAPIName:RegistApi_Name withParame:@{@"login_name":[ToolClass isString:str]} callback:^(id item) {
        NSLog(@"%@", item );
         cell.tishiBtn.hidden = NO;
        if ([[item objectForKey:@"resultCode"]integerValue]==1) {
            [cell.tishiBtn setImage:[UIImage imageNamed:@"login_yeah"] forState:0];
            [cell.tishiBtn setTitle:[item objectForKey:@"resultMessage"] forState:0];
        }else{
            [cell.tishiBtn setImage:[UIImage imageNamed:@"login_error"] forState:0];
            [cell.tishiBtn setTitle:[item objectForKey:@"resultMessage"] forState:0];
            
        }
        
       [LCProgressHUD hide];
       
    } failedBlock:nil];
    
}
///获取验证码
-(void)getCodeDic:(NSMutableDictionary*)dic CodeBtn:(UIButton*)btn{
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:RegistApi_Code withParame:dic callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD hide];
            [self timeDaoJiShi:btn];
        }else{
            [LCProgressHUD showFailure:[item objectForKey:@"resultMessage"]];
        }
    } failedBlock:^(id error) {
        
    }];
}

///注册请求
-(void)registDic:(NSMutableDictionary*)dic{
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:RegistApi_Regist withParame:dic callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD showMessage:@"注册成功"];
            self.registBlock(_userName, _password);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showFailure:[item objectForKey:@"resultMessage"]];
        }
    } failedBlock:^(id error) {
        
    }];
    
    
    /*
     {
     resultCode = 1;
     resultList = "<null>";
     resultMessage = "";
     resultObject = "<null>";
     resultType = "";
     }
     
     */
    
    
}

@end
