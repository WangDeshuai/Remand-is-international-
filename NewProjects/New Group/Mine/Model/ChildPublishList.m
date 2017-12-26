//
//  ChildPublishList.m
//
//  Created by feijiu 1 on 2017/12/26
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ChildPublishList.h"


NSString *const kChildPublishListUuid = @"uuid";
NSString *const kChildPublishListProductStock = @"productStock";
NSString *const kChildPublishListProductType = @"productType";
NSString *const kChildPublishListProductPriceWithoutTax = @"productPriceWithoutTax";
NSString *const kChildPublishListProductCategory = @"productCategory";
NSString *const kChildPublishListProductName = @"productName";
NSString *const kChildPublishListUpordown = @"upordown";
NSString *const kChildPublishListProductCode = @"productCode";
NSString *const kChildPublishListRejectContent = @"rejectContent";
NSString *const kChildPublishListIsStatus = @"isStatus";
NSString *const kChildPublishListImage = @"image";
NSString *const kChildPublishListAddress = @"address";
NSString *const kChildPublishListSellerCodeT = @"seller_code_t";
NSString *const kChildPublishListStockUnits = @"stockUnits";
NSString *const kChildPublishListExpiryTime = @"expiryTime";


@interface ChildPublishList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ChildPublishList

@synthesize uuid = _uuid;
@synthesize productStock = _productStock;
@synthesize productType = _productType;
@synthesize productPriceWithoutTax = _productPriceWithoutTax;
@synthesize productCategory = _productCategory;
@synthesize productName = _productName;
@synthesize upordown = _upordown;
@synthesize productCode = _productCode;
@synthesize rejectContent = _rejectContent;
@synthesize isStatus = _isStatus;
@synthesize image = _image;
@synthesize address = _address;
@synthesize sellerCodeT = _sellerCodeT;
@synthesize stockUnits = _stockUnits;
@synthesize expiryTime = _expiryTime;


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
            self.uuid = [self objectOrNilForKey:kChildPublishListUuid fromDictionary:dict];
            self.productStock = [[self objectOrNilForKey:kChildPublishListProductStock fromDictionary:dict] doubleValue];
            self.productType = [self objectOrNilForKey:kChildPublishListProductType fromDictionary:dict];
            self.productPriceWithoutTax = [[self objectOrNilForKey:kChildPublishListProductPriceWithoutTax fromDictionary:dict] doubleValue];
            self.productCategory = [self objectOrNilForKey:kChildPublishListProductCategory fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kChildPublishListProductName fromDictionary:dict];
            self.upordown = [self objectOrNilForKey:kChildPublishListUpordown fromDictionary:dict];
            self.productCode = [self objectOrNilForKey:kChildPublishListProductCode fromDictionary:dict];
            self.rejectContent = [self objectOrNilForKey:kChildPublishListRejectContent fromDictionary:dict];
            self.isStatus = [self objectOrNilForKey:kChildPublishListIsStatus fromDictionary:dict];
            self.image = [self objectOrNilForKey:kChildPublishListImage fromDictionary:dict];
            self.address = [self objectOrNilForKey:kChildPublishListAddress fromDictionary:dict];
            self.sellerCodeT = [self objectOrNilForKey:kChildPublishListSellerCodeT fromDictionary:dict];
            self.stockUnits = [self objectOrNilForKey:kChildPublishListStockUnits fromDictionary:dict];
            self.expiryTime = [self objectOrNilForKey:kChildPublishListExpiryTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.uuid forKey:kChildPublishListUuid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productStock] forKey:kChildPublishListProductStock];
    [mutableDict setValue:self.productType forKey:kChildPublishListProductType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productPriceWithoutTax] forKey:kChildPublishListProductPriceWithoutTax];
    [mutableDict setValue:self.productCategory forKey:kChildPublishListProductCategory];
    [mutableDict setValue:self.productName forKey:kChildPublishListProductName];
    [mutableDict setValue:self.upordown forKey:kChildPublishListUpordown];
    [mutableDict setValue:self.productCode forKey:kChildPublishListProductCode];
    [mutableDict setValue:self.rejectContent forKey:kChildPublishListRejectContent];
    [mutableDict setValue:self.isStatus forKey:kChildPublishListIsStatus];
    [mutableDict setValue:self.image forKey:kChildPublishListImage];
    [mutableDict setValue:self.address forKey:kChildPublishListAddress];
    [mutableDict setValue:self.sellerCodeT forKey:kChildPublishListSellerCodeT];
    [mutableDict setValue:self.stockUnits forKey:kChildPublishListStockUnits];
    [mutableDict setValue:self.expiryTime forKey:kChildPublishListExpiryTime];

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

    self.uuid = [aDecoder decodeObjectForKey:kChildPublishListUuid];
    self.productStock = [aDecoder decodeDoubleForKey:kChildPublishListProductStock];
    self.productType = [aDecoder decodeObjectForKey:kChildPublishListProductType];
    self.productPriceWithoutTax = [aDecoder decodeDoubleForKey:kChildPublishListProductPriceWithoutTax];
    self.productCategory = [aDecoder decodeObjectForKey:kChildPublishListProductCategory];
    self.productName = [aDecoder decodeObjectForKey:kChildPublishListProductName];
    self.upordown = [aDecoder decodeObjectForKey:kChildPublishListUpordown];
    self.productCode = [aDecoder decodeObjectForKey:kChildPublishListProductCode];
    self.rejectContent = [aDecoder decodeObjectForKey:kChildPublishListRejectContent];
    self.isStatus = [aDecoder decodeObjectForKey:kChildPublishListIsStatus];
    self.image = [aDecoder decodeObjectForKey:kChildPublishListImage];
    self.address = [aDecoder decodeObjectForKey:kChildPublishListAddress];
    self.sellerCodeT = [aDecoder decodeObjectForKey:kChildPublishListSellerCodeT];
    self.stockUnits = [aDecoder decodeObjectForKey:kChildPublishListStockUnits];
    self.expiryTime = [aDecoder decodeObjectForKey:kChildPublishListExpiryTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_uuid forKey:kChildPublishListUuid];
    [aCoder encodeDouble:_productStock forKey:kChildPublishListProductStock];
    [aCoder encodeObject:_productType forKey:kChildPublishListProductType];
    [aCoder encodeDouble:_productPriceWithoutTax forKey:kChildPublishListProductPriceWithoutTax];
    [aCoder encodeObject:_productCategory forKey:kChildPublishListProductCategory];
    [aCoder encodeObject:_productName forKey:kChildPublishListProductName];
    [aCoder encodeObject:_upordown forKey:kChildPublishListUpordown];
    [aCoder encodeObject:_productCode forKey:kChildPublishListProductCode];
    [aCoder encodeObject:_rejectContent forKey:kChildPublishListRejectContent];
    [aCoder encodeObject:_isStatus forKey:kChildPublishListIsStatus];
    [aCoder encodeObject:_image forKey:kChildPublishListImage];
    [aCoder encodeObject:_address forKey:kChildPublishListAddress];
    [aCoder encodeObject:_sellerCodeT forKey:kChildPublishListSellerCodeT];
    [aCoder encodeObject:_stockUnits forKey:kChildPublishListStockUnits];
    [aCoder encodeObject:_expiryTime forKey:kChildPublishListExpiryTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ChildPublishList *copy = [[ChildPublishList alloc] init];
    
    if (copy) {

        copy.uuid = [self.uuid copyWithZone:zone];
        copy.productStock = self.productStock;
        copy.productType = [self.productType copyWithZone:zone];
        copy.productPriceWithoutTax = self.productPriceWithoutTax;
        copy.productCategory = [self.productCategory copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.upordown = [self.upordown copyWithZone:zone];
        copy.productCode = [self.productCode copyWithZone:zone];
        copy.rejectContent = [self.rejectContent copyWithZone:zone];
        copy.isStatus = [self.isStatus copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.sellerCodeT = [self.sellerCodeT copyWithZone:zone];
        copy.stockUnits = [self.stockUnits copyWithZone:zone];
        copy.expiryTime = [self.expiryTime copyWithZone:zone];
    }
    
    return copy;
}


@end
