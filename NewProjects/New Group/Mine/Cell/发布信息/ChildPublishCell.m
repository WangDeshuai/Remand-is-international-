//
//  ChildPublishCell.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/12.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ChildPublishCell.h"
@interface ChildPublishCell ()
@property(nonatomic,strong)UILabel * titleLabel;//标题
@property(nonatomic,strong)UILabel * releTimeLabel;//发布
@property(nonatomic,strong)UILabel * timeLable;//日期
@property(nonatomic,strong)UILabel * locationLabel;//定位
@property(nonatomic,strong)UILabel * weizhiLabel;//位置
@end
@implementation ChildPublishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    ChildPublishCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ChildPublishCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    //定位
    _locationLabel=[UILabel new];
    _locationLabel.font=[UIFont systemFontOfSize:15];
    _locationLabel.alpha=.5;
    _locationLabel.text=@"Location";
    [self.contentView sd_addSubviews:@[_locationLabel]];
    _locationLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_releTimeLabel, 5)
    .widthIs(120)
    .heightIs(20);
    
    _weizhiLabel=[UILabel new];
    _weizhiLabel.font=[UIFont systemFontOfSize:15];
    _weizhiLabel.alpha=.5;
    _weizhiLabel.text=@"Guangdong,China";
    [self.contentView sd_addSubviews:@[_weizhiLabel]];
    _weizhiLabel.sd_layout
    .leftSpaceToView(_locationLabel, 20)
    .centerYEqualToView(_locationLabel)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
    /*
     审核未通过(之所以用button代替label是因为前面有图片,btn能加载图片和文字,label只能加载文字)
     */
    _namelabel=[UIButton buttonWithType:UIButtonTypeCustom];
    _namelabel.adjustsImageWhenHighlighted=NO;
    [_namelabel setTitle:@"Your post did not passthe review" forState:0];
    [_namelabel setImage:[UIImage imageNamed:@"publish_error"] forState:0];
    [_namelabel setTitleColor:Main_Color forState:0];
    [self.contentView sd_addSubviews:@[_namelabel]];
    _namelabel.sd_layout
    .leftEqualToView(_locationLabel)
    .topSpaceToView(_locationLabel, 15)
    .heightIs(20)
    .rightSpaceToView(self.contentView, 15);
    
    _namelabel.imageView.sd_layout
    .leftSpaceToView(_namelabel, 0)
    .centerYEqualToView(_namelabel)
    .widthIs(35/2)
    .heightIs(35/2);
    _namelabel.titleLabel.sd_layout
    .leftSpaceToView(_namelabel.imageView, 5)
    .rightSpaceToView(_namelabel, 0)
    .centerYEqualToView(_namelabel)
    .heightIs(20);
    
    
    
    
    
    //编辑按钮
    _editBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn setTitle:@"Edit" forState:0];
    _editBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_editBtn setTitleColor:Main_Color forState:0];
    _editBtn.sd_cornerRadius=@(35/2);
    _editBtn.layer.borderWidth=1;
    _editBtn.layer.borderColor=Main_Color.CGColor;
    [self.contentView sd_addSubviews:@[_editBtn]];
    _editBtn.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_locationLabel, 15)
    .heightIs(35)
    .widthIs(120);
    
    //撤销按钮
    _undoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_undoBtn setTitle:@"Undo" forState:0];
    _undoBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_undoBtn setTitleColor:Main_Color forState:0];
    _undoBtn.sd_cornerRadius=@(35/2);
    _undoBtn.layer.borderWidth=1;
    _undoBtn.layer.borderColor=Main_Color.CGColor;
    [self.contentView sd_addSubviews:@[_undoBtn]];
    _undoBtn.sd_layout
    .leftSpaceToView(_editBtn, 20)
    .centerYEqualToView(_editBtn)
    .heightIs(35)
    .widthIs(120);
    
    [self setupAutoHeightWithBottomView:_undoBtn bottomMargin:10];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
