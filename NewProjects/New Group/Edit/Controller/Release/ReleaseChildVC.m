//
//  ReleaseChildVC.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ReleaseChildVC.h"
#import "ReleaseChildCell.h"
#import "PhotoView.h" //获取照片view
#import "AddressView.h"//国家 时间轴 货币单位 view
#import "AreaView.h"//地区view (省市县)
#import "CommodityClassView.h"//(商品分类view)
@interface ReleaseChildVC ()<UITextFieldDelegate>
{
  /*
   1. name是名字----用来在界面展示用
   2. code是编码----用来传递给后台接口用
   */
    NSString * _className;//商品分类name
    NSString * _classCode;//商品分类code
    
    NSString * _proMone;//货币单位
    NSString * _proMoneCode;//货币单位code
    
    NSString * _countryName;//国家名字
    NSString * _countryCode;//国家code
    
    NSString * _addressName;//地区的name
    NSString * _addressCode;//地区的code
    
    NSString * _timeName;//时间名字
    NSString * _timeCode;//时间轴
    /********* -----------------******/
    NSString * _proName;//商品名字
    NSString * _proPrice;//商品价格
    NSString * _proInventory;//存货
    NSString * _proDecribe;//描述
    NSMutableArray * phtopArray;
  
}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)NSArray *nameArr;
@end

@implementation ReleaseChildVC
static int  heightView ;
- (void)viewDidLoad {
    [super viewDidLoad];
    heightView=ScreenHeight/3;
    self.view.backgroundColor=[UIColor whiteColor];
    NSLog(@">>>%@",_productType);
    [self CreatDataArr];
    [self CreatTabelView];
}
#pragma mark -------数据创建-----------
-(void)CreatDataArr{
//    _dataArray=@[@"Product name",@"Location",@"Inventory quantity(T)",@"Supply price($)",@"Package",@"Single package weight(kg)",@"Colour",@"Mesh",@"Density(%)",@"Calcium content(%)",@"Flammability",@"Image"];
    _timeCode=@"";
    _timeName=@"";
    _dataArray=@[@"Product name",@"Commodity class",@"Commodity prices",@"Inventory",@"Monetary unit",@"Describe",@"Country",@"Address",@"The failure time",@"Image"];
    //1.商品名称  2.位置  3.商品库存  4.商品价格 5.包装 6.单包重量 7.颜色 8.网孔 9.密度 10.含钙量 11.图片
}

-(void)CreatTabelView{
    self.baseTableView.frame=CGRectMake(0, Distance_Top+15+44, ScreenWidth, ScreenHeight-Distance_Top-15-44-Tabbar_Height);
    self.baseTableView.rowHeight=55;
    self.baseTableView.mj_header=nil;
    self.baseTableView.mj_footer=nil;
    self.baseTableView.backgroundColor=[UIColor whiteColor];
    self.baseTableView.tableFooterView=[self CreatFootView];
    self.baseTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.baseTableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReleaseChildCell * cell =[ReleaseChildCell cellWithTableView:tableView IndexPath:indexPath];
    cell.namelabel.text=_dataArray[indexPath.row];
    cell.textField.tag=indexPath.row;
    cell.textField.delegate=self;
    if (indexPath.row==1) {
        //商品分类
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
        cell.textField.text=_className;
    }else if (indexPath.row==4){
        //货币单位
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
        cell.textField.text=_proMone;
    }else if (indexPath.row==6){
        //国家
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
        cell.textField.text=_countryName;
    }else if (indexPath.row==7){
        //地区
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
        cell.textField.text=_addressName;
    }else if (indexPath.row==8){
        //失效时间
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
        cell.textField.text=[NSString stringWithFormat:@"%@  %@",_timeCode,_timeName];
    }
    return cell;
}

///表尾
-(UIView*)CreatFootView{
    UIView * footView =[UIView new];
    footView.backgroundColor=[UIColor whiteColor];
    footView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0);
    
    
    PhotoView * view =[[PhotoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120) MaxPhoto:8 EachRowNumber:4];
    view.photosArrBlock=^(NSArray *photosArr){
        NSLog(@"照片>>>%@",photosArr);
    };
    view.delegate=self;
    [footView addSubview:view];
    
  //120 + 35 +30 +10 +49
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.sd_cornerRadius=@(35/2);
    sureBtn.backgroundColor=Main_Color;
    [sureBtn setTitle:@"Release" forState:0];
    [sureBtn addTarget:self action:@selector(publicMessage) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [footView sd_addSubviews:@[sureBtn]];
    sureBtn.sd_layout
    .leftSpaceToView(footView, 30)
    .rightSpaceToView(footView, 30)
    .topSpaceToView(view, 30)
    .heightIs(35);

    [footView setupAutoHeightWithBottomView:sureBtn bottomMargin:10+Tabbar_Height];
    
    __weak __typeof(footView)weakSelf = footView;
    footView.didFinishAutoLayoutBlock=^(CGRect rect){
        weakSelf.sd_layout
        .heightIs(rect.size.height+Tabbar_Height);
        [self.baseTableView setTableFooterView:weakSelf];
    };


    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        //分类
        [self getClassFenLeiMessageData];
    }else if (indexPath.row==4){
        //货币单位
        [self getStockUnitsData];
    }else if (indexPath.row==6) {
        //国家
        [self getNationalData];
    }else if (indexPath.row==7){
        //地区
        [self getNationalAreaDataCode:_countryCode];
    }else if (indexPath.row==8){
        //失效时间
        [self getTheFailureTimeData];
    }
}



#pragma mark ----------网络请求--------

