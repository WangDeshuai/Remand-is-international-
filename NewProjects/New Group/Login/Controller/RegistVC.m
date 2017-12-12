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
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegistCell * cell =[RegistCell cellWithTableView:tableView IndexPath:indexPath];
    cell.titleLabel.text=_titleArr[indexPath.row];
    cell.contentText.delegate=self;
    cell.contentText.tag=indexPath.row;
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
    }else if (indexPath.row==4) {
        cell.contentText.placeholder=@"Enter confirmation code";
        cell.contentText.keyboardType=UIKeyboardTypeNumberPad;
        cell.confirmBtn.hidden=NO;
        cell.titleLabel.sd_layout
        .topSpaceToView(cell.confirmBtn, 25);
    }
    cell.contentText.placeholderColor=[[UIColor whiteColor]colorWithAlphaComponent:.6];

    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==4) {
        return 120;
    }else{
        return 90;
    }
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
-(void)footBtnClick:(UIButton*)btn{
    NSLog(@"按钮点击");
    NSLog(@">>>>%@>>>%@>>>>%@>>>>%@>>>%@",_userName,_password,_password2,_emailText,_codeText);
    
    
    
}





#pragma mark --textFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==0) {
        //用户名
        _userName=textField.text;
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
