//
//  MyPrivilegeCell.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPrivilegeList.h"
@interface MyPrivilegeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,strong)MyPrivilegeList * model;
@end
