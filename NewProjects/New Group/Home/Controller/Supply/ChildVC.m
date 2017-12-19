//
//  ChildVC.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ChildVC.h"
#import "ChildCell.h"
#import "ChildView.h"
#import "PurchaseDetailsVC.h"//采购详情
#import "SuppleProduct.h"
@interface ChildVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray  *categoryData;
@property(nonatomic,strong)NSMutableArray  *cellDataArr;
@end

@implementation ChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellDataArr = [NSMutableArray array];
    _categoryData = [NSMutableArray array];
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
        button.tag=i;
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
    self.baseTableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-44);
    self.baseTableView.sectionHeaderHeight=10;
    self.baseTableView.tableHeaderView=[self CreatViewHeadder];
    self.baseTableView.rowHeight=100;
    [self.view addSubview: self.baseTableView];
    [self.baseTableView.mj_header beginRefreshing];
}

-(void)mjHeaderRefresh{
    NSLog(@">>>>%@",_sortType);
  
    self.current=1;
    [self getWangLuoJiekouDicInt:self.current];
}
-(void)mjFooterRefresh
{
    [self getWangLuoJiekouDicInt:self.current++];
}

#pragma mark ---代理  tableViewDataSource  tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDataArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildCell * cell =[ChildCell cellWithTableView:tableView IndexPath:indexPath];
    cell.model=self.cellDataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SuppleProduct * md =self.cellDataArr[indexPath.row];
    PurchaseDetailsVC * vc=[PurchaseDetailsVC new];
    vc.codeText=md.productCode;
    [self.navigationController pushViewController:vc animated:YES];
  
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[UIView new];
    return view;
}


#pragma mark -----按钮点击事件
//topBtnClick
-(void)topBtnClinck:(UIButton*)btn{
    int g=360;//view的高度
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[btn convertRect:btn.bounds toView:window];
    [self CusterView:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect),CGRectGetWidth(rect), g)DataArr:self.categoryData];
   
}


#pragma mark --获取网络接口
-(void)getWangLuoJiekouDicInt:(NSInteger )page {
    //
    NSDictionary *dic1 = @{@"keyWord":_keyWord,@"pageNo":[NSString stringWithFormat:@"%ld",(long)page],@"datatype":_dataType,@"sortType":_sortType};
    
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:SearchApi_Search withParame:dic1 callback:^(id item) {
        [LCProgressHUD hide];
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        if ([code isEqualToString:@"1"]) {
            self.categoryData = item[@"categorys"];
            NSArray *dataArr = item[@"product"];
            if (self.current==1) {
                self.cellDataArr =[NSMutableArray array];
            }
            for (NSDictionary *item in dataArr) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [self.cellDataArr addObject:[SuppleProduct modelObjectWithDictionary:item]];
                }
            }
            [self.baseTableView reloadData];
        }else{
            self.current--;
        }

        [self.baseTableView.mj_header endRefreshing];
        [self.baseTableView.mj_footer endRefreshing];
    } failedBlock:^(id error) {
        [self.baseTableView.mj_header endRefreshing];
        [self.baseTableView.mj_footer endRefreshing];
    }];
}


-(void)CusterView:(CGRect)frame DataArr:(NSArray*)arr{
    ChildView * vc =[[ChildView alloc]initWithFrame:frame AndDataArr:arr];
    [vc show];
}


@end
