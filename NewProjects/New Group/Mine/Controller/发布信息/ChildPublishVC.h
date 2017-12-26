//
//  ChildPublishVC.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "BaseViewController.h"

@interface ChildPublishVC : BaseViewController

/*
 type==1 -----APPROVED(审核通过)
 type==0 ------UNDER REVIEW(审核中未通过)
 */
@property(nonatomic,assign)int type;

@end
