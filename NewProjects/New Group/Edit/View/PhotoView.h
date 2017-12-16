//
//  PhotoView.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/16.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView
/// MaxPhoto 可以选择最大的照片数 EachRowNumber每行显示几个

-(id)initWithFrame:(CGRect)frame MaxPhoto:(NSInteger)maxPhoto EachRowNumber:(NSInteger)number;
@property(nonatomic,strong) id delegate;
@property (nonatomic,copy)void(^photosArrBlock)(NSArray * photosArr);
@end
