//
//  BaseTabbarController.m
//  Notepad
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "HomeVC.h"
#import "ReleaseMainVC.h"
#import "MineVC.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
  
    
    
    [self CreatTabbar];
}


-(void)CreatTabbar{
    //1. 初始化3个视图控制器
    HomeVC * vc1 =[HomeVC new];
    ReleaseMainVC * vc2 =[ReleaseMainVC new];
    MineVC * vc3 =[MineVC new];
    //2.为3个试图控制器添加导航条
    BaseNavigationController * nav1 =[[BaseNavigationController alloc]initWithRootViewController:vc1];
    BaseNavigationController * nav2 =[[BaseNavigationController alloc]initWithRootViewController:vc2];
    BaseNavigationController * nav3 =[[BaseNavigationController alloc]initWithRootViewController:vc3];
    //3.设置控制器文字
    nav1.title=@"Home";
    nav2.title=@"Edit";
    nav3.title=@"Mine";
    //4.分别设置未选中以及选中状态
    nav1.tabBarItem.image = [[UIImage imageNamed:@"tabbar1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar1s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav2.tabBarItem.image = [[UIImage imageNamed:@"tabbar2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.image = [[UIImage imageNamed:@"tabbar3"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar3s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //5.改变控制器文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:Main_Color} forState:UIControlStateSelected];
    //6.设置中间按钮为红色背景
    UIView * view =[UIView new];
    view.backgroundColor=Main_Color;
    view.frame=CGRectMake(ScreenWidth/3, 0, ScreenWidth/3,self.tabBar.height);
    [self.tabBar insertSubview:view atIndex:0];
    //7.为中间按钮文字及选中状态为白色
     UITabBarItem *item = nav2.tabBarItem;
     [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    //8.取消tbbar的背景透明状态
    [UITabBar appearance].translucent = NO;
       //9.创建数组添加控制器
    NSArray *vcArry = [NSArray arrayWithObjects:nav1,nav2,nav3,nil];
    
    
    
    //10.加载
    self.viewControllers = vcArry;
    
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
