//
//  UserInfoBaseClass.m
//
//  Created by feijiu 1 on 2017/12/25
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "UserInfoBaseClass.h"


NSString *const kUserInfoBaseClassAreaName = @"area_name";
NSString *const kUserInfoBaseClassCategorys = @"categorys";
NSString *const kUserInfoBaseClassMemberType = @"member_type";
NSString *const kUserInfoBaseClassHeadImg = @"head_img";
NSString *const kUserInfoBaseClassMobile = @"mobile";
NSString *const kUserInfoBaseClassResultMessage = @"resultMessage";
NSString *const kUserInfoBaseClassLoginName = @"login_name";
NSString *const kUserInfoBaseClassVipType = @"vip_type";
NSString *const kUserInfoBaseClassCompanyName = @"company_name";
NSString *const kUserInfoBaseClassNikeName = @"nike_name";
NSString *const kUserInfoBaseClassCategoryNames = @"categoryNames";
NSString *const kUserInfoBaseClassResultCode = @"resultCode";
NSString *const kUserInfoBaseClassRegType = @"reg_type";
NSString *const kUserInfoBaseClassCompanyPhone = @"company_phone";
NSString *const kUserInfoBaseClassEmail = @"email";
NSString *const kUserInfoBaseClassAreaCode = @"area_code";


@interface UserInfoBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserInfoBaseClass

@synthesize areaName = _areaName;
@synthesize categorys = _categorys;
@synthesize memberType = _memberType;
@synthesize headImg = _headImg;
@synthesize mobile = _mobile;
@synthesize resultMessage = _resultMessage;
@synthesize loginName = _loginName;
@synthesize vipType = _vipType;
@synthesize companyName = _companyName;
@synthesize nikeName = _nikeName;
@synthesize categoryNames = _categoryNames;
@synthesize resultCode = _resultCode;
@synthesize regType = _regType;
@synthesize companyPhone = _companyPhone;
@synthesize email = _email;
@synthesize areaCode = _areaCode;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.areaName = [self objectOrNilForKey:kUserInfoBaseClassAreaName fromDictionary:dict];
            self.categorys = [self objectOrNilForKey:kUserInfoBaseClassCategorys fromDictionary:dict];
//            self.memberType = [self objectOrNilForKey:kUserInfoBaseClassMemberType fromDictionary:dict];
           self.memberType = [ToolClass registTyple:[self objectOrNilForKey:kUserInfoBaseClassMemberType fromDictionary:dict]];
        
        
            self.headImg = [self objectOrNilForKey:kUserInfoBaseClassHeadImg fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kUserInfoBaseClassMobile fromDictionary:dict];
            self.resultMessage = [self objectOrNilForKey:kUserInfoBaseClassResultMessage fromDictionary:dict];
            self.loginName = [self objectOrNilForKey:kUserInfoBaseClassLoginName fromDictionary:dict];
            self.vipType = [self objectOrNilForKey:kUserInfoBaseClassVipType fromDictionary:dict];
            self.companyName = [self objectOrNilForKey:kUserInfoBaseClassCompanyName fromDictionary:dict];
            self.nikeName = [self objectOrNilForKey:kUserInfoBaseClassNikeName fromDictionary:dict];
            self.categoryNames = [self objectOrNilForKey:kUserInfoBaseClassCategoryNames fromDictionary:dict];
            self.resultCode = [[self objectOrNilForKey:kUserInfoBaseClassResultCode fromDictionary:dict] doubleValue];
