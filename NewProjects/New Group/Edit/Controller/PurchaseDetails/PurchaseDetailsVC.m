//
//  PurchaseDetailsVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "PurchaseDetailsVC.h"
#import "PurchaseDetailsCell.h"
#import "SDCycleScrollView.h"
@interface PurchaseDetailsVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * leftNameArr;
@end

@implementation PurchaseDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Purchase details";
    [self CreatDataArr];
    [self CreatTableView];
}

-(void)CreatDataArr{
    _leftNameArr=@[@"Notice number",@"Location",@"Inventory quantity",@"Price",@"Single package weight",@"Processing raw materials",@"Colour",@"Mesh",@"Density",@"Calcum content",@"Flammability"];
}

#pragma mark -----创建控件 
-(UIView*)CreatTableViewHeaderView{
    UIView * headerView=[UIView new];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(400);
    //标题
    UILabel * titleLabel =[UILabel new];
    titleLabel.font=[UIFont systemFontOfSize:15];
    titleLabel.text=@"A group of steel color steel title fire board barrel 2o heating pipes 2 tons of treatment";
    [headerView sd_addSubviews:@[titleLabel]];
    titleLabel.sd_layout
    .leftSpaceToView(headerView, 15)
    .rightSpaceToView(headerView, 15)
    .topSpaceToView(headerView, 15)
    .autoHeightRatio(0);
    //时间
    UILabel * timeLabel =[UILabel new];
    timeLabel.alpha=.4;
    timeLabel.font=[UIFont systemFontOfSize:15];
    timeLabel.text=@"January 14,2018";
    [headerView sd_addSubviews:@[timeLabel]];
    timeLabel.sd_layout
    .leftEqualToView(titleLabel)
    .heightIs(20)
    .topSpaceToView(titleLabel, 10);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:300];
   
    //轮播图
    NSArray * imageArr =@[@"banner_3",@"banner_3"];
    SDCycleScrollView* cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner_3"]];
    cycleScrollView.backgroundColor=BG_COLOR;
    cycleScrollView.pageControlBottomOffset=-35;
    cycleScrollView.currentPageDotColor=Main_Color;
    cycleScrollView.pageDotColor=[Main_Color colorWithAlphaComponent:.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imageArr;
    });
    cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
        //点击事件
    };
    [headerView sd_addSubviews:@[cycleScrollView]];
    cycleScrollView.sd_layout
    .leftSpaceToView(headerView, 15)
    .rightSpaceToView(headerView, 15)
    .topSpaceToView(timeLabel, 20)
    .heightIs(432/2);
    
    
    
    
    [headerView setupAutoHeightWithBottomView:cycleScrollView bottomMargin:35];
    __weak __typeof(headerView)weakSelf = headerView;
    headerView.didFinishAutoLayoutBlock=^(CGRect rect){
        weakSelf.sd_layout
        .heightIs(rect.size.height);
        [self.tableView setTableHeaderView:weakSelf];
    };
    
    
    return headerView;
}


-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.sectionHeaderHeight=44;
    tableView.tableFooterView=[UIView new];
    tableView.tableHeaderView=[self CreatTableViewHeaderView];
    tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _leftNameArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PurchaseDetailsCell *cell =[PurchaseDetailsCell cellWithTableView:tableView IndexPath:indexPath];
    cell.namelabel.text=_leftNameArr[indexPath.row];
    cell.contentlabel.text=[NSString stringWithFormat:@"第%lu行",indexPath.row];
    return cell;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    UILabel * namelabel=[UILabel new];
    namelabel.text=@"Product manual";
    namelabel.font=[UIFont systemFontOfSize:15];
    [view sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(view, 15)
    .centerYEqualToView(view)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:200];
    return view;
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
