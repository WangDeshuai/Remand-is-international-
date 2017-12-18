//
//  EditVC.h
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "BaseViewController.h"

@interface EditVC : BaseViewController
//tagg==0 (supply进入)  tagg==1(purchase进入)
@property(nonatomic,assign)NSInteger tagg;
@property (nonatomic,copy)NSString * keyWord;
@end
