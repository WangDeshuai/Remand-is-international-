//
//  LoginModel.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/14.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
@property(nonatomic,copy)NSString * access_token;
@property(nonatomic,copy)NSString * account_typeName;
@property(nonatomic,copy)NSString*  count_message;
@property(nonatomic,copy)NSString * email;
@property(nonatomic,copy)NSString * head_img;
-(id)initWithLoginDic:(NSDictionary*)dic;
@end
