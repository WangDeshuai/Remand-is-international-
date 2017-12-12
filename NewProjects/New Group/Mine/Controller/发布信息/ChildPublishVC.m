//
//  ChildPublishVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ChildPublishVC.h"
#import "ChildPublishCell.h"
@interface ChildPublishVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation ChildPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BG_COLOR;
    [self CreatTableView];
}
#pragma mark --控件创建---------
-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-44) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.rowHeight=160;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=BG_COLOR;
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildPublishCell * cell =[ChildPublishCell cellWithTableView:tableView IndexPath:indexPath];
    //
    [self tableViewCell:cell IndexPath:indexPath];
    //实现cell高度缓存
   [_tableView useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
   
    return cell;
}


-(void)tableViewCell:(ChildPublishCell*)cell IndexPath:(NSIndexPath*)indexPath{
    cell.editBtn.tag=indexPath.row;
    cell.undoBtn.tag=indexPath.row;
     [cell.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [cell.undoBtn addTarget:self action:@selector(undoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (_type==0) {
        //通过的
        cell.namelabel.hidden=YES;
    }else{
        //审核中 未通过的
        [cell.undoBtn setTitle:@"Delete" forState:0];
        if (indexPath.row==0|| indexPath.row==3) {
            cell.namelabel.hidden=NO;
            cell.editBtn.sd_layout.topSpaceToView(cell.namelabel, 15);
        }else{
            cell.namelabel.hidden=YES;
            cell.editBtn.sd_layout.topSpaceToView(cell.namelabel, -15);
        }
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_tableView cellHeightForIndexPath:indexPath cellContentViewWidth:[ToolClass cellContentViewWith] tableView:tableView];
}







#pragma mark -----按钮点击事件----------
//编辑
-(void)editBtnClick:(UIButton*)btn{
//    NSLog(@"点击了编辑>>type=%d---btn.tag=%lu",_type,(long)btn.tag);
    if (_type==0) {
        //第一个界面的编辑
          NSLog(@"点击了第一个界面的编辑");
    }else{
        //第二个界面的编辑
          NSLog(@"点击了第二个界面的编辑");
    }
    
    
}
//撤销
-(void)undoBtnClick:(UIButton*)btn{
   
    if (_type==0) {
        //第一个界面的撤销
        //1.找到对应的cell
        ChildPublishCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
        //2.隐藏undo按钮
        cell.undoBtn.hidden=YES;
        //3.修改editbtn的背景颜色
        cell.editBtn.backgroundColor=Main_Color;
        [cell.editBtn setTitle:@"Resend" forState:0];
        cell.editBtn.tag=btn.tag;
        [cell.editBtn setTitleColor:[UIColor whiteColor] forState:0];
        //4.重写editBtn按钮点击事件
    }else{
        //第二个界面的删除
        NSLog(@"点击了第二个界面的删除");
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
