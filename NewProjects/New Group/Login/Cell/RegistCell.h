//
//  RegistCell.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UITextField * contentText;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UIButton * confirmBtn;
@property(nonatomic,strong)UIButton * tishiBtn;//提示语
@end
