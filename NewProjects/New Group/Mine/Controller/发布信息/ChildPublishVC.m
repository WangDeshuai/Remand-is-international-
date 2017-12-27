//
//  ChildPublishVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ChildPublishVC.h"
#import "ChildPublishCell.h"
#import "ChildPublishList.h"
#import "ReleaseChildVC.h"
#import "ReleaseModel.h"
@interface ChildPublishVC ()
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ChildPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BG_COLOR;
    _dataArray=[NSMutableArray array];
    [self CreatTableView];
}
#pragma mark --控件创建---------
-(void)CreatTableView{
    self.baseTableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-44);
    self.baseTableView.rowHeight=160;
    self.baseTableView.tableFooterView=[UIView new];
    self.baseTableView.backgroundColor=BG_COLOR;
    self.baseTableView.clipsToBounds = YES;
    [self.view addSubview:self.baseTableView];
    NSLog(@"%@",self.baseTableView);
    [self.baseTableView.mj_header beginRefreshing];
}
-(void)mjHeaderRefresh
{
    self.current=1;
    [self getPublicMessage:self.current];
}

-(void)mjFooterRefresh
{
   [self getPublicMessage:++self.current];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildPublishCell * cell =[ChildPublishCell cellWithTableView:tableView IndexPath:indexPath];
    //
    [self tableViewCell:cell IndexPath:indexPath];
    //实现cell高度缓存
   [self.baseTableView useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
   
    return cell;
}


-(void)tableViewCell:(ChildPublishCell*)cell IndexPath:(NSIndexPath*)indexPath{
    cell.editBtn.tag=indexPath.row;
    cell.undoBtn.tag=indexPath.row;
     [cell.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [cell.undoBtn addTarget:self action:@selector(undoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.model=[ChildPublishList modelObjectWithDictionary:_dataArray[indexPath.row]];
    if (_type==1) {
        //通过的
        cell.namelabel.hidden=YES;
    
    }else{
        //审核中 未通过的
        [cell.undoBtn setTitle:@"Delete" forState:0];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChildPublishList * model =  [ChildPublishList modelObjectWithDictionary:_dataArray[indexPath.row]];
    if ([model.isStatus isEqualToString:@"4497003100040003"]) {
        return 180;
    }else{
       return  150;
    }

}



#pragma mark ----网络请求类-------
-(void)getPublicMessage:(NSInteger)page{
    __weak typeof(self) weakSelf = self;
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:UserApi_PublicMessage withParame:@{@"page":[NSString stringWithFormat:@"%lu",page],@"auditStatus":[NSString stringWithFormat:@"%d",_type]} callback:^(id item) {
        [weakSelf.baseTableView.mj_header endRefreshing];
        [weakSelf.baseTableView.mj_footer endRefreshing];
        if ([item[@"resultCode"] integerValue] == 1) {
            if (self.current==1) {
                _dataArray=[NSMutableArray arrayWithArray:item[@"list"]];
            }else
            {
                [_dataArray addObjectsFromArray:item[@"list"]];
            }

        }else{
            self.current-=1;
            [LCProgressHUD showFailure:item[@"resultMessage"]];
        }
        
        
        [self.baseTableView reloadData];
    } failedBlock:^(id error) {
        [weakSelf.baseTableView.mj_header endRefreshing];
        [weakSelf.baseTableView.mj_footer endRefreshing];
    }];
    
    
}



#pragma mark -----按钮点击事件----------
//编辑
-(void)editBtnClick:(UIButton*)btn{
//    NSLog(@"点击了编辑>>type=%d---btn.tag=%lu",_type,(long)btn.tag);
    if (_type==0) {
        //第一个界面的编辑
          NSLog(@"点击了第一个界面的编辑%@",[btn superview]);
        ChildPublishCell *cell = (ChildPublishCell *)[[btn superview] superview];
        NSIndexPath *indexPath = [self.baseTableView indexPathForCell:cell];
        NSDictionary *dataDic = self.dataArray[indexPath.row];
        
//        cell.del
        [[Engine sharedEngine]BJPostWithUrl:Main_URL withAPIName:GetProductByUidAppEn withParame:@{@"uid":dataDic[@"uuid"]} callback:^(id item) {
            if ([item[@"resultCode"] integerValue] == 1) {
                ReleaseModel *model = [ReleaseModel modelObjectWithDictionary:item];  //数据模型转换
                ReleaseChildVC *vc = [[ReleaseChildVC alloc]initWithModel:model]; //创建编辑页面
                vc.title = @"编辑";
                [self.navigationController pushViewController:vc animated:YES];     //跳转编辑页面
            }else{
                [LCProgressHUD showMessage:item[@"resultMessage"]];
            }
            NSLog(@"%@",item);
        } failedBlock:nil];
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
        ChildPublishCell * cell =[self.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
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
