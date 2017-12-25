//
//  MyPrivilegeList.m
//
//  Created by feijiu 1 on 2017/12/25
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "MyPrivilegeList.h"


NSString *const kMyPrivilegeListProductCode = @"product_code";
NSString *const kMyPrivilegeListProductName = @"product_name";
NSString *const kMyPrivilegeListTime = @"time";


@interface MyPrivilegeList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MyPrivilegeList

@synthesize productCode = _productCode;
@synthesize productName = _productName;
@synthesize time = _time;


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
            self.productCode = [self objectOrNilForKey:kMyPrivilegeListProductCode fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kMyPrivilegeListProductName fromDictionary:dict];
            self.time = [self objectOrNilForKey:kMyPrivilegeListTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productCode forKey:kMyPrivilegeListProductCode];
    [mutableDict setValue:self.productName forKey:kMyPrivilegeListProductName];
    [mutableDict setValue:self.time forKey:kMyPrivilegeListTime];

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

    self.productCode = [aDecoder decodeObjectForKey:kMyPrivilegeListProductCode];
    self.productName = [aDecoder decodeObjectForKey:kMyPrivilegeListProductName];
    self.time = [aDecoder decodeObjectForKey:kMyPrivilegeListTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productCode forKey:kMyPrivilegeListProductCode];
    [aCoder encodeObject:_productName forKey:kMyPrivilegeListProductName];
    [aCoder encodeObject:_time forKey:kMyPrivilegeListTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    MyPrivilegeList *copy = [[MyPrivilegeList alloc] init];
    
    if (copy) {

        copy.productCode = [self.productCode copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
    }
    
    return copy;
}


@end
