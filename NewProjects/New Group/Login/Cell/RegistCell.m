//
//  RegistCell.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/11.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "RegistCell.h"

@implementation RegistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    RegistCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[RegistCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
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
   
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.textColor=[[UIColor whiteColor]colorWithAlphaComponent:.9];
    _titleLabel.font=[UIFont systemFontOfSize:17];
    [self.contentView sd_addSubviews:@[_titleLabel]];
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .heightIs(20)
    .topSpaceToView(self.contentView,5);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    _contentText=[[UITextField alloc]init];
    _contentText.textColor=[UIColor whiteColor];
    _contentText.font=[UIFont systemFontOfSize:18];

    [self.contentView sd_addSubviews:@[_contentText]];
    _contentText.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(30)
    .topSpaceToView(_titleLabel, 5);
    
    
    _lineView=[UIView new];
    _lineView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:.4];
    [self.contentView sd_addSubviews:@[_lineView]];
    _lineView.sd_layout
    .leftEqualToView(_contentText)
    .rightEqualToView(_contentText)
    .topSpaceToView(_contentText, 5)
    .heightIs(1);
    
    
    _confirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.backgroundColor=[UIColor whiteColor];
    _confirmBtn.hidden=YES;
    _confirmBtn.sd_cornerRadius=@(30/2);
    [_confirmBtn setTitle:@"Confirm" forState:0];
    [_confirmBtn setTitleColor:Main_Color forState:0];
    _confirmBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_confirmBtn]];
    _confirmBtn.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .topSpaceToView(_lineView, 10)
    .heightIs(30)
    .widthIs(100);
    
//    _titleLabel.backgroundColor=[UIColor greenColor];
//    _contentText.backgroundColor=[UIColor magentaColor];
//
    _tishiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _tishiBtn.hidden=YES;
    [_tishiBtn setImage:[UIImage imageNamed:@"login_error"] forState:0];
    [_tishiBtn setTitle:@"This username has been registered" forState:0];
    
    _tishiBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    _tishiBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_tishiBtn]];
    _tishiBtn.sd_layout
    .leftEqualToView(_titleLabel)
    .rightEqualToView(_lineView)
    .heightIs(20)
    .topSpaceToView(_confirmBtn, 5);
    
    _tishiBtn.imageView.sd_layout
    .leftSpaceToView(_tishiBtn, 0)
    .centerYEqualToView(_tishiBtn)
    .widthIs(15)
    .heightIs(15);
    
    _tishiBtn.titleLabel.sd_layout
    .leftSpaceToView(_tishiBtn.imageView, 5)
    .rightSpaceToView(_tishiBtn, 0)
    .centerYEqualToView(_tishiBtn)
    .heightIs(20);
    
    [self setupAutoHeightWithBottomView:_tishiBtn bottomMargin:5];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
//    frame.origin.y+=10;
//    frame.size.height-=20;
//    [super setFrame:frame ];
}
@end
