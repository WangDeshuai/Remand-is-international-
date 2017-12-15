//
//  HomeCell.m
//  NewProjects
//
//  Created by Mac on 2017/12/9.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "HomeCell.h"
@interface HomeCell()
@property(nonatomic,strong)UIImageView * iconImage;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * contentLabel;

@end
@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    HomeCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
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
    _iconImage=[UIImageView new];
    _iconImage.image=[UIImage imageNamed:@"home_logo"];
//    _iconImage.backgroundColor=[UIColor redColor];
    [self.contentView sd_addSubviews:@[_iconImage]];
    _iconImage.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .widthIs(15)
    .heightIs(15);
    
    _titleLabel=[UILabel new];
    _titleLabel.font=[UIFont systemFontOfSize:16];
    _titleLabel.alpha=.7;
    _titleLabel.text=@"White PP (polypropylene) t bags";
    [self.contentView sd_addSubviews:@[_titleLabel]];
    _titleLabel.sd_layout
    .leftSpaceToView(_iconImage, 10)
    .centerYEqualToView(_iconImage)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
    _contentLabel=[UILabel new];
    _contentLabel.font=[UIFont systemFontOfSize:16];
    _contentLabel.alpha=.5;
    _contentLabel.text=@"At 14:10 on November 12";
    [self.contentView sd_addSubviews:@[_contentLabel]];
    _contentLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel, 10)
    .rightEqualToView(self.contentView)
    .heightIs(20);
    
}
-(void)setModel:(HomeViewList *)model
{
    _model=model;
    _titleLabel.text=model.productName;
    _contentLabel.text=model.releaseTime;
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x+=10;
    frame.size.width-=20;
     [super setFrame:frame ];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
