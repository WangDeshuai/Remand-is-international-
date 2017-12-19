//
//  SearchTabCell.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/16.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "SearchTabCell.h"
@interface SearchTabCell()
@property(nonatomic,strong)UIImageView * leftImage;
@property(nonatomic,strong)UIView * lineView;
@end

@implementation SearchTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    SearchTabCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[SearchTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _leftImage.image=[UIImage imageNamed:@"search_time"];
    [self.contentView sd_addSubviews:@[_leftImage]];
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .widthIs(20)
    .heightIs(20);
    
    _nameLabel=[UILabel new];
    _nameLabel.textAlignment=0;
    _nameLabel.alpha=.7;
    _nameLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_nameLabel]];
    _nameLabel.sd_layout
    .leftSpaceToView(_leftImage, 10)
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
    _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setImage:[UIImage imageNamed:@"search_cancel"] forState:0];
//    _cancelBtn.backgroundColor=[UIColor redColor];
//    _cancelBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [self.contentView sd_addSubviews:@[_cancelBtn]];
    _cancelBtn.sd_layout
    .rightSpaceToView(self.contentView,0)
    .centerYEqualToView(self.contentView)
    .widthIs(80)
    .heightIs(50);
    
    
    _lineView=[UIView new];
    _lineView.backgroundColor=BG_COLOR;
    [self.contentView sd_addSubviews:@[_lineView]];
    _lineView.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView,1)
    .heightIs(1);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
