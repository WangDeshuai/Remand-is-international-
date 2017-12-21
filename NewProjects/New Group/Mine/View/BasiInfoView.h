//
//  BasiInfoView.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/14.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasiInfoView : UIView

/// frame --- 坐标  TitleName---标题名字 dataArr----数据源
-(id)initWithFrame:(CGRect)frame TitleName:(NSString*)titlename  AndDataArr:(NSArray*)dataArr;
///返回的名字和对应的类型
@property(nonatomic,copy)void(^NameBlock)(NSString*name,NSString*code);
-(void)show;
-(void)dissmiss;
@end
