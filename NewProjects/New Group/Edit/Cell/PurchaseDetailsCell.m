//
//  PurchaseDetailsCell.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "PurchaseDetailsCell.h"

@implementation PurchaseDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    PurchaseDetailsCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[PurchaseDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreatStar];
    }
    return self;
}
-(void)CreatStar{
    _namelabel=[UILabel new];
    _namelabel.alpha=.4;
    _namelabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_namelabel]];
    _namelabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .widthIs(200)
    .heightIs(20);
//    [_namelabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    _contentlabel=[UILabel new];
    _contentlabel.alpha=.7;
    _contentlabel.font=[UIFont systemFontOfSize:15];
    _contentlabel.textAlignment=2;
    [self.contentView sd_addSubviews:@[_contentlabel]];
    _contentlabel.sd_layout
    .leftSpaceToView(_namelabel, 10)
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(_namelabel)
    .heightIs(20);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
