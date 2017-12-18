//
//  SearchView.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/18.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView
-(id)initWithFrame:(CGRect)frame  DataArr:(NSArray*)dataArr;
@property(nonatomic,copy)void(^NameTypeBlock)(NSString*type,NSString*name);
-(void)show;
-(void)dissmiss;
@end
