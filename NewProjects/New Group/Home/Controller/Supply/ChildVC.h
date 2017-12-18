//
//  ChildVC.h
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "BaseViewController.h"

@interface ChildVC : BaseViewController
//0:默认排序：按匹配度 1:价格排序 2:库存 3:发布时间
@property(nonatomic,copy)NSString * sortType;
//1供应 2采购
@property(nonatomic,copy)NSString  * dataType;

@property(nonatomic,copy)NSString * keyWord;

@end
