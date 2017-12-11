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
-(void)getwithUrl:(NSString*)URL andParameter:(NSDictionary*)Parameter withSuccessBlock:(void(^)(NSDictionary*dic))succeedBlock   andFailBlock:(void(^)(NSError*error))failBlock andprogressBlock:(void(^)(NSProgress*progress))progressBlock;
//post(图片)
-(void)postPictureDatewithUrl:(NSString*)URL andParameter:(NSDictionary*)Parameter constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block  withSuccessBlock:(void(^)(NSDictionary*dic))succeedBlock   andFailBlock:(void(^)(NSError*error))failBlock andprogressBlock:(void(^)(NSProgress*progress))progressBlock;

@end
