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
#import "PurchaseModel.h"

@interface PurchaseDetailsVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray * leftNameArr;
@property (nonatomic,assign)BOOL showHiden;//yes是隐藏 NO是显示
@property (nonatomic,strong)PurchaseModel * purchModel;
@property(nonatomic,strong)NSMutableArray  *dataArray;;
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel  *timeLabel;
@end

@implementation PurchaseDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Purchase details";
    _showHiden=YES;
    
    [self CreatDataArr];
    [self CreatBottomView];
    [self CreatTableView];
}

//底部按钮
-(void)CreatBottomView{
    UIButton * bottomView =[UIButton buttonWithType:UIButtonTypeCustom];
    bottomView.backgroundColor=Main_Color;
    [bottomView addTarget:self action:@selector(bottomViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView setTitle:@"View contact information" forState:0];
    [self.view sd_addSubviews:@[bottomView]];
    bottomView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(53);
    
}



-(void)CreatDataArr{
    _leftNameArr=[[NSMutableArray alloc]initWithObjects:@"Notice number",@"Location",@"Inventory quantity",@"Price",@"Single package weight",@"Processing raw materials",@"Colour",@"Mesh",@"Density",@"Calcum content",@"Flammability", nil];

   
    /*
    1.编号 productCode 2.地址 productArea 3.存货重量productStock 4.价格productPriceWithoutTax
     5.重量singlePackWeight 6.处理原材料productMaterial 7.颜色productColour 8.网孔 meshNumberLook 9.密度 productDensityValue 10.钙calciumContent  11可燃性 combustion
     
    */
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
    _nameLabel=titleLabel;
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
    _timeLabel=timeLabel;
    timeLabel.font=[UIFont systemFontOfSize:15];
    timeLabel.text=@"January 14,2018";
    [headerView sd_addSubviews:@[timeLabel]];
    timeLabel.sd_layout
    .leftEqualToView(titleLabel)
    .heightIs(20)
    .topSpaceToView(titleLabel, 10);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:300];
   


    SDCycleScrollView* cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@""]];
    _cycleScrollView=cycleScrollView;
    cycleScrollView.backgroundColor=BG_COLOR;
    cycleScrollView.pageControlBottomOffset=-35;
    cycleScrollView.currentPageDotColor=Main_Color;
    cycleScrollView.pageDotColor=[Main_Color colorWithAlphaComponent:.5];

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
        [self.baseTableView setTableHeaderView:weakSelf];
    };
    
    
    return headerView;
}


