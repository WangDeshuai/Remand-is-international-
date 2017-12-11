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
#import "UITextField+PlaceholderColor.h"
#import "UIButton+SGImagePosition.h"
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation HomeVC
- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
//     [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
//
//    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backHomeBtn.hidden=YES;
//    self.automaticallyAdjustsScrollViewInsets=NO;
    [self CreatTextField];
    [self CreatTabelView];
   
}
#pragma mark ---创建控件
//创建搜索框
-(void)CreatTextField{
    UITextField * navTextField =[UITextField new];
    navTextField.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.2];
    navTextField.placeholder=@"Waste particles";
    navTextField.frame=CGRectMake(15, 0, ScreenWidth-30, 35);
    navTextField.layer.cornerRadius=35/2;
    navTextField.clipsToBounds=YES;
    navTextField.leftView=[ToolClass imageViewNameStr:@"search"];
    navTextField.placeholderColor=[UIColor whiteColor];
    navTextField.cursorColor=[UIColor whiteColor];
    navTextField.textColor=[UIColor whiteColor];
    navTextField.leftViewMode=UITextFieldViewModeAlways;
    [self.navigationController.navigationBar addSubview:navTextField];
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
        [self.tableView setTableHeaderView:weakSelf];
    };
    
    
    return headerView;
}

//创建tableView
-(void)CreatTabelView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-53) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.rowHeight=70;
    tableView.tableFooterView=[UIView new];
    tableView.tableHeaderView=[self CreatTabelViewHeader];
    tableView.backgroundColor=BG_COLOR;
    [self.view addSubview:tableView];
}

#pragma mark ---tableViewDataSoure  tableViewDeleget
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell * cell =[HomeCell cellWithTableView:tableView IndexPath:indexPath];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY>=0) {
//         [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:offsetY/64];
//    }else{
//         [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
//    }
    
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
