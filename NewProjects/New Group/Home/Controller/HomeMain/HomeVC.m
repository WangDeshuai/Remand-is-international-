//
//  HomeVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/7.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "HomeVC.h"
#import "SDCycleScrollView.h"
#import "HomeCell.h"
#import "EditVC.h"//供应,求购页
#import "ParticularVC.h"
#import "HomeViewModel.h"
#import "SearchVC.h"//搜索页
#import "PurchaseDetailsVC.h"//详情页
@interface HomeVC ()<SDCycleScrollViewDelegate>

@property(nonatomic,strong)UIButton * searchBtn;
@property(nonatomic,strong)HomeViewModel *cellDataModel;
@end

@implementation HomeVC
- (void)viewWillAppear:(BOOL)animated{
     [self.navigationController.navigationBar addSubview:self.searchBtn];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.searchBtn removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backHomeBtn.hidden=YES;
//    self.automaticallyAdjustsScrollViewInsets=NO;
    [self CreatTabelView];
}
#pragma mark ---创建控件
-(UIButton*)searchBtn{
    if (!_searchBtn) {
        _searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame=CGRectMake(15, 0, ScreenWidth-30, 35);
        _searchBtn.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.2];
        [_searchBtn setImage:[UIImage imageNamed:@"search"] forState:0];
        [_searchBtn setTitle:@"Waste particles" forState:0];
        [_searchBtn SG_imagePositionStyle:SGImagePositionStyleDefault spacing:25];
        _searchBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        _searchBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
        _searchBtn.layer.cornerRadius=35/2;
        [_searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.clipsToBounds=YES;
    }
    
    return _searchBtn;
}



//创建表头
-(UIView*)CreatTabelViewHeader{
    UIView * headerView =[UIView new];
    headerView.backgroundColor=BG_COLOR;
    headerView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(300);
    //轮播图
    NSArray * imageArr =@[@"banner_1",@"banner_2"];
     SDCycleScrollView* cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 432/2) delegate:self placeholderImage:[UIImage imageNamed:@"banner_1"]];
    cycleScrollView.backgroundColor=BG_COLOR;
    cycleScrollView.pageControlBottomOffset=35;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imageArr;
    });
    cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
        
    };
    [headerView addSubview:cycleScrollView];
    
    //轮播图请求
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:FirstApi_Topimage withParame:nil callback:^(id item) {
        
    } failedBlock:^(id error) {
        
    }];
    
    
    //2个按钮
    NSArray * arrBtn =@[@"home_btn1",@"home_btn2"];
    NSArray * titleBtn =@[@"Supply",@"Purchase"];
    int d=15;
    int k= (ScreenWidth-d*3)/2;
    int g=k*223/349;
    UIButton * btn=nil;
    for (int i =0; i<arrBtn.count; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor whiteColor];
        button.frame=CGRectMake(d+(k+d)*i, cycleScrollView.frame.size.height-30, k, g);
        button.layer.cornerRadius=15;
        button.clipsToBounds=YES;
        button.tag=i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:arrBtn[i]] forState:0];
        button.titleLabel.font=[UIFont systemFontOfSize:17];
        [button setTitle:titleBtn[i] forState:0];
        [button SG_imagePositionStyle:SGImagePositionStyleTop spacing:10];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [headerView addSubview:button];
        btn=button;
    }
    
    [headerView setupAutoHeightWithBottomView:btn bottomMargin:15];
    
    __weak __typeof(headerView)weakSelf = headerView;
    headerView.didFinishAutoLayoutBlock=^(CGRect rect){
        weakSelf.sd_layout
        .heightIs(rect.size.height);
        [self.baseTableView setTableHeaderView:weakSelf];
    };
    
    
    return headerView;
}

//创建tableView
-(void)CreatTabelView{
    self.baseTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-53);
    self.baseTableView.rowHeight=70;
    self.baseTableView.tableHeaderView=[self CreatTabelViewHeader];
    self.baseTableView.mj_footer = nil;
    [self.view addSubview:self.baseTableView];
    [self.baseTableView.mj_header beginRefreshing];
}

#pragma mark ---tableViewDataSoure  tableViewDeleget
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDataModel.list.count;;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell * cell =[HomeCell cellWithTableView:tableView IndexPath:indexPath];
    cell.model = self.cellDataModel.list[ indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeViewList * model =self.cellDataModel.list[ indexPath.row];
    PurchaseDetailsVC * vc =[PurchaseDetailsVC new];
      vc.hidesBottomBarWhenPushed=YES;
    vc.codeText=model.productCode;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ---按钮点击事件
//求购 和 采购
-(void)buttonClick:(UIButton*)btn{
    EditVC * vc =[EditVC new];
    vc.hidesBottomBarWhenPushed=YES;
    vc.tagg=btn.tag;
    vc.keyWord=[ToolClass base64EncodedString:@"search"];//传递默认关键词
    [self.navigationController pushViewController:vc animated:YES];
}
//导航条搜索按
-(void)searchBtnClick{
    SearchVC * vc =[[SearchVC alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark -----网络请求类-----
//网络列表请求
-(void)getListView{
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:FirstApi_ShopShow withParame:nil callback:^(id item) {
        _cellDataModel =[HomeViewModel modelObjectWithDictionary:item];
        if (_cellDataModel.resultCode == 1) {
            [self.baseTableView reloadData];
             [LCProgressHUD hide];
        }else{
            [LCProgressHUD showMessage:_cellDataModel.resultMessage];
        }
        [self.baseTableView.mj_header endRefreshing];
    } failedBlock:nil];
}




-(void)mjHeaderRefresh{
    [self getListView];
}

@end
