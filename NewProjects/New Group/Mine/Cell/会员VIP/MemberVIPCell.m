//
//  MemberVIPCell.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "MemberVIPCell.h"
@interface MemberVIPCell ()

@property(nonatomic,strong)UILabel * contentLabel;
@end
@implementation MemberVIPCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    MemberVIPCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MemberVIPCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _titleLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    [_titleLabel setImage:[UIImage imageNamed:@"home_logo"] forState:0];
    _titleLabel.titleLabel.font=[UIFont systemFontOfSize:17];
    [_titleLabel setTitleColor:[UIColor blackColor] forState:0];
    _titleLabel.adjustsImageWhenHighlighted=NO;
    [_titleLabel setTitle:@"VIP member" forState:0];
    [self.contentView sd_addSubviews:@[_titleLabel]];
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .heightIs(20)
    .widthIs(200);
    
    _titleLabel.imageView.sd_layout
    .leftSpaceToView(_titleLabel, 0)
    .centerYEqualToView(_titleLabel)
    .widthIs(11)
    .heightIs(11);
    _titleLabel.titleLabel.sd_layout
    .leftSpaceToView(_titleLabel.imageView, 8)
    .centerYEqualToView(_titleLabel)
    .rightSpaceToView(_titleLabel, 5)
    .heightIs(20);
    
    
    _contentLabel=[UILabel new];
    _contentLabel.alpha=.4;
    _contentLabel.font=[UIFont systemFontOfSize:15];
    _contentLabel.text=@"fagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagagggfagsagaggg";
    [self.contentView sd_addSubviews:@[_contentLabel]];
    _contentLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(_titleLabel, 10)
    .autoHeightRatio(0);
    
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:15+15];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x+=10;
    frame.size.width-=20;
    frame.origin.y+=10;
    frame.size.height-=10;
    [super setFrame:frame ];
}
@end
