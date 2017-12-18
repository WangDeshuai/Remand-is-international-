//
//  SuppleProduct.m
//
//  Created by feijiu 1 on 2017/12/18
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "SuppleProduct.h"


NSString *const kSuppleProductPositionY = @"positionY";
NSString *const kSuppleProductProductStatus = @"productStatus";
NSString *const kSuppleProductProductName = @"productName";
NSString *const kSuppleProductProductImage = @"productImage";
NSString *const kSuppleProductProductCode = @"productCode";
NSString *const kSuppleProductPrice = @"price";
NSString *const kSuppleProductAddress = @"address";
NSString *const kSuppleProductStockNum = @"stockNum";
NSString *const kSuppleProductProperties = @"properties";
NSString *const kSuppleProductStockUnits = @"stockUnits";
NSString *const kSuppleProductReleaseTime = @"releaseTime";
NSString *const kSuppleProductImgWidth = @"imgWidth";
NSString *const kSuppleProductImgHeight = @"imgHeight";


@interface SuppleProduct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SuppleProduct

@synthesize positionY = _positionY;
@synthesize productStatus = _productStatus;
@synthesize productName = _productName;
@synthesize productImage = _productImage;
@synthesize productCode = _productCode;
@synthesize price = _price;
@synthesize address = _address;
@synthesize stockNum = _stockNum;
@synthesize properties = _properties;
@synthesize stockUnits = _stockUnits;
@synthesize releaseTime = _releaseTime;
@synthesize imgWidth = _imgWidth;
@synthesize imgHeight = _imgHeight;


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
            self.positionY = [self objectOrNilForKey:kSuppleProductPositionY fromDictionary:dict];
            self.productStatus = [[self objectOrNilForKey:kSuppleProductProductStatus fromDictionary:dict] doubleValue];
            self.productName = [self objectOrNilForKey:kSuppleProductProductName fromDictionary:dict];
            self.productImage = [self objectOrNilForKey:kSuppleProductProductImage fromDictionary:dict];
            self.productCode = [self objectOrNilForKey:kSuppleProductProductCode fromDictionary:dict];
            self.price = [[self objectOrNilForKey:kSuppleProductPrice fromDictionary:dict] doubleValue];
            self.address = [self objectOrNilForKey:kSuppleProductAddress fromDictionary:dict];
            self.stockNum = [[self objectOrNilForKey:kSuppleProductStockNum fromDictionary:dict] doubleValue];
            self.properties = [self objectOrNilForKey:kSuppleProductProperties fromDictionary:dict];
            self.stockUnits = [self objectOrNilForKey:kSuppleProductStockUnits fromDictionary:dict];
            self.releaseTime = [self objectOrNilForKey:kSuppleProductReleaseTime fromDictionary:dict];
            self.imgWidth = [self objectOrNilForKey:kSuppleProductImgWidth fromDictionary:dict];
            self.imgHeight = [self objectOrNilForKey:kSuppleProductImgHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.positionY forKey:kSuppleProductPositionY];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productStatus] forKey:kSuppleProductProductStatus];
    [mutableDict setValue:self.productName forKey:kSuppleProductProductName];
    NSMutableArray *tempArrayForProductImage = [NSMutableArray array];
    for (NSObject *subArrayObject in self.productImage) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProductImage addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProductImage addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProductImage] forKey:kSuppleProductProductImage];
    [mutableDict setValue:self.productCode forKey:kSuppleProductProductCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kSuppleProductPrice];
    [mutableDict setValue:self.address forKey:kSuppleProductAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stockNum] forKey:kSuppleProductStockNum];
    NSMutableArray *tempArrayForProperties = [NSMutableArray array];
    for (NSObject *subArrayObject in self.properties) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProperties addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProperties addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProperties] forKey:kSuppleProductProperties];
    [mutableDict setValue:self.stockUnits forKey:kSuppleProductStockUnits];
    [mutableDict setValue:self.releaseTime forKey:kSuppleProductReleaseTime];
    [mutableDict setValue:self.imgWidth forKey:kSuppleProductImgWidth];
    [mutableDict setValue:self.imgHeight forKey:kSuppleProductImgHeight];

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

    self.positionY = [aDecoder decodeObjectForKey:kSuppleProductPositionY];
    self.productStatus = [aDecoder decodeDoubleForKey:kSuppleProductProductStatus];
    self.productName = [aDecoder decodeObjectForKey:kSuppleProductProductName];
    self.productImage = [aDecoder decodeObjectForKey:kSuppleProductProductImage];
    self.productCode = [aDecoder decodeObjectForKey:kSuppleProductProductCode];
    self.price = [aDecoder decodeDoubleForKey:kSuppleProductPrice];
    self.address = [aDecoder decodeObjectForKey:kSuppleProductAddress];
    self.stockNum = [aDecoder decodeDoubleForKey:kSuppleProductStockNum];
    self.properties = [aDecoder decodeObjectForKey:kSuppleProductProperties];
    self.stockUnits = [aDecoder decodeObjectForKey:kSuppleProductStockUnits];
    self.releaseTime = [aDecoder decodeObjectForKey:kSuppleProductReleaseTime];
    self.imgWidth = [aDecoder decodeObjectForKey:kSuppleProductImgWidth];
    self.imgHeight = [aDecoder decodeObjectForKey:kSuppleProductImgHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_positionY forKey:kSuppleProductPositionY];
    [aCoder encodeDouble:_productStatus forKey:kSuppleProductProductStatus];
    [aCoder encodeObject:_productName forKey:kSuppleProductProductName];
    [aCoder encodeObject:_productImage forKey:kSuppleProductProductImage];
    [aCoder encodeObject:_productCode forKey:kSuppleProductProductCode];
    [aCoder encodeDouble:_price forKey:kSuppleProductPrice];
    [aCoder encodeObject:_address forKey:kSuppleProductAddress];
    [aCoder encodeDouble:_stockNum forKey:kSuppleProductStockNum];
    [aCoder encodeObject:_properties forKey:kSuppleProductProperties];
    [aCoder encodeObject:_stockUnits forKey:kSuppleProductStockUnits];
    [aCoder encodeObject:_releaseTime forKey:kSuppleProductReleaseTime];
    [aCoder encodeObject:_imgWidth forKey:kSuppleProductImgWidth];
    [aCoder encodeObject:_imgHeight forKey:kSuppleProductImgHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    SuppleProduct *copy = [[SuppleProduct alloc] init];
    
    if (copy) {

        copy.positionY = [self.positionY copyWithZone:zone];
        copy.productStatus = self.productStatus;
        copy.productName = [self.productName copyWithZone:zone];
        copy.productImage = [self.productImage copyWithZone:zone];
        copy.productCode = [self.productCode copyWithZone:zone];
        copy.price = self.price;
        copy.address = [self.address copyWithZone:zone];
        copy.stockNum = self.stockNum;
        copy.properties = [self.properties copyWithZone:zone];
        copy.stockUnits = [self.stockUnits copyWithZone:zone];
        copy.releaseTime = [self.releaseTime copyWithZone:zone];
        copy.imgWidth = [self.imgWidth copyWithZone:zone];
        copy.imgHeight = [self.imgHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
