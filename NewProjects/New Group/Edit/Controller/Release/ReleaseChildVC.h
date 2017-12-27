//
//  ReleaseChildVC.h
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "BaseViewController.h"

@class ReleaseModel;

@interface ReleaseChildVC : BaseViewController

@property(nonatomic,copy) NSString *productType;

/**
 自定义初始化

 @param mode 编辑的数据源
 @return 类
 */
- (id)initWithModel:(ReleaseModel *)mode;
@end