///获取分类信息数据
-(void)getClassFenLeiMessageData{
    
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] getwithUrl:@"http://111.198.24.20:8603/getCategoryEn" andParameter:nil withSuccessBlock:^(id item) {
        NSMutableArray * provinceArr=[item objectForKey:@"children"];
        [self tanKuangSeleateDataArray:provinceArr];
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
    } andprogressBlock:^(NSProgress *progress) {
        
    }];
}



///只获取国家数据
-(void)getNationalData{
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] getwithUrl:@"http://111.198.24.20:8603/areaEn" andParameter:nil withSuccessBlock:^(id item) {
        NSArray * array =item;
        [self tanKaungSeleateTitle:@"请选择国家" DataTitleArr:array Int:1];
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
    } andprogressBlock:^(NSProgress *progress) {
    }];
}

///根据国家code获取省市县地区数据
-(void)getNationalAreaDataCode:(NSString*)code{
    if ([[ToolClass isString:code] isEqualToString:@""]) {
        [LCProgressHUD showMessage:@"请先选择国家"];
        return;
    }
    [LCProgressHUD showLoading:Message_Loading];
    NSString *  urlStr =[NSString stringWithFormat:@"http://111.198.24.20:8603/areaEn/all/%@",[ToolClass isString:code]];
    [[Engine sharedEngine] getwithUrl:urlStr andParameter:nil withSuccessBlock:^(id item) {
        //省的数组
        NSMutableArray * provinceArr=[item objectForKey:@"areas"];
        [self tanKaungAreaViewDataArray:provinceArr];
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
    } andprogressBlock:^(NSProgress *progress) {
    }];
}

///失效时间
-(void)getTheFailureTimeData{
    NSArray * timeArr =@[@"三天",@"一周",@"半个月",@"一个月",@"两个月",@"三个月",@"半年",@"一年"];
    [self tanKaungSeleateTitle:@"请选择失效时间" DataTitleArr:timeArr Int:2];
}

///货币单位
-(void)getStockUnitsData{
    NSArray * timeArr =@[@"￥",@"$",@"€"];
    [self tanKaungSeleateTitle:@"请选择货币单位" DataTitleArr:timeArr Int:3];
}

#pragma mark --------弹框调用--------
///获取分类弹框调用
-(void)tanKuangSeleateDataArray:(NSMutableArray*)dataArr{
    CommodityClassView * view =[[CommodityClassView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, heightView) TitleName:@"选择分类" AndDataArr:dataArr];
    view.NameCodeBlock = ^(NSString *name, NSString *code) {
        _className=name;
        _classCode=code;
        [self.baseTableView reloadData];
    };
    [UIView animateWithDuration:animationTime animations:^{
        view.frame=CGRectMake(0, ScreenHeight-heightView, ScreenWidth,heightView);
        [view show];;
    } completion:^(BOOL finished) {
    }];
}

///获取国家弹框调用(tag==1代表国家  tag==2代表失效时间)
-(void)tanKaungSeleateTitle:(NSString*)name DataTitleArr:(NSArray*)dataArr Int:(int)tag{
//    int g=ScreenHeight/2;
    AddressView * view =[[AddressView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, heightView) TitleName:name AndDataArr:dataArr IntType:tag];
    view.ControlBlock = ^(NSString *name, NSString *code) {
        if (tag==1) {//国家
            _countryName=name;
            _countryCode=code;
        }else if(tag==2){//失效时间
            _timeName=name;
            _timeCode=code;
        }else{//货币单位
            _proMone=name;
            _proMoneCode=code;
        }
        
        [self.baseTableView reloadData];
    };
    [UIView animateWithDuration:animationTime animations:^{
        view.frame=CGRectMake(0, ScreenHeight-heightView, ScreenWidth, heightView);
        [view show];;
    } completion:^(BOOL finished) {
    }];
    
}

///获取省市县(地区)弹框调用
-(void)tanKaungAreaViewDataArray:(NSMutableArray*)dataArr
{
    AreaView * view =[[AreaView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, heightView) TitleName:@"选择省市县" AndDataArr:dataArr];
    view.NameCodeBlock = ^(NSString *name, NSString *code) {
        _addressName=name;
        _addressCode=code;
        [self.baseTableView reloadData];
    };
    [UIView animateWithDuration:animationTime animations:^{
        view.frame=CGRectMake(0, ScreenHeight-heightView, ScreenWidth,heightView);
        [view show];;
    } completion:^(BOOL finished) {
    }];
}



#pragma mark ----发布按钮点击事件
-(void)publicMessage{
    NSLog(@"商品的名字>>>%@>>>>",_proName);
    NSLog(@"商品分类>>%@ID=%@",_className,_classCode);
    NSLog(@"商品价格>>%@",_proPrice);
    NSLog(@"库存>>>%@",_proInventory);
    NSLog(@"单位名称>>>%@>>>>code=%@",_proMone,_proMoneCode);
    NSLog(@"描述>>>%@",_proDecribe);
    NSLog(@"国家>>%@>>>code=%@",_countryName,_countryCode);
    NSLog(@"地区>>>%@>>>code=%@",_addressName,_addressCode);
    NSLog(@"失效时间>>>%@>>>code=%@",_timeName,_timeCode);
}











#pragma mark ---textFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==0) {
        //公司名字
        _proName=textField.text;
    }else if (textField.tag==2){
        //公司价格
        _proPrice=textField.text;
    }else if (textField.tag==3){
        //存货量
        _proInventory=textField.text;
    }else if (textField.tag==5){
        //描述
        _proDecribe=textField.text;
    }
}





- (NSArray *)nameArr
{
    if (!_nameArr) {
        _nameArr = @[
                      @"productName",
                      @"productCategory",
        @"productArea",
        
        @"productDescribe",
        @"productType",
        @"expiryTime",
        @"productPriceWithoutTax",
        @"productStock",
       
        @"stockUnits"];
    }
    return _nameArr;
}
@end



