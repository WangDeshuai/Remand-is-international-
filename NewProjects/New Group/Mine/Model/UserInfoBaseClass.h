//
//  UserInfoBaseClass.h
//
//  Created by feijiu 02 on 2017/12/14
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserInfoBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSArray *categorys;
@property (nonatomic, strong) NSString *memberType;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *resultMessage;
@property (nonatomic, strong) NSArray *mobiles;
@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *vipType;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *nikeName;
@property (nonatomic, assign) double resultCode;
@property (nonatomic, strong) NSArray *emails;
@property (nonatomic, strong) NSString *regType;
@property (nonatomic, strong) NSString *companyPhone;
@property (nonatomic, strong) NSString *qq;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *areaCode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
