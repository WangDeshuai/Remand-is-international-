//
//  ChildCell.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ChildCell.h"
@interface ChildCell()
@property(nonatomic,strong)UIImageView * leftImage;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * stockLabel;
@property(nonatomic,strong)UILabel * tonsLabel;
@property(nonatomic,strong)UILabel * locaLabel;
@property(nonatomic,strong)UILabel * addArssLabel;
@property(nonatomic,strong)UILabel * priceLabel;
@property(nonatomic,strong)UILabel * moneyLabel;
@end
@implementation ChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    ChildCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ChildCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
  // 10  20 5 15 5 15 5 15 10
    _leftImage=[UIImageView new];
    _leftImage.backgroundColor=[UIColor redColor];
    [self.contentView sd_addSubviews:@[_leftImage]];
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 10)
    .widthIs(80)
    .heightIs(80);
    //标题
    _titleLabel=[UILabel new];
    _titleLabel.text=@"White PP (polypropylene) t bags";
    _titleLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView sd_addSubviews:@[_titleLabel]];
    _titleLabel.sd_layout
    .leftSpaceToView(_leftImage, 10)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(20);
    int d =5;
    int h=15;
    //子控件
    //(1)
    _stockLabel=[UILabel new];
    _stockLabel.text=@"Stock";
    _stockLabel.font=[UIFont systemFontOfSize:13];
    _stockLabel.alpha=.5;
    [self.contentView sd_addSubviews:@[_stockLabel]];
    _stockLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel, d)
    .heightIs(h);
    [_stockLabel setSingleLineAutoResizeWithMaxWidth:200];
    //(2)
    _tonsLabel=[UILabel new];
    _tonsLabel.text=@"80 tons";
    _tonsLabel.font=[UIFont systemFontOfSize:13];
    _tonsLabel.alpha=.7;
    [self.contentView sd_addSubviews:@[_tonsLabel]];
    _tonsLabel.sd_layout
    .leftSpaceToView(self.contentView, ScreenWidth/2)
    .heightIs(h)
    .centerYEqualToView(_stockLabel);
    [_tonsLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    //(3)
    _locaLabel=[UILabel new];
    _locaLabel.text=@"Location";
    _locaLabel.font=[UIFont systemFontOfSize:13];
    _locaLabel.alpha=.5;
    [self.contentView sd_addSubviews:@[_locaLabel]];
    _locaLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_stockLabel, d)
    .heightIs(h);
    [_locaLabel setSingleLineAutoResizeWithMaxWidth:200];
    
//    (4)
    _addArssLabel=[UILabel new];
    _addArssLabel.alpha=.6;
    _addArssLabel.text=@"Guangdong,China";
    _addArssLabel.font=[UIFont systemFontOfSize:13];
    [self.contentView sd_addSubviews:@[_addArssLabel]];
    _addArssLabel.sd_layout
    .leftEqualToView(_tonsLabel)
    .topSpaceToView(_tonsLabel, d)
    .heightIs(h);
    [_addArssLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    //(5)
    _priceLabel=[UILabel new];
    _priceLabel.text=@"Price";
    _priceLabel.font=[UIFont systemFontOfSize:13];
    _priceLabel.alpha=.5;
    [self.contentView sd_addSubviews:@[_priceLabel]];
    _priceLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_locaLabel, d)
    .heightIs(h);
    [_priceLabel setSingleLineAutoResizeWithMaxWidth:200];
    //(6)
    _moneyLabel=[UILabel new];
    _moneyLabel.alpha=.6;
    _moneyLabel.text=@"¥2800/t";
    _moneyLabel.textColor=[UIColor redColor];
    _moneyLabel.font=[UIFont systemFontOfSize:13];
    [self.contentView sd_addSubviews:@[_moneyLabel]];
    _moneyLabel.sd_layout
    .leftEqualToView(_tonsLabel)
    .topSpaceToView(_addArssLabel, d)
    .heightIs(h);
    [_moneyLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

-(void)setModel:(SuppleProduct *)model
{
    _model=model;
    [_leftImage sd_setImageWithURL:[NSURL URLWithString:model.productImage.firstObject] placeholderImage:[UIImage imageNamed:@"mine_head"]];
    _titleLabel.text=model.productName;
    _tonsLabel.text=[NSString stringWithFormat:@"%.2ftons",model.stockNum];
    _addArssLabel.text=model.address;
    _moneyLabel.text=[NSString stringWithFormat:@"¥%.2f/t",model.price];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
