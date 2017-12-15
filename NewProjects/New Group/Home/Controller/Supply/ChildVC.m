//
//  ChildVC.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ChildVC.h"
#import "ChildCell.h"
#import "ReleaseMainVC.h"
#import "ChildView.h"
#import "PurchaseDetailsVC.h"//采购详情
@interface ChildVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation ChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CreatTabelView];
}
#pragma mark -----创建控件
//表头
-(UIView*)CreatViewHeadder{
    UIView * headerView =[UIView new];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(120);
  
    int d =15;
    int k =(ScreenWidth-d*3)/2;
    int g=35;
    NSArray * array =@[@"Area",@"Waste plastic",@"Broken pieces",@"Recyled particles"];
  
    for (int i =0; i<array.count; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor whiteColor];
        [button setImage:[UIImage imageNamed:@"arrowxia"] forState:0];
        [button setTitle:array[i] forState:0];
        button.layer.borderColor=[[UIColor lightGrayColor] colorWithAlphaComponent:.7].CGColor;
        button.layer.borderWidth=1;
        [button setTitleColor:[UIColor lightGrayColor]   forState:0];
        [button addTarget:self action:@selector(topBtnClinck:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        button.sd_cornerRadius=@(5);
        [headerView sd_addSubviews:@[button]];
        button.sd_layout
        .leftSpaceToView(headerView, d+(d+k)*(i%2))
        .topSpaceToView(headerView, d+(d+g)*(i/2))
        .widthIs(k)
        .heightIs(g);
        
        button.imageView.sd_layout
        .rightSpaceToView(button, 10)
        .centerYEqualToView(button)
        .widthIs(16)
        .heightIs(16);
        
        button.titleLabel.sd_layout
        .leftSpaceToView(button, 10)
        .rightSpaceToView(button.imageView, 5)
        .centerYEqualToView(button)
        .heightIs(20);
        
        
    }
    
    
    
    return headerView;
}

//tableView
-(void)CreatTabelView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-44) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tableFooterView=[UIView new];
    tableView.tableHeaderView=[self CreatViewHeadder];
    tableView.backgroundColor=BG_COLOR;
    tableView.sectionHeaderHeight=10;
    tableView.rowHeight=100;
    [self.view addSubview:tableView];
}

#pragma mark ---代理  tableViewDataSource  tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildCell * cell =[ChildCell cellWithTableView:tableView IndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        PurchaseDetailsVC * vc =[PurchaseDetailsVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        ReleaseMainVC * vc =[ReleaseMainVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
  
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[UIView new];
    return view;
}


#pragma mark -----按钮点击事件
//topBtnClick
-(void)topBtnClinck:(UIButton*)btn{
    ChildView * vc =[[ChildView alloc]initWithFrame:CGRectMake(15, 64+45+12, (ScreenWidth-15*3)/2, 360) AndDataArr:@[@"China",@"Canada",@"United",@"States",@"Finland",@"Sweden",@"Norway",@"Unted",@"Kingdom",@"Ireland Netherlands",@"Belgium Luxembourg",@"France Monaco"]];
    [vc show];
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
