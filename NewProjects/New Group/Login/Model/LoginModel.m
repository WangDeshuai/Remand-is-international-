//
//  LoginModel.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/14.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
-(id)initWithLoginDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        _access_token=[ToolClass isString:[dic objectForKey:@"access_token"]];
        NSString * type =[ToolClass isString:[dic objectForKey:@"account_type"]];
        if ([type isEqualToString:@"4497002900070001"]) {
            _account_typeName=@"免费会员";
        }else if ([type isEqualToString:@"4497002900070002"]){
            _account_typeName=@"国内代售会员";
        }else if ([type isEqualToString:@"4497002900070003"]){
            _account_typeName=@"国际代售会员";
        }else if ([type isEqualToString:@"4497002900070004"]){
             _account_typeName=@"国内城市合伙人";
        }else if ([type isEqualToString:@"4497002900070005"]){
             _account_typeName=@"国内VIP会员";
        }else if ([type isEqualToString:@"4497002900070006"]){
             _account_typeName= @"国际VIP会员";
        }else if ([type isEqualToString:@"4497002900070007"]){
            _account_typeName= @"名企会员";
        }else {
             _account_typeName= @"状态错误";
        }
          _head_img=[ToolClass isString:[dic objectForKey:@"head_img"]];
          _email=[ToolClass isString:[dic objectForKey:@"email"]];
    }
    
    return self;
}
@end
