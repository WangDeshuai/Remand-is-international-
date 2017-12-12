//
//  ChildPublishCell.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildPublishCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UIButton *editBtn;//编辑按钮
@property(nonatomic,strong)UIButton * undoBtn;//撤销或者删除按钮
@property(nonatomic,strong)UIButton * namelabel;//未通过提醒按钮

@end
