//
//  ReleaseModel.m
//
//  Created by feijiu 02 on 2017/12/25
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ReleaseModel.h"


NSString *const kReleaseModelProductStock = @"productStock";
NSString *const kReleaseModelProductType = @"productType";
NSString *const kReleaseModelUid = @"uid";
NSString *const kReleaseModelProductPriceWithoutTax = @"productPriceWithoutTax";
NSString *const kReleaseModelResultMessage = @"resultMessage";
NSString *const kReleaseModelProductName = @"productName";
NSString *const kReleaseModelProductDescribe = @"productDescribe";
NSString *const kReleaseModelProductCategory = @"productCategory";
NSString *const kReleaseModelProductArea = @"productArea";
NSString *const kReleaseModelImage = @"image";
NSString *const kReleaseModelResultCode = @"resultCode";
NSString *const kReleaseModelStockUnits = @"stockUnits";
NSString *const kReleaseModelExpiryTime = @"expiryTime";
NSString *const kReleaseModelProductCategoryName = @"productCategoryName";
NSString *const kReleaseModelProductAreaName = @"productAreaName";

@interface ReleaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ReleaseModel

@synthesize productStock = _productStock;
@synthesize productType = _productType;
@synthesize uid = _uid;
@synthesize productPriceWithoutTax = _productPriceWithoutTax;
@synthesize resultMessage = _resultMessage;
@synthesize productName = _productName;
@synthesize productDescribe = _productDescribe;
@synthesize productCategory = _productCategory;
@synthesize productArea = _productArea;
@synthesize image = _image;
@synthesize resultCode = _resultCode;
@synthesize stockUnits = _stockUnits;
@synthesize expiryTime = _expiryTime;
@synthesize productCategoryName = _productCategoryName;
@synthesize productAreaName = _productAreaName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.productStock = [self objectOrNilForKey:kReleaseModelProductStock fromDictionary:dict];
            self.productType = [self objectOrNilForKey:kReleaseModelProductType fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kReleaseModelUid fromDictionary:dict];
            self.productPriceWithoutTax = [self objectOrNilForKey:kReleaseModelProductPriceWithoutTax fromDictionary:dict];
            self.resultMessage = [self objectOrNilForKey:kReleaseModelResultMessage fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kReleaseModelProductName fromDictionary:dict];
            self.productDescribe = [self objectOrNilForKey:kReleaseModelProductDescribe fromDictionary:dict];
            self.productCategory = [self objectOrNilForKey:kReleaseModelProductCategory fromDictionary:dict];
            NSString *addressCode = [self objectOrNilForKey:kReleaseModelProductArea fromDictionary:dict];
            NSArray *addressCodeArr =[addressCode componentsSeparatedByString:@"_"];
            self.CountryCode = addressCodeArr.firstObject;
            self.productArea = addressCodeArr.lastObject;
//            self.productArea = [self objectOrNilForKey:kReleaseModelProductArea fromDictionary:dict];
            self.image = [self objectOrNilForKey:kReleaseModelImage fromDictionary:dict];
            self.resultCode = [self objectOrNilForKey:kReleaseModelResultCode fromDictionary:dict];
            self.stockUnits = [self objectOrNilForKey:kReleaseModelStockUnits fromDictionary:dict];
            self.expiryTime = [self objectOrNilForKey:kReleaseModelExpiryTime fromDictionary:dict];
            self.productCategoryName = [self objectOrNilForKey:kReleaseModelProductCategoryName fromDictionary:dict];
            NSString *addressStr = [self objectOrNilForKey:kReleaseModelProductAreaName fromDictionary:dict];
            NSArray *addressArr =[addressStr componentsSeparatedByString:@"_"];
            self.Country = addressArr.firstObject;
            self.productAreaName = addressArr.lastObject;
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productStock forKey:kReleaseModelProductStock];
    [mutableDict setValue:self.productType forKey:kReleaseModelProductType];
    [mutableDict setValue:self.uid forKey:kReleaseModelUid];
    [mutableDict setValue:self.productPriceWithoutTax forKey:kReleaseModelProductPriceWithoutTax];
    [mutableDict setValue:self.resultMessage forKey:kReleaseModelResultMessage];
    [mutableDict setValue:self.productName forKey:kReleaseModelProductName];
    [mutableDict setValue:self.productDescribe forKey:kReleaseModelProductDescribe];
    [mutableDict setValue:self.productCategory forKey:kReleaseModelProductCategory];
    [mutableDict setValue:self.productArea forKey:kReleaseModelProductArea];
    [mutableDict setValue:self.productCategoryName forKey:kReleaseModelProductCategoryName];
    [mutableDict setValue:self.productAreaName forKey:kReleaseModelProductAreaName];
    [mutableDict setValue:self.Country forKey:@"Country"];
    [mutableDict setValue:self.stockUnitsName forKey:@"stockUnitsName"];
    [mutableDict setValue:self.CountryCode forKey:@"CountryCode"];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImage] forKey:kReleaseModelImage];
    [mutableDict setValue:self.resultCode forKey:kReleaseModelResultCode];
    [mutableDict setValue:self.stockUnits forKey:kReleaseModelStockUnits];
    [mutableDict setValue:self.expiryTime forKey:kReleaseModelExpiryTime];

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
    if (![object isKindOfClass:[NSArray class]] && ![object isKindOfClass:[NSDictionary class]]) {
        NSString *str = [NSString stringWithFormat:@"%@",object];
//        object = [str containsString:@"null"]?@"":str;
        object = [ToolClass isString:str];
    }
    return [object isEqual:[NSNull null]] ? nil : object;
}
- (void)setStockUnits:(NSString *)stockUnits
{
    NSDictionary *dic = @{@"4497003000020002":@"￥", @"4497003000020003":@"$",@"4497003000020004":@"€"};
    self.stockUnitsName = dic[stockUnits];
    _stockUnits = stockUnits;
}
@end
