//
//  ReleaseChildVC.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ReleaseChildVC.h"
#import "ReleaseChildCell.h"
@interface ReleaseChildVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation ReleaseChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self CreatDataArr];
    [self CreatTabelView];
}

-(void)CreatDataArr{
    _dataArray=@[@"Product name",@"Location",@"Inventory quantity(T)",@"Supply price($)",@"Package",@"Single package weight(kg)",@"Colour",@"Mesh",@"Density(%)",@"Calcium content(%)",@"Flammability",@"Image"];
}

-(void)CreatTabelView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, ScreenWidth, ScreenHeight-64-44) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.rowHeight=50;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tableFooterView=[self CreatFootView];
    tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReleaseChildCell * cell =[ReleaseChildCell cellWithTableView:tableView IndexPath:indexPath];
    cell.namelabel.text=_dataArray[indexPath.row];
    return cell;
}


-(UIView*)CreatFootView{
    UIView * footView =[UIView new];
    footView.backgroundColor=[UIColor whiteColor];
    footView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(200);
    
    NSArray * btnArr =@[@"Release",@"Cancel"];
    int d =15;
    int k =(ScreenWidth-d*2);
    int g=35;
    for (int i =0; i<btnArr.count; i++) {
        UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.sd_cornerRadius=@(g/2);
        [sureBtn setTitle:btnArr[i] forState:0];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [footView sd_addSubviews:@[sureBtn]];
        sureBtn.sd_layout
        .leftSpaceToView(footView, d)
        .rightSpaceToView(footView, d)
        .topSpaceToView(footView, 30+(d+g)*i)
        .widthIs(k)
        .heightIs(g);
        if (i==0) {
            sureBtn.backgroundColor=Main_Color;
        }else{
            sureBtn.backgroundColor=[UIColor whiteColor];
            sureBtn.layer.borderColor=[[UIColor lightGrayColor]colorWithAlphaComponent:.4].CGColor;
            sureBtn.layer.borderWidth=.5;
            [sureBtn setTitleColor:[[UIColor lightGrayColor]colorWithAlphaComponent:.7] forState:0];
        }
        
    }
    
    return footView;
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
