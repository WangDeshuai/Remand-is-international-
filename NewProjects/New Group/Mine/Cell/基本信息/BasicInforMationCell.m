//
//  BasicInforMationCell.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "BasicInforMationCell.h"

@implementation BasicInforMationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    BasicInforMationCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[BasicInforMationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    
    _leftImage=[UIImageView new];
    [self.contentView sd_addSubviews:@[_leftImage]];
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .centerYEqualToView(self.contentView)
    .widthIs(20)
    .heightIs(20);
    
    
    
    
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.textColor=[[UIColor whiteColor]colorWithAlphaComponent:.9];
    _titleLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_titleLabel]];
    _titleLabel.sd_layout
    .leftSpaceToView(_leftImage, 15)
    .heightIs(20)
    .topSpaceToView(self.contentView, 10);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    _contentText=[[UITextField alloc]init];
    _contentText.textColor=[UIColor whiteColor];
    _contentText.font=[UIFont systemFontOfSize:18];
    _contentText.placeholderColor=[UIColor whiteColor];
    [self.contentView sd_addSubviews:@[_contentText]];
    _contentText.sd_layout
    .leftEqualToView(_titleLabel)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(30)
    .topSpaceToView(_titleLabel, 0);
    
    _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _addBtn.backgroundColor=[UIColor greenColor];
    _addBtn.hidden=YES;
    [self.contentView sd_addSubviews:@[_addBtn]];
    _addBtn.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .widthIs(50)
    .heightIs(50);
    
    
    
    _lineView=[UIView new];
    _lineView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:.4];
    [self.contentView sd_addSubviews:@[_lineView]];
    _lineView.sd_layout
    .leftEqualToView(_contentText)
    .rightEqualToView(_contentText)
    .topSpaceToView(_contentText, 5)
    .heightIs(1);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
