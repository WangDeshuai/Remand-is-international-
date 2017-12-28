//
//  SubmitVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/28.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "SubmitVC.h"

@interface SubmitVC ()

@end

@implementation SubmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Submit comments";
    UIImageView * imageView =[UIImageView new];
    imageView.image=[UIImage imageNamed:@"login_bg"];
    imageView.userInteractionEnabled=YES;
    imageView.frame=self.view.bounds;
    [self.view addSubview:imageView];
    [self CreatUI];
}

-(void)CreatUI{
    int d =30;
    UILabel * namelable =[UILabel new];
    namelable.text=@"Email";
    namelable.textColor=[UIColor whiteColor];
    namelable.font=[UIFont systemFontOfSize:16];
    [self.view sd_addSubviews:@[namelable]];
    namelable.sd_layout
    .leftSpaceToView(self.view, d)
    .rightSpaceToView(self.view, d)
    .topSpaceToView(self.view, 50+64)
    .heightIs(20);
    
    UITextField * textFieldAccount =[UITextField new];
//    textFieldAccount.backgroundColor=[UIColor greenColor];
    [self.view sd_addSubviews:@[textFieldAccount]];
    textFieldAccount.sd_layout
    .leftEqualToView(namelable)
    .self.rightSpaceToView(self.view, d)
    .topSpaceToView(namelable, 5)
    .heightIs(30);
    
    UIView * lineView =[UIView new];
    lineView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.5];
    [self.view sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftEqualToView(textFieldAccount)
    .rightEqualToView(textFieldAccount)
    .topSpaceToView(textFieldAccount, 0)
    .heightIs(1);
    
    UILabel * namelable2 =[UILabel new];
    namelable2.text=@"Detaels";
    namelable2.textColor=[UIColor whiteColor];
    namelable2.font=[UIFont systemFontOfSize:16];
    [self.view sd_addSubviews:@[namelable2]];
    namelable2.sd_layout
    .leftSpaceToView(self.view, d)
    .rightSpaceToView(self.view, d)
    .topSpaceToView(lineView, 30)
    .heightIs(20);
    
    UITextView * textView =[UITextView new];
    textView.backgroundColor=[UIColor clearColor];
    [self.view sd_addSubviews:@[textView]];
    textView.sd_layout
    .leftEqualToView(lineView)
    .rightEqualToView(lineView)
    .topSpaceToView(namelable2, 5)
    .heightIs(120);
    
   

    UIView * lineView2 =[UIView new];
    lineView2.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.5];
    [self.view sd_addSubviews:@[lineView2]];
    lineView2.sd_layout
    .leftEqualToView(textFieldAccount)
    .rightEqualToView(textFieldAccount)
    .topSpaceToView(textView, 0)
    .heightIs(1);
    
    
    UIButton *commentBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.backgroundColor=Main_Color;
    [commentBtn setTitleColor:[UIColor whiteColor] forState:0];
    commentBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    commentBtn.layer.borderWidth=.5;
    [commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    commentBtn.sd_cornerRadius=@(20);
    [commentBtn setTitle:@"SUBMIT" forState:0];
    commentBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view sd_addSubviews:@[commentBtn]];
    commentBtn.sd_layout
    .leftEqualToView(lineView)
    .rightEqualToView(lineView)
    .topSpaceToView(lineView2, 60)
    .heightIs(40);
    
    
    
}


-(void)commentBtnClick
{
    
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
