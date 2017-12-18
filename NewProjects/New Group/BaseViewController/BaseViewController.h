//
//  BaseViewController.h
//  Notepad
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton * backHomeBtn;
@property(nonatomic,strong)UIButton * rightButton;
@property(nonatomic,strong)UITableView *baseTableView;
@property(nonatomic,assign)NSInteger    current;
///头部刷新
- (void)mjHeaderRefresh;
///加载更多
- (void)mjFooterRefresh;
@end
