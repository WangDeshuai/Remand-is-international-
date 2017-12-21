//
//  AddressView.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/20.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressView : UIView
-(id)initWithFrame:(CGRect)frame TitleName:(NSString*)titlename  AndDataArr:(NSArray*)dataArr IntType:(int)type;
@property(nonatomic,copy)void(^ControlBlock)(NSString*name,NSString*code);
-(void)show;
-(void)dissmiss;
@end
