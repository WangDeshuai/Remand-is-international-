//
//  ReleaseChildVC.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ReleaseChildVC.h"
#import "ReleaseChildCell.h"
#import "PhotoView.h"
#import "AddressView.h"//国家
#import "AreaView.h"
#import "CommodityClassView.h"
@interface ReleaseChildVC ()
{
    NSString * _countryCode;//国家code
    NSString * _countryName;//国家名字
    NSString * _addressName;//地区的name
    NSString * _addressCode;//地区的code

    

}
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation ReleaseChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self CreatDataArr];
    [self CreatTabelView];
}

-(void)CreatDataArr{
//    _dataArray=@[@"Product name",@"Location",@"Inventory quantity(T)",@"Supply price($)",@"Package",@"Single package weight(kg)",@"Colour",@"Mesh",@"Density(%)",@"Calcium content(%)",@"Flammability",@"Image"];
    _dataArray=@[@"Product name",@"Commodity class",@"Commodity prices",@"Inventory",@"Monetary unit",@"Describe",@"Country",@"Address",@"The failure time",@"Image"];
    //1.商品名称  2.位置  3.商品库存  4.商品价格 5.包装 6.单包重量 7.颜色 8.网孔 9.密度 10.含钙量 11.图片
}

-(void)CreatTabelView{
//
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
    if (indexPath.row==1) {
        cell.arrowBtn.hidden=NO;
         cell.textField.enabled=NO;
       
    }else if (indexPath.row==6){
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
         cell.textField.text=_countryName;
    }else if (indexPath.row==7){
        cell.arrowBtn.hidden=NO;
        cell.textField.enabled=NO;
        cell.textField.text=_addressName;
    }
    return cell;
}


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
        NSLog(@">>>%f",rect.size.height);
        [self.baseTableView setTableFooterView:weakSelf];
    };


    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        //分类
        [self getClassFenLeiMessageData];
    }  else if (indexPath.row==6) {
        //国家
        [self getNationalData];
    }else if (indexPath.row==7){
        //地区
        [self getNationalAreaDataCode:_countryCode];
    }
}
#pragma mark ---获取国家
-(void)getNationalData{
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] getwithUrl:@"http://111.198.24.20:8603/areaEn" andParameter:nil withSuccessBlock:^(id item) {
        NSArray * array =item;
        [self tanKaungSeleateTitle:@"请选择国家" DataTitleArr:array Int:0];
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
    } andprogressBlock:^(NSProgress *progress) {
    }];
}

#pragma mark ---获取省市县
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
        int g=ScreenHeight/2;
        AreaView * view =[[AreaView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, g) TitleName:@"选择省市县" AndDataArr:provinceArr];
        view.NameCodeBlock = ^(NSString *name, NSString *code) {
            _addressName=name;
            _addressCode=code;
            [self.baseTableView reloadData];
        };
        [UIView animateWithDuration:animationTime animations:^{
            view.frame=CGRectMake(0, ScreenHeight-g, ScreenWidth, g);
            [view show];;
        } completion:^(BOOL finished) {
        }];
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
    } andprogressBlock:^(NSProgress *progress) {
    }];
}

#pragma mark ---获取分类信息
-(void)getClassFenLeiMessageData{
    
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] getwithUrl:@"http://111.198.24.20:8603/getCategoryEn" andParameter:nil withSuccessBlock:^(id item) {
//        CommodityClassView
        
         NSMutableArray * provinceArr=[item objectForKey:@"children"];
        int g=ScreenHeight/2;
        CommodityClassView * view =[[CommodityClassView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, g) TitleName:@"选择分类" AndDataArr:provinceArr];
        view.NameCodeBlock = ^(NSString *name, NSString *code) {
//            _addressName=name;
//            _addressCode=code;
//            [self.baseTableView reloadData];
        };
        [UIView animateWithDuration:animationTime animations:^{
            view.frame=CGRectMake(0, ScreenHeight-g, ScreenWidth, g);
            [view show];;
        } completion:^(BOOL finished) {
        }];
        
        [LCProgressHUD hide];
    } andFailBlock:^(NSError *error) {
        
    } andprogressBlock:^(NSProgress *progress) {
        
    }];
}





#pragma mark --弹框调用
-(void)tanKaungSeleateTitle:(NSString*)name DataTitleArr:(NSArray*)dataArr Int:(int)tag{
    int g=ScreenHeight/2;
    AddressView * view =[[AddressView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, g) TitleName:name AndDataArr:dataArr];
    view.ControlBlock = ^(NSString *name, NSString *code) {
        _countryName=name;
        _countryCode=code;
        [self.baseTableView reloadData];
    };
    [UIView animateWithDuration:animationTime animations:^{
        view.frame=CGRectMake(0, ScreenHeight-g, ScreenWidth, g);
        [view show];;
    } completion:^(BOOL finished) {
    }];
    
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
