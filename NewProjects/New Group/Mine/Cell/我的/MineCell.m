//
//  MineCell.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    MineCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    
    _leftImage=[UIButton buttonWithType:UIButtonTypeCustom];
//    _leftImage.backgroundColor=[UIColor redColor];
    _leftImage.userInteractionEnabled=YES;
    _leftImage.adjustsImageWhenHighlighted=NO;
    [self.contentView sd_addSubviews:@[_leftImage]];
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .widthIs(40)
    .heightIs(40);
    
    _namelabel=[UILabel new];
    _namelabel.font=[UIFont systemFontOfSize:16];
    _namelabel.alpha=.7;
    [self.contentView sd_addSubviews:@[_namelabel]];
    _namelabel.sd_layout
    .leftSpaceToView(_leftImage, 10)
    .centerYEqualToView(_leftImage)
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
