//
//  PurchaseModel.m
//
//  Created by feijiu 1 on 2017/12/27
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "PurchaseModel.h"
//#import "PurchaseCategory.h"


NSString *const kPurchaseModelIsShow = @"isShow";
NSString *const kPurchaseModelProductStock = @"productStock";
NSString *const kPurchaseModelCategory = @"category";
NSString *const kPurchaseModelProductType = @"productType";
NSString *const kPurchaseModelBook = @"book";
NSString *const kPurchaseModelProductPriceWithoutTax = @"productPriceWithoutTax";
NSString *const kPurchaseModelResultMessage = @"resultMessage";
NSString *const kPurchaseModelProductName = @"productName";
NSString *const kPurchaseModelProductDescribe = @"productDescribe";
NSString *const kPurchaseModelProductCategory = @"productCategory";
NSString *const kPurchaseModelProductCode = @"productCode";
NSString *const kPurchaseModelProductArea = @"productArea";
NSString *const kPurchaseModelVisitNum = @"visitNum";
NSString *const kPurchaseModelImage = @"image";
NSString *const kPurchaseModelResultCode = @"resultCode";
NSString *const kPurchaseModelUpordown = @"upordown";
NSString *const kPurchaseModelStockUnits = @"stockUnits";
NSString *const kPurchaseModelReleaseTime = @"releaseTime";
NSString *const kPurchaseModelCollection = @"collection";


@interface PurchaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PurchaseModel

@synthesize isShow = _isShow;
@synthesize productStock = _productStock;
@synthesize category = _category;
@synthesize productType = _productType;
@synthesize book = _book;
@synthesize productPriceWithoutTax = _productPriceWithoutTax;
@synthesize resultMessage = _resultMessage;
@synthesize productName = _productName;
@synthesize productDescribe = _productDescribe;
@synthesize productCategory = _productCategory;
@synthesize productCode = _productCode;
@synthesize productArea = _productArea;
@synthesize visitNum = _visitNum;
@synthesize image = _image;
@synthesize resultCode = _resultCode;
@synthesize upordown = _upordown;
@synthesize stockUnits = _stockUnits;
@synthesize releaseTime = _releaseTime;
@synthesize collection = _collection;


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
            self.isShow = [self objectOrNilForKey:kPurchaseModelIsShow fromDictionary:dict];
            self.productStock = [[self objectOrNilForKey:kPurchaseModelProductStock fromDictionary:dict] doubleValue];
//            self.category = [PurchaseCategory modelObjectWithDictionary:[dict objectForKey:kPurchaseModelCategory]];
            self.productType = [self objectOrNilForKey:kPurchaseModelProductType fromDictionary:dict];
            self.book = [[self objectOrNilForKey:kPurchaseModelBook fromDictionary:dict] boolValue];
            self.productPriceWithoutTax = [[self objectOrNilForKey:kPurchaseModelProductPriceWithoutTax fromDictionary:dict] doubleValue];
            self.resultMessage = [self objectOrNilForKey:kPurchaseModelResultMessage fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kPurchaseModelProductName fromDictionary:dict];
            self.productDescribe = [self objectOrNilForKey:kPurchaseModelProductDescribe fromDictionary:dict];
            self.productCategory = [self objectOrNilForKey:kPurchaseModelProductCategory fromDictionary:dict];
            self.productCode = [self objectOrNilForKey:kPurchaseModelProductCode fromDictionary:dict];
            self.productArea = [self objectOrNilForKey:kPurchaseModelProductArea fromDictionary:dict];
            self.visitNum = [[self objectOrNilForKey:kPurchaseModelVisitNum fromDictionary:dict] doubleValue];
            self.image = [self objectOrNilForKey:kPurchaseModelImage fromDictionary:dict];
            self.resultCode = [[self objectOrNilForKey:kPurchaseModelResultCode fromDictionary:dict] doubleValue];
            self.upordown = [self objectOrNilForKey:kPurchaseModelUpordown fromDictionary:dict];
            self.stockUnits = [self objectOrNilForKey:kPurchaseModelStockUnits fromDictionary:dict];
            self.releaseTime = [self objectOrNilForKey:kPurchaseModelReleaseTime fromDictionary:dict];
            self.collection = [[self objectOrNilForKey:kPurchaseModelCollection fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isShow forKey:kPurchaseModelIsShow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productStock] forKey:kPurchaseModelProductStock];
