//
//  MineCell.h
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UIButton * leftImage;
@property(nonatomic,strong)UILabel * namelabel;
@end
