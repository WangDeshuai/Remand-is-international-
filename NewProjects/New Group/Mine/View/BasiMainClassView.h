//
//  BasiMainClassView.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/21.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasiMainClassView : UIView
-(id)initWithFrame:(CGRect)frame TitleName:(NSString*)titlename  AndDataArr:(NSArray*)dataArr;
-(void)show;
-(void)dissmiss;
@property (nonatomic,copy)void(^NameCodeBlock)(NSString*name,NSString*code);
@end
