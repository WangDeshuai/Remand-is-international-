//
//  SearchView.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/18.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "SearchView.h"
@interface SearchView ()
@property(nonatomic,strong)NSArray * dataArray;
@end
@implementation SearchView

-(id)initWithFrame:(CGRect)frame  DataArr:(NSArray*)dataArr{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=Main_Color;
        _dataArray=dataArr;
        UIView * lineView =[UIView new];
        lineView.backgroundColor=[UIColor whiteColor];
        [self sd_addSubviews:@[lineView]];
        lineView.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(1);
        
        for (int i =0; i<dataArr.count; i++) {
            UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag=i;
            btn.titleLabel.font=[UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:dataArr[i] forState:0];
            [self sd_addSubviews:@[btn]];
            btn.sd_layout
            .leftSpaceToView(self, 0)
            .rightSpaceToView(self, 0)
            .topSpaceToView(self, 10+(20+40)*i)
            .heightIs(40);
        }
        
        
    }
    
    return self;
}
-(void)btnClick:(UIButton*)btn{
    NSString * str= _dataArray[btn.tag];
    self.NameTypeBlock([NSString stringWithFormat:@"%lu",btn.tag+1], str);
    [self dissmiss];
}
- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];//
    view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [view addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.1;
    view.tag=1000;
    [window addSubview:view];
    [window addSubview:self];
}
-(void)dissmiss{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView * view =[window viewWithTag:1000];
    
    [view removeFromSuperview];
    [self removeFromSuperview];
    
}
@end
