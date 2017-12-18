//
//  ForgotCell.h
//  NewProjects
//
//  Created by Mac on 2017/12/17.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UITextField * textField;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UIButton * sendBtn;
@end
