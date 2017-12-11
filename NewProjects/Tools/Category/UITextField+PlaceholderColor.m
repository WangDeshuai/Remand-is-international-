//
//  UITextField+PlaceholderColor.m
//  NewProjects
//
//  Created by Mac on 2017/12/9.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "UITextField+PlaceholderColor.h"
#import <objc/runtime.h>
@implementation UITextField (PlaceholderColor)


-(UIColor*)placeholderColor{
    return objc_getAssociatedObject(self, @"PlaceholderColor");
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, @"PlaceholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel * namelabel =[self valueForKey:@"placeholderLabel"];
    namelabel.textColor=placeholderColor;
}

-(UIColor*)cursorColor{
    return objc_getAssociatedObject(self, @"CursColor");
}
-(void)setCursorColor:(UIColor *)cursorColor
{
    objc_setAssociatedObject(self,  @"CursColor", cursorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[UITextField appearance] setTintColor:cursorColor];
}
@end
