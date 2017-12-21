//
//  ReleaseMainVC.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ReleaseMainVC.h"
#import "ReleaseChildVC.h"
#import "SGPagingView.h"
@interface ReleaseMainVC ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentView;
@end

@implementation ReleaseMainVC
- (void)dealloc {
    NSLog(@"DefaultThreeCoverVC - - dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Release";
    self.backHomeBtn.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupPageView];
}
- (void)setupPageView {
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    
    NSArray *titleArr = @[@"Supply", @"Purchase", ];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleSelectedColor = [UIColor whiteColor];
    configure.indicatorStyle = SGIndicatorStyleCover;
    configure.titleColor=[[UIColor blackColor]colorWithAlphaComponent:.7];
    configure.indicatorColor = Main_Color;
    configure.indicatorAdditionalWidth = (ScreenWidth-30)/2-2;
    configure.indicatorHeight=39;
    configure.indicatorCornerRadius = 30;
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(15, pageTitleViewY+10, self.view.frame.size.width-30,44) delegate:self titleNames:titleArr configure:configure];
    
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.isNeedBounces = NO;
    self.pageTitleView.backgroundColor=[UIColor whiteColor];
    self.pageTitleView.isShowBottomSeparator=NO;
    self.pageTitleView.layer.cornerRadius=44/2;
    self.pageTitleView.clipsToBounds=YES;
    self.pageTitleView.layer.borderWidth=1;
    self.pageTitleView.layer.borderColor=[[UIColor lightGrayColor]colorWithAlphaComponent:.4].CGColor;
    [self.view addSubview:_pageTitleView];
  
    ReleaseChildVC *oneVC = [[ReleaseChildVC alloc] init];
    oneVC.productType=@"4497003000060001";
    ReleaseChildVC *twoVC = [[ReleaseChildVC alloc] init];
    twoVC.productType=@"4497003000070001";
    NSArray *childArr = @[oneVC, twoVC];
    /// pageContentView
    self.pageContentView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentScrollView = self;
    [self.view insertSubview:_pageContentView atIndex:0];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
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
