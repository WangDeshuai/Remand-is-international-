//
//  PurchaseVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/28.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "PurchaseVC.h"

@interface PurchaseVC ()

@end

@implementation PurchaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Purchase History";
    [self CreatTableView];
}

-(void)CreatTableView{
  
    self.baseTableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.baseTableView.tableFooterView=[UIView new];
    self.baseTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.baseTableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"第%lu行",indexPath.row];
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
