//
//  Engine.h
//  PositioningDome
//
//  Created by Mac on 2017/11/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Engine : NSObject
//单例
+(instancetype)sharedEngine;

//post
-(void)postwithUrl:(NSString*)URL andParameter:(NSDictionary*)Parameter withSuccessBlock:(void(^)(NSDictionary*dic))succeedBlock   andFailBlock:(void(^)(NSError*error))failBlock andprogressBlock:(void(^)(NSProgress*progress))progressBlock;
//get
-(void)getwithUrl:(NSString*)URL andParameter:(NSDictionary*)Parameter withSuccessBlock:(void(^)(id item))succeedBlock   andFailBlock:(void(^)(NSError*error))failBlock andprogressBlock:(void(^)(NSProgress*progress))progressBlock;
//post(图片)
-(void)postPictureDatewithUrl:(NSString*)URL andParameter:(NSDictionary*)Parameter constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block  withSuccessBlock:(void(^)(NSDictionary*dic))succeedBlock   andFailBlock:(void(^)(NSError*error))failBlock andprogressBlock:(void(^)(NSProgress*progress))progressBlock;

/**
 再塑宝国际版北京POST请求

 @param url 服务器地址
 @param apiName 接口名称
 @param parame 请求参数Body
 @param callback 返回参数
 @param failedBlock 失败
 */
- (void)BJPostWithUrl:(NSString *)url withAPIName:(NSString *)apiName withParame:(NSDictionary *)parame callback:(void(^)(id item))callback failedBlock:(void(^)(id error))failedBlock;
@end
