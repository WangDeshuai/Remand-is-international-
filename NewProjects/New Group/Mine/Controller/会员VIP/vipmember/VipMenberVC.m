//
//  VipMenberVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/13.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "VipMenberVC.h"

@interface VipMenberVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong) UIImageView * imageview;
@property(nonatomic,assign) CGRect  imageRect;
@end

@implementation VipMenberVC
static const CGFloat headHeight =248;
static const CGFloat ratio =0.66;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"Buy membership";
    [self CreatBgImageView];
    [self CreatTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    // 设置导航栏背景透明(取值范围0~1)
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
#pragma mark ------------创建控件
//创建背景拉伸图
-(void)CreatBgImageView{
    _imageview =[UIImageView new];
    _imageview.image=[UIImage imageNamed:@"vip_bg"];
    _imageview.userInteractionEnabled=YES;
    _imageview.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth*ratio);
    _imageRect=_imageview.frame;
    [self.view addSubview:_imageview];
}
-(UIView*)CreatHeadView{
    UIView * headerview =[UIView new];
    headerview.backgroundColor=[UIColor clearColor];
    headerview.frame=CGRectMake(0, 0, ScreenWidth, headHeight);
    headerview.userInteractionEnabled=YES;
    
    return headerview;
}

-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=[UIColor clearColor];
    tableView.tableHeaderView=[self CreatHeadView];
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"第%lu行",indexPath.row];
    return cell;
    
}

#pragma mark -------ScrollViewDelegate--------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<headHeight) {//向上滑offsetY+
        CGFloat aipat =offsetY/headHeight;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:aipat];
    }else{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    }
    
    if (offsetY>0) {
        //往上移动
        _imageview.frame=({
            CGRect frame =_imageRect;
            frame.origin.y=_imageRect.origin.y-offsetY;
            frame;
        });
    }else
    {
        _imageview.frame=({
            CGRect frame=_imageRect;
            frame.size.height=_imageRect.size.height-offsetY;
            frame.size.width=frame.size.height/ratio;
            frame.origin.x=_imageRect.origin.x-(frame.size.width-_imageRect.size.width)/2;
            frame;
        });
    }
    
    
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
