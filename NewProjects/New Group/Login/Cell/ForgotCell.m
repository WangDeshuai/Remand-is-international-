//
//  ForgotCell.m
//  NewProjects
//
//  Created by Mac on 2017/12/17.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ForgotCell.h"

@implementation ForgotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    ForgotCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ForgotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    self.backgroundColor=[UIColor clearColor];
    //标题
    _titleLabel=[UILabel new];
    _titleLabel.text=@"Username";
    _titleLabel.textColor=[[UIColor whiteColor]colorWithAlphaComponent:.7];
    _titleLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_titleLabel]];
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .topSpaceToView(self.contentView, 5)
    .widthIs(120)
    .heightIs(20);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:300];
    //textField
    _textField=[UITextField new];
    _textField.placeholder=@"Enter e-mail for verification code";
    _textField.font=[UIFont systemFontOfSize:15];
    _textField.textAlignment=0;
    _textField.textColor=[UIColor whiteColor];
    _textField.placeholderColor=[[UIColor whiteColor]colorWithAlphaComponent:.3];
    [self.contentView sd_addSubviews:@[_textField]];
    _textField.sd_layout
    .leftEqualToView(_titleLabel)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(_titleLabel, 5)
    .heightIs(30);
    
    _lineView=[UIView new];
    _lineView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.3];
    [self.contentView sd_addSubviews:@[_lineView]];
    _lineView.sd_layout
    .leftEqualToView(_titleLabel)
    .rightSpaceToView(self.contentView, 30)
    .topSpaceToView(_textField, 0)
    .heightIs(1);
    
    _sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _sendBtn.hidden=YES;
    [_sendBtn setTitle:@"Confirm" forState:0];
    [_sendBtn setTitleColor:Main_Color forState:0];
    _sendBtn.backgroundColor=[UIColor whiteColor];
    _sendBtn.sd_cornerRadius=@(35/2);
    _sendBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_sendBtn]];
    _sendBtn.sd_layout
    .leftEqualToView(_lineView)
    .topSpaceToView(_lineView, 10)
    .widthIs(120)
    .heightIs(35);
    
    
//    _titleLabel.backgroundColor=[UIColor redColor];
//    _textField.backgroundColor=[UIColor yellowColor];
   
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
