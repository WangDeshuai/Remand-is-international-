//
//  SearchCell.m
//  NewProjects
//
//  Created by Mac on 2017/12/15.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self CreatStr];
        
    }
    return self;
}
-(void)CreatStr{
    _nameLable=[UILabel new];
    _nameLable.font=[UIFont systemFontOfSize:15];
    _nameLable.alpha=.6;
    _nameLable.textAlignment=0;
    [self.contentView sd_addSubviews:@[_nameLable]];
    _nameLable.sd_layout
    .leftSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,0)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
}
@end
