//
//  SearchTabCell.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/16.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTabCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UIButton * cancelBtn;
@end
