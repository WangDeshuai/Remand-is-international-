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
static NSString * Message_Loading=@"请稍后...";
static NSString * Message_Success=@"成功";
static NSString * Message_Fail=@"失败";
static NSInteger  animationTime =.5;


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
static NSString *VIPApi_Modification =@"com_zft_zaisubaos_api_ApiMemberUpdateEn";
///修改会员密码
static NSString *VIPApi_Changepassword =@"com_zft_zaisubaos_api_ApiModifyPwdAppEn";
///会员找回密码
static NSString *VIPApi_Retrievepassword =@"com_zft_zaisubaos_api_ApiFindPwdAppEn";

#pragma mark ------首页接口
///首页顶部广告
static NSString * FirstApi_Topimage =@"com_zft_zaisubaos_api_ApiTopAdvertisementEn";
///首页商品展示
static NSString * FirstApi_ShopShow =@"com_zft_zaisubaos_api_ApiHomePageProList";
///首页获取热词记录
static NSString * SearchApi_Record =@"com_zft_zaisubaos_api_ApiQrySearchWordRecord";
///首页搜索热词
static NSString * SearchApi_Search =@"com_zft_zaisubaos_api_ApiSearchZsbAppEn";
///首页删除搜索词记录
static NSString * SearchApi_Delete =@"com_zft_zaisubaos_api_ApiDelSearchWordRecord";
///首页详情页
static NSString * FirstApi_Particulars=@"com_zft_zaisubaos_api_ApiProductInfoAppEn";
///首页详情页查看特权
static NSString * FirstApi_Privilege=@"com_zft_zaisubaos_api_ApiGetUserAndTqAppEn";
///首页详情页查看联系方式
static NSString * FirstApi_Phone=@"com_zft_zaisubaos_api_ApiProductTelInfoAppEn";
///

#endif /* API_Name_h */