//            self.regType = [self objectOrNilForKey:kUserInfoBaseClassRegType fromDictionary:dict];
           self.regType = [ToolClass registTyple:[self objectOrNilForKey:kUserInfoBaseClassRegType fromDictionary:dict]];
            self.companyPhone = [self objectOrNilForKey:kUserInfoBaseClassCompanyPhone fromDictionary:dict];
            self.email = [self objectOrNilForKey:kUserInfoBaseClassEmail fromDictionary:dict];
            self.areaCode = [self objectOrNilForKey:kUserInfoBaseClassAreaCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.areaName forKey:kUserInfoBaseClassAreaName];
    NSMutableArray *tempArrayForCategorys = [NSMutableArray array];
    for (NSObject *subArrayObject in self.categorys) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCategorys addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCategorys addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCategorys] forKey:kUserInfoBaseClassCategorys];
    [mutableDict setValue:self.memberType forKey:kUserInfoBaseClassMemberType];
    [mutableDict setValue:self.headImg forKey:kUserInfoBaseClassHeadImg];
    [mutableDict setValue:self.mobile forKey:kUserInfoBaseClassMobile];
    [mutableDict setValue:self.resultMessage forKey:kUserInfoBaseClassResultMessage];
    [mutableDict setValue:self.loginName forKey:kUserInfoBaseClassLoginName];
    [mutableDict setValue:self.vipType forKey:kUserInfoBaseClassVipType];
    [mutableDict setValue:self.companyName forKey:kUserInfoBaseClassCompanyName];
    [mutableDict setValue:self.nikeName forKey:kUserInfoBaseClassNikeName];
    NSMutableArray *tempArrayForCategoryNames = [NSMutableArray array];
    for (NSObject *subArrayObject in self.categoryNames) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCategoryNames addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCategoryNames addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCategoryNames] forKey:kUserInfoBaseClassCategoryNames];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultCode] forKey:kUserInfoBaseClassResultCode];
    [mutableDict setValue:self.regType forKey:kUserInfoBaseClassRegType];
    [mutableDict setValue:self.companyPhone forKey:kUserInfoBaseClassCompanyPhone];
    [mutableDict setValue:self.email forKey:kUserInfoBaseClassEmail];
    [mutableDict setValue:self.areaCode forKey:kUserInfoBaseClassAreaCode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.areaName = [aDecoder decodeObjectForKey:kUserInfoBaseClassAreaName];
    self.categorys = [aDecoder decodeObjectForKey:kUserInfoBaseClassCategorys];
    self.memberType = [aDecoder decodeObjectForKey:kUserInfoBaseClassMemberType];
    self.headImg = [aDecoder decodeObjectForKey:kUserInfoBaseClassHeadImg];
    self.mobile = [aDecoder decodeObjectForKey:kUserInfoBaseClassMobile];
    self.resultMessage = [aDecoder decodeObjectForKey:kUserInfoBaseClassResultMessage];
    self.loginName = [aDecoder decodeObjectForKey:kUserInfoBaseClassLoginName];
    self.vipType = [aDecoder decodeObjectForKey:kUserInfoBaseClassVipType];
    self.companyName = [aDecoder decodeObjectForKey:kUserInfoBaseClassCompanyName];
    self.nikeName = [aDecoder decodeObjectForKey:kUserInfoBaseClassNikeName];
    self.categoryNames = [aDecoder decodeObjectForKey:kUserInfoBaseClassCategoryNames];
    self.resultCode = [aDecoder decodeDoubleForKey:kUserInfoBaseClassResultCode];
    self.regType = [aDecoder decodeObjectForKey:kUserInfoBaseClassRegType];
    self.companyPhone = [aDecoder decodeObjectForKey:kUserInfoBaseClassCompanyPhone];
    self.email = [aDecoder decodeObjectForKey:kUserInfoBaseClassEmail];
    self.areaCode = [aDecoder decodeObjectForKey:kUserInfoBaseClassAreaCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_areaName forKey:kUserInfoBaseClassAreaName];
    [aCoder encodeObject:_categorys forKey:kUserInfoBaseClassCategorys];
    [aCoder encodeObject:_memberType forKey:kUserInfoBaseClassMemberType];
    [aCoder encodeObject:_headImg forKey:kUserInfoBaseClassHeadImg];
    [aCoder encodeObject:_mobile forKey:kUserInfoBaseClassMobile];
    [aCoder encodeObject:_resultMessage forKey:kUserInfoBaseClassResultMessage];
    [aCoder encodeObject:_loginName forKey:kUserInfoBaseClassLoginName];
    [aCoder encodeObject:_vipType forKey:kUserInfoBaseClassVipType];
    [aCoder encodeObject:_companyName forKey:kUserInfoBaseClassCompanyName];
    [aCoder encodeObject:_nikeName forKey:kUserInfoBaseClassNikeName];
    [aCoder encodeObject:_categoryNames forKey:kUserInfoBaseClassCategoryNames];
    [aCoder encodeDouble:_resultCode forKey:kUserInfoBaseClassResultCode];
    [aCoder encodeObject:_regType forKey:kUserInfoBaseClassRegType];
    [aCoder encodeObject:_companyPhone forKey:kUserInfoBaseClassCompanyPhone];
    [aCoder encodeObject:_email forKey:kUserInfoBaseClassEmail];
    [aCoder encodeObject:_areaCode forKey:kUserInfoBaseClassAreaCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserInfoBaseClass *copy = [[UserInfoBaseClass alloc] init];
    
    if (copy) {

        copy.areaName = [self.areaName copyWithZone:zone];
        copy.categorys = [self.categorys copyWithZone:zone];
        copy.memberType = [self.memberType copyWithZone:zone];
        copy.headImg = [self.headImg copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.resultMessage = [self.resultMessage copyWithZone:zone];
        copy.loginName = [self.loginName copyWithZone:zone];
        copy.vipType = [self.vipType copyWithZone:zone];
        copy.companyName = [self.companyName copyWithZone:zone];
        copy.nikeName = [self.nikeName copyWithZone:zone];
        copy.categoryNames = [self.categoryNames copyWithZone:zone];
        copy.resultCode = self.resultCode;
        copy.regType = [self.regType copyWithZone:zone];
        copy.companyPhone = [self.companyPhone copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.areaCode = [self.areaCode copyWithZone:zone];
    }
    
    return copy;
}


@end
