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
@interface SearchVC ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UITextField * searchText;
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UICollectionView * collectionView;
@end

@implementation SearchVC
-(void)viewWillAppear:(BOOL)animated
{
      [self.navigationController.navigationBar addSubview:self.topView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.topView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backHomeBtn.hidden=YES;
    //导航条右边取消按钮
    [self CreatCancelBtn];
    //导航条左边选框
    [self CreatBtn];
    [self CreatTableView];
    [self CreatCollectionView];
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


-(void)CreatBtn{
    //search
    UIButton * searBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [searBtn setTitle:@"Purchase" forState:0];
    searBtn.backgroundColor=[UIColor clearColor];
    searBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [searBtn setImage:[UIImage imageNamed:@"home_search"] forState:0];
    searBtn.frame=CGRectMake(15, 0, 100, 35);
    [searBtn SG_imagePositionStyle:SGImagePositionStyleRight spacing:8];
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
    self.baseTableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    self.baseTableView.mj_header=nil;
    self.baseTableView.mj_footer=nil;
    self.baseTableView.rowHeight=44;
    [self.view addSubview:self.baseTableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text=@"1233";
    
    return cell;
}

-(void)CreatCollectionView{
    
    UICollectionViewFlowLayout * layout =[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing=1;//高间距
    layout.minimumInteritemSpacing=1;//宽间距
    layout.itemSize=CGSizeMake(ScreenWidth/2-1, 44);
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2, ScreenWidth, ScreenHeight/2) collectionViewLayout:layout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.alwaysBounceVertical = YES;
    //[UIColor whiteColor]
    _collectionView.backgroundColor=BG_COLOR;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[SearchCell class] forCellWithReuseIdentifier:@"cell"];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor whiteColor];
    cell.nameLable.text=[NSString stringWithFormat:@"%lu",indexPath.item];
    return cell;
    
}




#pragma mark ----网络请求热词
-(void)getReCi{
    [[Engine sharedEngine] BJPostWithUrl:Main_URL withAPIName:SearchApi_Search withParame:nil callback:^(id item) {
        
    } failedBlock:^(id error) {
        
    }];
}




#pragma mark ---按钮点击事件
-(void)rightButtonClick{
    [self.view endEditing:YES];
    [self getReCi];
}







-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
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
