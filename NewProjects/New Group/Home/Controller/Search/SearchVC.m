//
//  SearchVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/15.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "SearchVC.h"
#import "SearchModel.h"
#import "SearchCell.h"
#import "SearchTabCell.h"
#import "EditVC.h"
#import "SearchView.h"
#import "EditVC.h"
@interface SearchVC ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UITextField * searchText;
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)SearchModel * searchModel;
@property(nonatomic,copy)NSString * datatype;
@end

@implementation SearchVC
-(void)viewWillAppear:(BOOL)animated
{
      [self.navigationController.navigationBar addSubview:self.topView];
    //网络请求加载数据
    [self getReCi];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.topView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backHomeBtn.hidden=YES;
    _datatype=@"1";
    //导航条右边取消按钮
    [self CreatCancelBtn];
    //导航条左边选框
    [self CreatBtn];
    //加载tableView
    [self CreatTableView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----创建控件
-(UIView*)topView{
    if (!_topView) {
        _topView=[UIView new];
        _topView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.3];
        _topView.frame=CGRectMake(10, 3, ScreenWidth-20-60, 35);
        _topView.layer.cornerRadius=35/2;
        _topView.clipsToBounds=YES;
    }
    
    return _topView;
}

#pragma mark ------控件加载-----
-(void)CreatBtn{
    //search
    UIButton * searBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [searBtn setTitle:@"Supply" forState:0];
    searBtn.backgroundColor=[UIColor clearColor];
    searBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [searBtn setImage:[UIImage imageNamed:@"home_search"] forState:0];
    searBtn.frame=CGRectMake(15, 0, 100, 35);
    [searBtn SG_imagePositionStyle:SGImagePositionStyleRight spacing:8];
    [searBtn addTarget:self action:@selector(searBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:searBtn];
    //line
    UIView * lineView =[UIView new];
    lineView.backgroundColor=Main_Color;
    [self.topView sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(searBtn, 0)
    .widthIs(1)
    .topSpaceToView(self.topView, 0)
    .bottomSpaceToView(self.topView, 0);
    //textView
    
    [self.topView addSubview:self.searchText];
    
}

//创建搜索框
-(UITextField*)searchText
{
    if (!_searchText) {
        _searchText=[UITextField new];
        _searchText.delegate=self;
        _searchText.placeholder=@"Waste particles";
        _searchText.frame=CGRectMake(120, 0, ScreenWidth-50, 35);
        _searchText.returnKeyType=UIReturnKeySearch;
        _searchText.leftView=[ToolClass imageViewNameStr:@"search"];
        _searchText.placeholderColor=[UIColor whiteColor];
        _searchText.cursorColor=[UIColor whiteColor];
        _searchText.textColor=[UIColor whiteColor];
        _searchText.leftViewMode=UITextFieldViewModeAlways;
    }
    return _searchText;
}

///搜索按钮
-(void)CreatCancelBtn{
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(0.0, 0.0, 60.0, 44.0)];
    [cancelBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.backgroundColor=[UIColor clearColor];
    [cancelBtn setTitle:@"Cancle" forState:0];
    //修改方法
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    [view addSubview:cancelBtn];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}

-(void)CreatTableView{
    self.baseTableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.baseTableView.mj_header=nil;
    self.baseTableView.mj_footer=nil;
    self.baseTableView.rowHeight=44;
    self.baseTableView.tableFooterView=[self CreatFootView];
    self.baseTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.baseTableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchModel.records.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTabCell * cell =[SearchTabCell cellWithTableView:tableView IndexPath:indexPath];
    NSDictionary * dic =_searchModel.records[indexPath.row];
    cell.nameLabel.text=[ToolClass base64Decode:[dic objectForKey:@"word"]];
    cell.cancelBtn.tag=indexPath.row;
    [cell.cancelBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EditVC * vc =[EditVC new];
    vc.tagg=[_datatype intValue]-1;
    NSDictionary * dic =_searchModel.records[indexPath.row];
    vc.keyWord=[ToolClass base64EncodedString:[ToolClass base64Decode:[dic objectForKey:@"word"]]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---区尾(清空历史记录)
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section

{
    UIView * view =[UIView new];
    view.backgroundColor=[UIColor whiteColor];

    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Full search history" forState:0];
    [btn addTarget:self action:@selector(btnAllClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.titleLabel.alpha=.6;
    [view sd_addSubviews:@[btn]];
    btn.sd_layout
    .leftSpaceToView(view, 0)
    .rightSpaceToView(view, 0)
    .topSpaceToView(view, 0)
    .bottomSpaceToView(view, 0);
    
   
    return view;

}



#pragma mark ----表尾(collectionView)
-(UIView*)CreatFootView{
    UIView * bgView =[UIView new];
    bgView.backgroundColor=[UIColor clearColor];
    bgView.frame=CGRectMake(0, 0, ScreenWidth, 500);
    //footView
    UIView  * footView =[UIView new];
     footView.backgroundColor=[UIColor whiteColor];
    [bgView sd_addSubviews:@[footView]];
    footView.sd_layout
    .leftSpaceToView(bgView, 0)
    .rightSpaceToView(bgView, 0)
    .topSpaceToView(bgView, 20)
    .bottomSpaceToView(bgView, 0);
    //热门按钮
    UIButton * remenBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [remenBtn setImage:[UIImage imageNamed:@"search_remen"] forState:0];
    [remenBtn setTitle:@"Hot words" forState:0];
    [remenBtn setTitleColor:[UIColor blackColor] forState:0];
    remenBtn.frame=CGRectMake(15, 0, ScreenWidth-30, 44);
    if (@available(iOS 8.2, *)) {
        remenBtn.titleLabel.font=[UIFont systemFontOfSize:15 weight:.2];
    } else {
        // Fallback on earlier versions
    }
    remenBtn.contentHorizontalAlignment=1;
    [remenBtn SG_imagePositionStyle:SGImagePositionStyleDefault spacing:8];
    [footView addSubview:remenBtn];
    //线条
    UIView * lineView =[UIView new];
    lineView.backgroundColor=BG_COLOR;
    [footView sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(footView, 0)
    .rightSpaceToView(footView, 0)
    .topSpaceToView(footView, 43)
    .heightIs(1);
    
    
    
    [self CreatCollectionView:footView];
    
    
    return bgView;
}








-(void)CreatCollectionView:(UIView*)bgView{
    
    UICollectionViewFlowLayout * layout =[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing=1;//高间距
    layout.minimumInteritemSpacing=1;//宽间距
    layout.itemSize=CGSizeMake(ScreenWidth/2-1, 45);
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
//    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor=BG_COLOR;
//    [bgView addSubview:_collectionView];
    [bgView sd_addSubviews:@[_collectionView]];
    _collectionView.sd_layout
    .leftSpaceToView(bgView, 0)
    .rightSpaceToView(bgView, 0)
    .topSpaceToView(bgView, 44)
    .bottomSpaceToView(bgView, 0);
    
    
    
    [_collectionView registerClass:[SearchCell class] forCellWithReuseIdentifier:@"cell"];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _searchModel.hotWords.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor whiteColor];
    
    cell.nameLable.text=_searchModel.hotWords[indexPath.item];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>>%lu",indexPath.item);
    EditVC * vc =[EditVC new];
    vc.tagg=[_datatype intValue]-1;
    vc.keyWord=[ToolClass base64EncodedString:_searchModel.hotWords[indexPath.item]];
    [self.navigationController pushViewController:vc animated:YES];
}





#pragma mark ----网络请求热词
//获取热词和搜索记录
-(void)getReCi{
    [LCProgressHUD showLoading:Message_Loading];
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:SearchApi_Record withParame:nil callback:^(id item) {
        SearchModel * model =[SearchModel modelObjectWithDictionary:item];
        if (model.resultCode==1) {
            _searchModel=model;
            if (_searchModel.records.count==0) {
                  self.baseTableView.sectionFooterHeight=0;
            }else{
                  self.baseTableView.sectionFooterHeight=44;
            }
            [self.baseTableView reloadData];
            [self.collectionView reloadData];
            [LCProgressHUD hide];
        }else{
            [LCProgressHUD showMessage:model.resultMessage];
        }
        
    } failedBlock:^(id error) {
        
    }];
}

//搜索框搜索
-(void)searchTextName:(NSString*)textfield{
    [LCProgressHUD showLoading:Message_Loading];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass base64EncodedString:textfield] forKey:@"keyWord"];
    [dic setObject:_datatype forKey:@"datatype"];
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:SearchApi_Search withParame:dic callback:^(id item) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
        
        if ([code isEqualToString:@"1"]) {
            EditVC * vc =[EditVC new];
            vc.tagg=[_datatype intValue]-1;
            vc.keyWord=[ToolClass base64EncodedString:textfield];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
        }

        
            [LCProgressHUD hide];
    } failedBlock:^(id error) {
        
    }];
}

//删除
-(void)deleteID:(NSString*)idd{
    [LCProgressHUD showLoading:Message_Loading];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:idd forKey:@"id"];
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:SearchApi_Delete withParame:dic callback:^(id item) {
//        NSString * code =[NSString stringWithFormat:@"%@",[item objectForKey:@"resultCode"]];
//        if ([code isEqualToString:@"1"]) {
//        }else{
//
//        }
        [LCProgressHUD hide];
    } failedBlock:^(id error) {
        
    }];
}



#pragma mark ---按钮点击事件
//搜索框取消
-(void)rightButtonClick{
//    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//删除按钮(每个)
-(void)deleteBtnClick:(UIButton*)btn{
    NSDictionary * dic =_searchModel.records[btn.tag];
    NSString * nameId =[dic objectForKey:@"uid"];
    
    [self deleteID:nameId];
    [_searchModel.records removeObjectAtIndex:btn.tag];
    [self.baseTableView reloadData];
}

//删除所有的
-(void)btnAllClick{
    [self deleteID:@""];
}

//采购还是供应
-(void)searBtnClick:(UIButton*)btn{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[btn convertRect:btn.bounds toView:window];
    SearchView * view =[[SearchView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect),  CGRectGetMaxY(rect),CGRectGetWidth(btn.frame),120) DataArr:@[@"Supply",@"Purchase"]];
    view.NameTypeBlock = ^(NSString *type, NSString *name) {
        [btn setTitle:name forState:0];
        _datatype=type;
         [btn SG_imagePositionStyle:SGImagePositionStyleRight spacing:8];
    };
    [view show];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [self searchTextName:[ToolClass isString:textField.text]];
    return YES;
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
