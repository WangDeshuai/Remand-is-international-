//
//  HomeViewList.m
//
//  Created by feijiu 1 on 2017/12/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "HomeViewList.h"


NSString *const kHomeViewListProductCode = @"product_code";
NSString *const kHomeViewListProductType = @"product_type";
NSString *const kHomeViewListReleaseTime = @"release_time";
NSString *const kHomeViewListProductName = @"product_name";


@interface HomeViewList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeViewList

@synthesize productCode = _productCode;
@synthesize productType = _productType;
@synthesize releaseTime = _releaseTime;
@synthesize productName = _productName;


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
            self.productCode = [self objectOrNilForKey:kHomeViewListProductCode fromDictionary:dict];
            self.productType = [self objectOrNilForKey:kHomeViewListProductType fromDictionary:dict];
            self.releaseTime = [self objectOrNilForKey:kHomeViewListReleaseTime fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kHomeViewListProductName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productCode forKey:kHomeViewListProductCode];
    [mutableDict setValue:self.productType forKey:kHomeViewListProductType];
    [mutableDict setValue:self.releaseTime forKey:kHomeViewListReleaseTime];
    [mutableDict setValue:self.productName forKey:kHomeViewListProductName];

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

    self.productCode = [aDecoder decodeObjectForKey:kHomeViewListProductCode];
    self.productType = [aDecoder decodeObjectForKey:kHomeViewListProductType];
    self.releaseTime = [aDecoder decodeObjectForKey:kHomeViewListReleaseTime];
    self.productName = [aDecoder decodeObjectForKey:kHomeViewListProductName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productCode forKey:kHomeViewListProductCode];
    [aCoder encodeObject:_productType forKey:kHomeViewListProductType];
    [aCoder encodeObject:_releaseTime forKey:kHomeViewListReleaseTime];
    [aCoder encodeObject:_productName forKey:kHomeViewListProductName];
}

- (id)copyWithZone:(NSZone *)zone
{
    HomeViewList *copy = [[HomeViewList alloc] init];
    
    if (copy) {

        copy.productCode = [self.productCode copyWithZone:zone];
        copy.productType = [self.productType copyWithZone:zone];
        copy.releaseTime = [self.releaseTime copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
    }
    
    return copy;
}


@end
