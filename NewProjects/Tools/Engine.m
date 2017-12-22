//
//  Engine.m
//  PositioningDome
//
//  Created by Mac on 2017/11/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Engine.h"

@implementation Engine
static id _engine=nil;
static AFHTTPSessionManager *manager=nil;
#pragma mark ------单例类创建
+(instancetype)sharedEngine{
    return [[self alloc]init];
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _engine=[super allocWithZone:zone];
    });
    return _engine;
}
-(instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _engine=[super init];
    });
    return _engine;
}
//copy在底层 会调用copyWithZone:
- (id)copyWithZone:(NSZone *)zone{
    return  _engine;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  _engine;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return _engine;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return _engine;
}
-(AFHTTPSessionManager *)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager==nil) {
            manager = [AFHTTPSessionManager manager];
        }
    });
     return manager;
}

#pragma mark --------网络请求封装
//get
-(void)getwithUrl:(NSString*)URL andParameter:(NSDictionary*)Parameter withSuccessBlock:(void(^)(id item))succeedBlock andFailBlock:(void(^)(NSError*error))failBlock andprogressBlock:(void(^)(NSProgress*progress))progressBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json", @"application/json", @"text/javascript", @"text/xml", nil];
    [manager GET:URL parameters:Parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        progressBlock(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Get=====%@",str);
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败了>>>%@",error);
        failBlock(error);
    }];
}



-(void)requestUpdatePoto:(id)imgs photoStr:(NSString *)photoStr urlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters successBlock:(successBlock)successBlock failedBlock:(failedBlock)failedBlock 
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData){
        if ([imgs isKindOfClass:[NSArray class]]) {
            NSArray * images = imgs;
            for (int i = 0 ; i < images.count ;i ++) {
                UIImage * img = imgs[i];
                NSData *data = UIImageJPEGRepresentation(img, 0.1);
                NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%.f",interval-i] fileName:[NSString stringWithFormat:@"%.f.png",interval-i] mimeType:@"image/png"];
            }
            
        }else{
            NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
            NSData *data = UIImageJPEGRepresentation(imgs, .1);
            [formData appendPartWithFileData:data name:photoStr fileName:[NSString stringWithFormat:@"%.f.png",interval] mimeType:@"image/png"];
        }
    }progress:^(NSProgress * _Nonnull uploadProgress)
     {} success:^(NSURLSessionDataTask * _Nonnull task, id  responseObject){
        
         NSString* aStr= [[NSString alloc] initWithData:responseObject  encoding:NSASCIIStringEncoding];
         aStr = [aStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
         NSLog(@"图片>>>%@",aStr);
         successBlock(aStr);
     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError *_Nonnull error){
        
         NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
         NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"tryuioiouyfghjkl服务器的错误原因:%@",str);
       
     }];
}









- (void)BJPostWithUrl:(NSString *)url withAPIName:(NSString *)apiName withParame:(NSDictionary *)parame callback:(void(^)(id item))callback failedBlock:(void(^)(id error))failedBlock
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parame?parame:@{}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonDataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonDataStr = [jsonDataStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *api_secretStr = [NSString string];
    api_secretStr = [NSString stringWithFormat:@"%@%@%@%@%@",apiName,API_key,jsonDataStr,currentDate,API_pass];
    
    NSString *mdString = [ToolClass md5:api_secretStr].uppercaseString;
    NSDictionary *paramDic =@{@"api_key":API_key,@"api_input":jsonDataStr,@"api_target":apiName,@"api_secret":mdString,@"api_timespan":currentDate,@"api_token":[[NSUSE_DEFO objectForKey:API_Token]length]?[NSUSE_DEFO objectForKey:API_Token]:@""};
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [self manager];
    [mgr.requestSerializer setValue:@"en" forHTTPHeaderField:@"Accept-Language"];
        
    // 2.发送POST请求
    [mgr POST:[url stringByAppendingString:apiName]
   parameters:paramDic
     progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
          NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"=====%@",str);
          
          
          
          callback(responseObject);
          
      }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LCProgressHUD showFailure:error.localizedDescription];
          if (failedBlock) {
              failedBlock(error);
          }
      }];
}
@end
