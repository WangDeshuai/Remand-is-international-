//
//  ForgotpswVC.m
//  NewProjects
//
//  Created by Mac on 2017/12/17.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ForgotpswVC.h"
#import "ForgotCell.h"
@interface ForgotpswVC ()
@property(nonatomic,strong)NSArray * titleArr;
@end

@implementation ForgotpswVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Forget password";
    [self CreatData];
    [self CreatTableView];
}
-(void)CreatData{
    _titleArr=@[@"Username",@"E-mail",@"Verification code",@"Enter password",@"Confirm password"];
}
-(void)CreatTableView{
    self.baseTableView.rowHeight=120;
    self.baseTableView.mj_header=nil;
    self.baseTableView.mj_footer=nil;
    self.baseTableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:self.baseTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ForgotCell * cell =[ForgotCell cellWithTableView:tableView IndexPath:indexPath];
    cell.backgroundColor=[UIColor magentaColor];
    
    return cell;
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