//    [mutableDict setValue:[self.category dictionaryRepresentation] forKey:kPurchaseModelCategory];
    [mutableDict setValue:self.productType forKey:kPurchaseModelProductType];
    [mutableDict setValue:[NSNumber numberWithBool:self.book] forKey:kPurchaseModelBook];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productPriceWithoutTax] forKey:kPurchaseModelProductPriceWithoutTax];
    [mutableDict setValue:self.resultMessage forKey:kPurchaseModelResultMessage];
    [mutableDict setValue:self.productName forKey:kPurchaseModelProductName];
    [mutableDict setValue:self.productDescribe forKey:kPurchaseModelProductDescribe];
    [mutableDict setValue:self.productCategory forKey:kPurchaseModelProductCategory];
    [mutableDict setValue:self.productCode forKey:kPurchaseModelProductCode];
    [mutableDict setValue:self.productArea forKey:kPurchaseModelProductArea];
    [mutableDict setValue:[NSNumber numberWithDouble:self.visitNum] forKey:kPurchaseModelVisitNum];
    NSMutableArray *tempArrayForImage = [NSMutableArray array];
    for (NSObject *subArrayObject in self.image) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImage addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImage addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImage] forKey:kPurchaseModelImage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultCode] forKey:kPurchaseModelResultCode];
    [mutableDict setValue:self.upordown forKey:kPurchaseModelUpordown];
    [mutableDict setValue:self.stockUnits forKey:kPurchaseModelStockUnits];
    [mutableDict setValue:self.releaseTime forKey:kPurchaseModelReleaseTime];
    [mutableDict setValue:[NSNumber numberWithBool:self.collection] forKey:kPurchaseModelCollection];

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

    self.isShow = [aDecoder decodeObjectForKey:kPurchaseModelIsShow];
    self.productStock = [aDecoder decodeDoubleForKey:kPurchaseModelProductStock];
    self.category = [aDecoder decodeObjectForKey:kPurchaseModelCategory];
    self.productType = [aDecoder decodeObjectForKey:kPurchaseModelProductType];
    self.book = [aDecoder decodeBoolForKey:kPurchaseModelBook];
    self.productPriceWithoutTax = [aDecoder decodeDoubleForKey:kPurchaseModelProductPriceWithoutTax];
    self.resultMessage = [aDecoder decodeObjectForKey:kPurchaseModelResultMessage];
    self.productName = [aDecoder decodeObjectForKey:kPurchaseModelProductName];
    self.productDescribe = [aDecoder decodeObjectForKey:kPurchaseModelProductDescribe];
    self.productCategory = [aDecoder decodeObjectForKey:kPurchaseModelProductCategory];
    self.productCode = [aDecoder decodeObjectForKey:kPurchaseModelProductCode];
    self.productArea = [aDecoder decodeObjectForKey:kPurchaseModelProductArea];
    self.visitNum = [aDecoder decodeDoubleForKey:kPurchaseModelVisitNum];
    self.image = [aDecoder decodeObjectForKey:kPurchaseModelImage];
    self.resultCode = [aDecoder decodeDoubleForKey:kPurchaseModelResultCode];
    self.upordown = [aDecoder decodeObjectForKey:kPurchaseModelUpordown];
    self.stockUnits = [aDecoder decodeObjectForKey:kPurchaseModelStockUnits];
    self.releaseTime = [aDecoder decodeObjectForKey:kPurchaseModelReleaseTime];
    self.collection = [aDecoder decodeBoolForKey:kPurchaseModelCollection];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isShow forKey:kPurchaseModelIsShow];
    [aCoder encodeDouble:_productStock forKey:kPurchaseModelProductStock];
    [aCoder encodeObject:_category forKey:kPurchaseModelCategory];
    [aCoder encodeObject:_productType forKey:kPurchaseModelProductType];
    [aCoder encodeBool:_book forKey:kPurchaseModelBook];
    [aCoder encodeDouble:_productPriceWithoutTax forKey:kPurchaseModelProductPriceWithoutTax];
    [aCoder encodeObject:_resultMessage forKey:kPurchaseModelResultMessage];
    [aCoder encodeObject:_productName forKey:kPurchaseModelProductName];
    [aCoder encodeObject:_productDescribe forKey:kPurchaseModelProductDescribe];
    [aCoder encodeObject:_productCategory forKey:kPurchaseModelProductCategory];
    [aCoder encodeObject:_productCode forKey:kPurchaseModelProductCode];
    [aCoder encodeObject:_productArea forKey:kPurchaseModelProductArea];
    [aCoder encodeDouble:_visitNum forKey:kPurchaseModelVisitNum];
    [aCoder encodeObject:_image forKey:kPurchaseModelImage];
    [aCoder encodeDouble:_resultCode forKey:kPurchaseModelResultCode];
    [aCoder encodeObject:_upordown forKey:kPurchaseModelUpordown];
    [aCoder encodeObject:_stockUnits forKey:kPurchaseModelStockUnits];
    [aCoder encodeObject:_releaseTime forKey:kPurchaseModelReleaseTime];
    [aCoder encodeBool:_collection forKey:kPurchaseModelCollection];
}

- (id)copyWithZone:(NSZone *)zone
{
    PurchaseModel *copy = [[PurchaseModel alloc] init];
    
    if (copy) {

        copy.isShow = [self.isShow copyWithZone:zone];
        copy.productStock = self.productStock;
//        copy.category = [self.category copyWithZone:zone];
        copy.productType = [self.productType copyWithZone:zone];
        copy.book = self.book;
        copy.productPriceWithoutTax = self.productPriceWithoutTax;
        copy.resultMessage = [self.resultMessage copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.productDescribe = [self.productDescribe copyWithZone:zone];
        copy.productCategory = [self.productCategory copyWithZone:zone];
        copy.productCode = [self.productCode copyWithZone:zone];
        copy.productArea = [self.productArea copyWithZone:zone];
        copy.visitNum = self.visitNum;
        copy.image = [self.image copyWithZone:zone];
        copy.resultCode = self.resultCode;
        copy.upordown = [self.upordown copyWithZone:zone];
        copy.stockUnits = [self.stockUnits copyWithZone:zone];
        copy.releaseTime = [self.releaseTime copyWithZone:zone];
        copy.collection = self.collection;
    }
    
    return copy;
}


@end
