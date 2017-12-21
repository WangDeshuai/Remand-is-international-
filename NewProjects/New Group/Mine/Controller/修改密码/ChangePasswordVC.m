//
//  ChangePasswordVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/18.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()
@property (nonatomic,strong)UIView * bgView;
@property (nonatomic,strong)UITextField * accountText;
@property (nonatomic,strong)UITextField * oldText;
@property (nonatomic,strong)UITextField * newwText;
@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Change Password";
    UIImageView * bgImage =[UIImageView new];
    bgImage.image=[UIImage imageNamed:@"regist_bg"];
    bgImage.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight+10);
    bgImage.userInteractionEnabled=YES;
    [self.view addSubview:bgImage];
    self.bgView=bgImage;
    [self CreatUI];
}



-(void)CreatUI{
    UILabel * namelabel1 =[UILabel new];
//    namelabel1.backgroundColor=[UIColor greenColor];
    namelabel1.text=@"Account number";
    namelabel1.textAlignment=0;
    namelabel1.textColor=[UIColor whiteColor];
    namelabel1.font=[UIFont systemFontOfSize:16];
    [_bgView sd_addSubviews:@[namelabel1]];
    namelabel1.sd_layout
    .leftSpaceToView(_bgView, 30)
    .rightSpaceToView(_bgView, 30)
    .topSpaceToView(_bgView, 100)
    .heightIs(20);
    
    UITextField * accountText1 =[UITextField new];
//    accountText1.backgroundColor=[UIColor greenColor];
    _oldText=accountText1;
    accountText1.textColor=[UIColor whiteColor];
    accountText1.font=[UIFont systemFontOfSize:16];
    [_bgView sd_addSubviews:@[accountText1]];
    accountText1.sd_layout
    .leftEqualToView(namelabel1)
    .rightEqualToView(namelabel1)
    .topSpaceToView(namelabel1, 10)
    .heightIs(30);
    
    
    UIView * linView =[UIView new];
    linView.backgroundColor=[UIColor whiteColor];
    [_bgView sd_addSubviews:@[linView]];
    linView.sd_layout
    .leftEqualToView(accountText1)
    .rightEqualToView(accountText1)
    .topSpaceToView(accountText1, 0)
    .heightIs(1);
    
//---------//
    UILabel * namelabel2 =[UILabel new];
//    namelabel2.backgroundColor=[UIColor greenColor];
    namelabel2.text=@"Old password";
    
    namelabel2.textAlignment=0;
    namelabel2.textColor=[UIColor whiteColor];
    namelabel2.font=[UIFont systemFontOfSize:16];
    [_bgView sd_addSubviews:@[namelabel2]];
    namelabel2.sd_layout
    .leftEqualToView(namelabel1)
    .rightEqualToView(namelabel1)
    .topSpaceToView(linView, 30)
    .heightIs(20);
    
    UITextField * accountText2 =[UITextField new];
//    accountText2.backgroundColor=[UIColor greenColor];
    accountText2.textColor=[UIColor whiteColor];
    _oldText=accountText2;
    accountText2.font=[UIFont systemFontOfSize:16];
    [_bgView sd_addSubviews:@[accountText2]];
    accountText2.sd_layout
    .leftEqualToView(namelabel2)
    .rightEqualToView(namelabel2)
    .topSpaceToView(namelabel2, 10)
    .heightIs(30);
    
    
    UIView * linView2 =[UIView new];
    linView2.backgroundColor=[UIColor whiteColor];
    [_bgView sd_addSubviews:@[linView2]];
    linView2.sd_layout
    .leftEqualToView(accountText2)
    .rightEqualToView(accountText2)
    .topSpaceToView(accountText2, 0)
    .heightIs(1);
    
    
    //-----------///
    
    
    UILabel * namelabel3 =[UILabel new];
//    namelabel3.backgroundColor=[UIColor greenColor];
    namelabel3.text=@"New password";
    namelabel3.textAlignment=0;
    namelabel3.textColor=[UIColor whiteColor];
    namelabel3.font=[UIFont systemFontOfSize:16];
    [_bgView sd_addSubviews:@[namelabel3]];
    namelabel3.sd_layout
    .leftEqualToView(namelabel1)
    .rightEqualToView(namelabel1)
    .topSpaceToView(linView2, 30)
    .heightIs(20);
    
    UITextField * accountText3 =[UITextField new];
//    accountText3.backgroundColor=[UIColor greenColor];
    accountText3.textColor=[UIColor whiteColor];
    _newwText=accountText3;
    accountText3.font=[UIFont systemFontOfSize:16];
    [_bgView sd_addSubviews:@[accountText3]];
    accountText3.sd_layout
    .leftEqualToView(namelabel3)
    .rightEqualToView(namelabel3)
    .topSpaceToView(namelabel3, 10)
    .heightIs(30);
    
    
    UIView * linView3 =[UIView new];
    linView3.backgroundColor=[UIColor whiteColor];
    [_bgView sd_addSubviews:@[linView3]];
    linView3.sd_layout
    .leftEqualToView(accountText3)
    .rightEqualToView(accountText3)
    .topSpaceToView(accountText3, 0)
    .heightIs(1);
    
    
    
    UIButton *commentBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.backgroundColor=[UIColor whiteColor];
    [commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    commentBtn.sd_cornerRadius=@(20);
    [commentBtn setTitleColor:Main_Color forState:0];
    [commentBtn setTitle:@"SAVE" forState:0];
    commentBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [_bgView sd_addSubviews:@[commentBtn]];
    commentBtn.sd_layout
    .leftEqualToView(namelabel1)
    .rightEqualToView(namelabel1)
    .topSpaceToView(linView3, 40)
    .heightIs(40);
    
}


-(void)commentBtnClick{
    NSString * str1 =[ToolClass isString:_accountText.text];
    NSString * str2=[ToolClass isString:_oldText.text];
    NSString * str3 =[ToolClass isString:_newwText.text];
    NSDictionary * dic =@{@"pwd_old":str2,@"pwd_new":str3};
    [self changePasswordDic:dic];
    
}

-(void)changePasswordDic:(NSDictionary*)dic {
    
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:VIPApi_Changepassword withParame:dic callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD showMessage:Message_Success   ];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [LCProgressHUD showMessage:[item objectForKey:@"resultMessage"]];
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
