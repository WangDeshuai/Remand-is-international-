//
//  ReleaseChildCell.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ReleaseChildCell.h"
@interface ReleaseChildCell()

@end
@implementation ReleaseChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    ReleaseChildCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ReleaseChildCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    self.layer.cornerRadius=5;
    self.clipsToBounds=YES;
    self.layer.borderColor=[[UIColor lightGrayColor]colorWithAlphaComponent:.5].CGColor;
    self.layer.borderWidth=.5;
    _namelabel=[UILabel new];
    _namelabel.alpha=.7;
    _namelabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_namelabel]];
    _namelabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
    [_namelabel setSingleLineAutoResizeWithMaxWidth:300];
    
    
    
    _arrowBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _arrowBtn.hidden=YES;
    [_arrowBtn setImage:[UIImage imageNamed:@"release_arrow"] forState:0];
    _arrowBtn.userInteractionEnabled=NO;
    _arrowBtn.contentHorizontalAlignment=2;
    [self.contentView sd_addSubviews:@[_arrowBtn]];
    _arrowBtn.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .widthIs(35)
    .heightIs(35);
    
    _textField=[UITextField new];
    _textField.font=[UIFont systemFontOfSize:15];
    _textField.textAlignment=2;
    [self.contentView sd_addSubviews:@[_textField]];
    _textField.sd_layout
    .leftSpaceToView(_namelabel, 10)
    .rightSpaceToView(_arrowBtn, 0)
    .centerYEqualToView(self.contentView)
    .heightIs(30);
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x+=10;
    frame.size.width-=20;
    frame.origin.y+=5;
    frame.size.height-=10;
    [super setFrame:frame ];
}
@end
