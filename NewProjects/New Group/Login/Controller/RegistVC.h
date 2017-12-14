//
//  RegistVC.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "BaseViewController.h"

@interface RegistVC : BaseViewController
//字典
@property (nonatomic,copy)void(^registBlock)(NSString*username,NSString*psw); ;

@end
