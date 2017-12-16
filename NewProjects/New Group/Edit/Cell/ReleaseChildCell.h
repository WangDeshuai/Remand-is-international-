//
//  ReleaseChildCell.h
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseChildCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UILabel * namelabel;
@property(nonatomic,strong)UITextField * textField;
@property(nonatomic,strong)UIButton * arrowBtn;
@end
