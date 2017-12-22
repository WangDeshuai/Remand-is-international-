//
//  BasicInforMationCell.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInforMationCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
///左边头像
@property(nonatomic,strong)UIImageView * leftImage;
///标题
@property(nonatomic,strong)UILabel * titleLabel;
///文本框内容
@property(nonatomic,strong)UITextField * contentText;
///线条
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UIButton  *addBtn;
@end
