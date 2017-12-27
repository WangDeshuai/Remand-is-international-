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
#import "ReleaseModel.h"
@interface ReleaseChildVC ()<UITextFieldDelegate>
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)NSArray * nameArr;
@property(nonatomic,strong)PhotoView *photoView;
@property(nonatomic,strong)ReleaseModel *dataModel;
@end

@implementation ReleaseChildVC
static int  heightView ;
- (id)initWithModel:(ReleaseModel *)mode
{
    self = [self init];
    if (self) {
        self.dataModel = mode;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.dataModel) {
        _dataModel = [[ReleaseModel alloc]init];
    }
    heightView=ScreenHeight/3;
    self.view.backgroundColor=[UIColor whiteColor];
    NSLog(@">>>%@",_productType);
    [self CreatDataArr];
    [self CreatTabelView];
}
#pragma mark -------数据创建-----------
-(void)CreatDataArr{
//    _dataArray=@[@"Product name",@"Location",@"Inventory quantity(T)",@"Supply price($)",@"Package",@"Single package weight(kg)",@"Colour",@"Mesh",@"Density(%)",@"Calcium content(%)",@"Flammability",@"Image"];
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
    if (![[self.dataModel valueForKey:self.nameArr[indexPath.row]] isKindOfClass:[NSArray class]]) {
        cell.textField.text = [self.dataModel valueForKey:self.nameArr[indexPath.row]];  //取出Model属性值
    }
    if (indexPath.row==1) {
        //商品分类
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
    }else if (indexPath.row==4){
        //货币单位
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
    }else if (indexPath.row==6){
        //国家
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
    }else if (indexPath.row==7){
        //地区
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
    }else if (indexPath.row==8){
        //失效时间
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
//        cell.textField.text=[NSString stringWithFormat:@"%@  %@",_timeCode,_timeName];
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
        self.dataModel.image = photosArr;
    };
    view.selectedPhotos = [NSMutableArray arrayWithArray:self.dataModel.image];
    view.delegate=self;
    _photoView = view;
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
        [self getNationalAreaDataCode:self.dataModel.CountryCode];
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
        self.dataModel.productCategory = code;
        self.dataModel.productCategoryName = name;
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
            self.dataModel.Country = name;
            self.dataModel.CountryCode = code;
            self.dataModel.productAreaName = @"";
            self.dataModel.productArea = @"";
        }else if(tag==2){//失效时间
            self.dataModel.expiryTime = code;
        }else{//货币单位
            self.dataModel.stockUnits = code;
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
        self.dataModel.productArea = code;
        self.dataModel.productAreaName = name;
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
    [self.view endEditing:YES];
    __block BOOL sendBool = YES;
    NSMutableDictionary *parame = [NSMutableDictionary dictionaryWithDictionary:[self.dataModel dictionaryRepresentation]];
    if ([self.productType length]) {
        [parame setValue:self.productType forKey:@"productType"];
    }
    [self.nameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@"image"] && (![parame objectForKey:obj] || ![[parame objectForKey:obj] length])) {  //摘出image
            [LCProgressHUD showMessage:[NSString stringWithFormat:@"%@ Can't be empty",self.dataArray[idx]]];
            sendBool = NO;
            *stop = YES;
        }
    }];
    if (self.dataModel.image.count<2) {
        [LCProgressHUD showMessage:@"至少上传2张图片"];
        return;
    }
    if (sendBool) {
        [[Engine sharedEngine]BJPostWithUrl:Main_URL withAPIName:UserProductAddOrEditAppEn withParame:parame callback:^(id item) {
            if ([item[@"resultCode"] integerValue] == 1) {
                [LCProgressHUD showSuccess:@"发布成功"];
                self.dataModel = [[ReleaseModel alloc]init];
                self.photoView.selectedPhotos =[NSMutableArray array];  //删除页面图片
                [self.baseTableView reloadData];
                if (self.navigationController.viewControllers) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [LCProgressHUD showMessage:item[@"resultMessage"]];
            }
        } failedBlock:^(id error) {
            
        }];
    }
    
}
#pragma mark ---textFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==0) {
        //公司名字
        self.dataModel.productName = textField.text;
    }else if (textField.tag==2){
        //公司价格
        self.dataModel.productPriceWithoutTax = textField.text;
    }else if (textField.tag==3){
        //存货量
        self.dataModel.productStock = textField.text;
    }else if (textField.tag==5){
        //描述
        self.dataModel.productDescribe = textField.text;
    }
}
- (NSArray *)nameArr
{
    if (!_nameArr) {
        _nameArr = @[
                     @"productName",
                     @"productCategoryName",
                     @"productPriceWithoutTax",
                     @"productStock",
                     @"stockUnitsName",
                     @"productDescribe",
                     @"Country",
                     @"productAreaName",
                     @"expiryTime",
                     @"image"];
    }
    return _nameArr;
}
@end



