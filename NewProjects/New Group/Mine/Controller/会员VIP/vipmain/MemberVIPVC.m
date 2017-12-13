//
//  MemberVIPVC.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "MemberVIPVC.h"
#import "MemberVIPCell.h"
#import "VipMenberVC.h"
@interface MemberVIPVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong) UIImageView * imageview;
@property(nonatomic,assign) CGRect  imageRect;
@end

@implementation MemberVIPVC
static const CGFloat headHeight =248;
static const CGFloat ratio =0.66;
- (void)viewWillAppear:(BOOL)animated{
    // 设置导航栏背景透明(取值范围0~1)
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"Become member";
    [self CreatBgImageView];
    [self CreatTableView];
}

#pragma mark ------------创建控件
//创建背景拉伸图
-(void)CreatBgImageView{
    _imageview =[UIImageView new];
    _imageview.image=[UIImage imageNamed:@"privilege_bg"];
    _imageview.userInteractionEnabled=YES;
    _imageview.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth*ratio);
    _imageRect=_imageview.frame;
    [self.view addSubview:_imageview];
}
-(UIView*)CreatHeadView{
    UIView * bgImage =[UIView new];
    bgImage.backgroundColor=[UIColor clearColor];
    bgImage.frame=CGRectMake(0, 0, ScreenWidth, headHeight+20);
    bgImage.userInteractionEnabled=YES;
    
    
    //VIP圈
    UILabel * viplabel =[UILabel new];
    viplabel.backgroundColor=[UIColor whiteColor];
    viplabel.text=@"VIP";
    viplabel.textAlignment=1;
    viplabel.sd_cornerRadius=@(40);
    if (@available(iOS 8.2, *)) {
        viplabel.font=[UIFont systemFontOfSize:23 weight:.3];
    } else {
        // Fallback on earlier versions
    }
    viplabel.textColor=Main_Color;
    [bgImage sd_addSubviews:@[viplabel]];
    viplabel.sd_layout
    .centerXEqualToView(bgImage)
    .widthIs(80)
    .heightIs(80)
    .topSpaceToView(bgImage, 20+64);


    //名字
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"Join membership";
    namelabel.textColor=[UIColor whiteColor];
    if (@available(iOS 8.2, *)) {
        namelabel.font=[UIFont systemFontOfSize:17 weight:.3];
    } else {
    }
    [bgImage sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .topSpaceToView(viplabel, 10)
    .centerXEqualToView(viplabel)
    .heightIs(15);
    [namelabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];

    //副标题(名字下面label)
    UILabel * namelabel2=[UILabel new];
    namelabel2.text=@"Have more privileges";
    namelabel2.textColor=[[UIColor whiteColor]colorWithAlphaComponent:.5];
    if (@available(iOS 8.2, *)) {
        namelabel2.font=[UIFont systemFontOfSize:15 weight:.3];
    } else {
    }
    [bgImage sd_addSubviews:@[namelabel2]];
    namelabel2.sd_layout
    .topSpaceToView(namelabel, 5)
    .centerXEqualToView(viplabel)
    .heightIs(20);
    [namelabel2 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];


    NSArray * arrBtn =@[@"membervip_people",@"membervip_vip"];
    NSArray * titleBtn =@[@"VIP member",@"Gold supplier"];
    int d=15;
    int k= (ScreenWidth-d*3)/2;
    int g=k*223/349;
    UIButton * btn=nil;
    for (int i =0; i<arrBtn.count; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor whiteColor];
        button.frame=CGRectMake(d+(k+d)*i, 182-25, k, g);//182是背景图片-15是覆盖15
        button.layer.cornerRadius=15;
        button.tag=i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.clipsToBounds=YES;
        [button setImage:[UIImage imageNamed:arrBtn[i]] forState:0];
        button.titleLabel.font=[UIFont systemFontOfSize:17];
        [button setTitle:titleBtn[i] forState:0];
        [button SG_imagePositionStyle:SGImagePositionStyleTop spacing:10];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [bgImage addSubview:button];
        button.sd_layout.topSpaceToView(namelabel2, 35)
        .heightIs(g)
        .widthIs(k)
        .leftSpaceToView(bgImage, d+(k+d)*i);
        
        
        btn=button;

    }

    [bgImage setupAutoHeightWithBottomView:btn bottomMargin:0];


    __weak __typeof(bgImage)weakSelf =bgImage;  bgImage.didFinishAutoLayoutBlock=^(CGRect rect){
        weakSelf.sd_layout
        .heightIs(rect.size.height);
        [self.tableView setTableHeaderView:weakSelf];
    };
    
    
    
    
    return bgImage;
}



-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=[UIColor clearColor];
    tableView.tableHeaderView=[self CreatHeadView];
    [self.view addSubview:tableView];
    
}
#pragma mark ---------表视图代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberVIPCell * cell=[MemberVIPCell cellWithTableView:tableView IndexPath:indexPath];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:[ToolClass cellContentViewWith] tableView:tableView];
}


#pragma mark ----按钮点击事件----
-(void)buttonClick:(UIButton*)btn{
    NSLog(@"点击按钮了");
    if (btn.tag==0) {
        VipMenberVC * vc =[VipMenberVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
    }
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
