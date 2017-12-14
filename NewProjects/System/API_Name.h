//
//  API_Name.h
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/13.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#ifndef API_Name_h
#define API_Name_h

#pragma mark ----登录变量名字
static NSString *API_Token = @"access_token";
static NSString *API_Email = @"email";
static NSString *API_Type = @"account_type";
static NSString * API_Headimg =@"head_img";
static NSString * API_UserName =@"username";
#pragma mark ------注册---------
///注册验证用户名
static NSString *RegistApi_Name =@"com_zft_zaisubaos_api_ApiRegCheckLoginNameEn";
///获取注册短信验证码
static NSString *RegistApi_Code =@"com_zft_zaisubaos_api_ApiMailVerifyCode";
///注册
static NSString *RegistApi_Regist =@"com_zft_zaisubaos_api_ApiRegisterAppEn";
///登录
static NSString *LoginApi_Login =@"com_zft_zaisubaos_api_ApiLoginAppEn";
///找回密码
static NSString *PswApi_Psw =@"com_zft_zaisubaos_api_ApiFindPwdAppEn";
#pragma mark ------我的------
///获取会员信息
static NSString *VIPApi_Message =@"com_zft_zaisubaos_api_ApiMemberInfoEn";
///修改会员信息
static NSString *VIPApi_modification =@"com_zft_zaisubaos_api_ApiMemberUpdateEn";



#pragma mark ------首页接口
///首页顶部广告
static NSString * FirstApi_Topimage =@"com_zft_zaisubaos_api_ApiTopAdvertisementEn";
///首页商品展示
static NSString * FirstApi_ShopShow =@"com_zft_zaisubaos_api_ApiHomePageProList";









#endif /* API_Name_h */
