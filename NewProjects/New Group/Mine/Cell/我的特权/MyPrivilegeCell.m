//
//  MyPrivilegeCell.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "MyPrivilegeCell.h"
@interface MyPrivilegeCell ()
@property(nonatomic,strong)UILabel * titleLabel;//标题
@property(nonatomic,strong)UILabel * releTimeLabel;//发布
@property(nonatomic,strong)UILabel * timeLable;//日期

@end
@implementation MyPrivilegeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    MyPrivilegeCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MyPrivilegeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    //标题
    _titleLabel=[UILabel new];
    _titleLabel.font=[UIFont systemFontOfSize:17];
    _titleLabel.text=@"White PP(polypropylene) t bags";
    [self.contentView sd_addSubviews:@[_titleLabel]];
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 10)
    .heightIs(20);
    //时间
    _releTimeLabel=[UILabel new];
    _releTimeLabel.font=[UIFont systemFontOfSize:15];
    _releTimeLabel.alpha=.5;
    _releTimeLabel.text=@"Release date";
    [self.contentView sd_addSubviews:@[_releTimeLabel]];
    _releTimeLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel, 10)
    .widthIs(120)
    .heightIs(20);
    
    _timeLable=[UILabel new];
    _timeLable.font=[UIFont systemFontOfSize:15];
    _timeLable.alpha=.5;
    _timeLable.text=@"Dexember 3, 2017";
    [self.contentView sd_addSubviews:@[_timeLable]];
    _timeLable.sd_layout
    .leftSpaceToView(_releTimeLabel, 20)
    .centerYEqualToView(_releTimeLabel)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x+=10;
    frame.size.width-=20;
    [super setFrame:frame ];
}
@end
