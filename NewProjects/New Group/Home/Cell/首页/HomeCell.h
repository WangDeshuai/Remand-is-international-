//
//  HomeCell.h
//  NewProjects
//
//  Created by Mac on 2017/12/9.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewList.h"
@interface HomeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath ;
@property(nonatomic,strong)HomeViewList * model;
@end