-(void)CreatTableView{
    self.baseTableView.frame=CGRectMake(0, 64, ScreenWidth, ScreenHeight-53-64);
    self.baseTableView.sectionHeaderHeight=44;
    self.baseTableView.tableFooterView=[UIView new];
    self.baseTableView.mj_footer=nil;
    self.baseTableView.rowHeight=50;
    self.baseTableView.tableHeaderView=[self CreatTableViewHeaderView];
    self.baseTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.baseTableView];
    [self.baseTableView.mj_header beginRefreshing];
}
-(void)mjHeaderRefresh
{
    [self networkRequestParameters];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   //_showHiden?4:_leftNameArr.count;
    return _leftNameArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PurchaseDetailsCell *cell =[PurchaseDetailsCell cellWithTableView:tableView IndexPath:indexPath];
    cell.namelabel.text=_leftNameArr[indexPath.row];
    cell.contentlabel.text=_dataArray[indexPath.row];
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


#pragma mark ---网络请求参数
///详情页参数
-(void)networkRequestParameters{
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:FirstApi_Particulars withParame:@{@"code":_codeText} callback:^(id item) {
        _purchModel=[[PurchaseModel alloc]initWithDictionary:item];
        //标题
        _nameLabel.text=_purchModel.productName;
        //时间
        _timeLabel.text=_purchModel.releaseTime;
       //轮播
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _cycleScrollView.imageURLStringsGroup = _purchModel.image;
        });
        //内容
        
         _dataArray=[NSMutableArray array];;
        [_dataArray addObject:[NSString stringWithFormat:@"%@",_purchModel.productCode]];
        [_dataArray addObject:[NSString stringWithFormat:@"%@",_purchModel.productArea]];
        [_dataArray addObject:[NSString stringWithFormat:@"%.2f tons",_purchModel.productStock]];
        [_dataArray addObject:[NSString stringWithFormat:@"%.2f dollars",_purchModel.productPriceWithoutTax]];
        [_dataArray addObject:[NSString stringWithFormat:@"%.2fkg per bag",_purchModel.singlePackWeight]];
        [_dataArray addObject:[NSString stringWithFormat:@"%@",_purchModel.productMaterial]];
        [_dataArray addObject:[NSString stringWithFormat:@"%@",_purchModel.productColour]];
        [_dataArray addObject:[NSString stringWithFormat:@"%@",_purchModel.meshNumberLook]];
        [_dataArray addObject:[NSString stringWithFormat:@"%@",_purchModel.productDensityValue]];
        [_dataArray addObject:[NSString stringWithFormat:@"%@",_purchModel.calciumContent]];
        [_dataArray addObject:[NSString stringWithFormat:@"%@",_purchModel.combustion]];
        [self.baseTableView reloadData];
        [self.baseTableView.mj_header endRefreshing];
        [LCProgressHUD hide];
    } failedBlock:^(id error) {

    }];
    
}
///查看特权数量
-(void)Checkthenumberofprivileges{
    
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:FirstApi_Privilege withParame:nil callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        
        if ([code isEqualToString:@"1"]) {
            NSString * message=nil;
            int tagg=0;
            if ([[item objectForKey:@"tq"] isEqualToString:@"0"]) {
                //没有特权
                
                if ([[item objectForKey:@"vipType"] isEqualToString:@"free"]) {
                    //免费会员 无特权
                    message =@"您当前是没有特权,不能查看联系方式,可联系客服或者直接购买会员服务,开通权限?";
                    tagg=0;
                }else{
                    //会员 特权数0
                    message=@"您当前特权数目不足,请购买特权,是否前往购买?";
                    tagg=1;
                }

            }else{
                //有特权数
                message=[NSString stringWithFormat:@"您当前特权剩余数是%@,查看特权会扣除特权数-1",[item objectForKey:@"tq"]];
                tagg=2;
            }
           
            [self CreatAlertView:message Int:tagg];
        }else{
            [LCProgressHUD showMessage:[item objectForKey:@"resultMessage"]];
        }

        [LCProgressHUD hide];
    } failedBlock:^(id error) {
        
    }];
}

///查看联系方式
-(void)ChanKanPhoneAddContent{
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:FirstApi_Phone withParame:@{@"code":_codeText} callback:^(id item) {
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        if ([code isEqualToString:@"1"]) {
            [_leftNameArr addObject:@"Phone"];
            [_leftNameArr addObject:@"Address"];
            [_leftNameArr addObject:@"StandbyTelephone"];
            [_leftNameArr addObject:@"Name"];
            [_leftNameArr addObject:@"Contacts"];
            [_dataArray addObject:[NSString stringWithFormat:@"%@",[item objectForKey:@"phone"]]];
            [_dataArray addObject:[NSString stringWithFormat:@"%@",[item objectForKey:@"address"]]];
            [_dataArray addObject:[NSString stringWithFormat:@"%@",[item objectForKey:@"standbyTelephone"]]];
            [_dataArray addObject:[NSString stringWithFormat:@"%@",[item objectForKey:@"name"]]];
            [_dataArray addObject:[NSString stringWithFormat:@"%@",[item objectForKey:@"contacts"]]];
            [self.baseTableView reloadData];
            [self.baseTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_leftNameArr.count-1 inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            [LCProgressHUD hide];
        }else{
            [LCProgressHUD showFailure:[item objectForKey:@"resultMessage"]];
        }

    } failedBlock:^(id error) {
        
    }];
}

#pragma mark ------按钮点击事件
-(void)bottomViewBtnClick{
    [self Checkthenumberofprivileges];
}

-(void)CreatAlertView:(NSString*)message Int:(int)tag{
    UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:1];
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (tag==0) {
            //无特权
            //跳转购买会员界面
        }else if (tag==1){
            //有会员 特权数0
            //跳转购买特权界面
        }else{
            // 有特权数
            [self ChanKanPhoneAddContent];
        }
            
    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionView addAction:action2];
    [actionView addAction:action1];
    [self presentViewController:actionView animated:YES completion:nil];
    
    
    
    
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
