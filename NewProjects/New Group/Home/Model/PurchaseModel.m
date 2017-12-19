//
//  PurchaseModel.m
//
//  Created by feijiu 1 on 2017/12/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "PurchaseModel.h"
//#import "PurchaseCategory.h"
//#import "PurchaseSeller.h"


NSString *const kPurchaseModelProductDescribe = @"productDescribe";
NSString *const kPurchaseModelProductProperties = @"productProperties";
NSString *const kPurchaseModelCategory = @"category";
NSString *const kPurchaseModelProductImpurity = @"productImpurity";
NSString *const kPurchaseModelProductArea = @"productArea";
NSString *const kPurchaseModelProductMoisture = @"productMoisture";
NSString *const kPurchaseModelProductCategory = @"productCategory";
NSString *const kPurchaseModelPacking = @"packing";
NSString *const kPurchaseModelStockUnits = @"stockUnits";
NSString *const kPurchaseModelProductUse = @"productUse";
NSString *const kPurchaseModelCalciumContent = @"calciumContent";
NSString *const kPurchaseModelUuid = @"uuid";
NSString *const kPurchaseModelProductDensity = @"productDensity";
NSString *const kPurchaseModelProductCode = @"productCode";
NSString *const kPurchaseModelReleaseTime = @"releaseTime";
NSString *const kPurchaseModelProductPriceWithTax = @"productPriceWithTax";
NSString *const kPurchaseModelImage = @"image";
NSString *const kPurchaseModelMeshNumberLayer = @"meshNumberLayer";
NSString *const kPurchaseModelSeller = @"seller";
NSString *const kPurchaseModelProductDensityValue = @"productDensityValue";
NSString *const kPurchaseModelIsShow = @"isShow";
NSString *const kPurchaseModelProductType = @"productType";
NSString *const kPurchaseModelIsAcceptBook = @"is_accept_book";
NSString *const kPurchaseModelProvidService = @"provid_service";
NSString *const kPurchaseModelProductStock = @"productStock";
NSString *const kPurchaseModelCombustion = @"combustion";
NSString *const kPurchaseModelMeshNumberLook = @"meshNumberLook";
NSString *const kPurchaseModelProductColour = @"productColour";
NSString *const kPurchaseModelSinglePackWeight = @"singlePackWeight";
NSString *const kPurchaseModelReports = @"reports";
NSString *const kPurchaseModelResultMessage = @"resultMessage";
NSString *const kPurchaseModelProductPriceWithoutTax = @"productPriceWithoutTax";
NSString *const kPurchaseModelUpordown = @"upordown";
NSString *const kPurchaseModelCollection = @"collection";
NSString *const kPurchaseModelProductName = @"productName";
NSString *const kPurchaseModelProductMaterial = @"productMaterial";
NSString *const kPurchaseModelResultCode = @"resultCode";
NSString *const kPurchaseModelVisitNum = @"visitNum";


@interface PurchaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PurchaseModel

@synthesize productDescribe = _productDescribe;
@synthesize productProperties = _productProperties;
@synthesize category = _category;
@synthesize productImpurity = _productImpurity;
@synthesize productArea = _productArea;
@synthesize productMoisture = _productMoisture;
@synthesize productCategory = _productCategory;
@synthesize packing = _packing;
@synthesize stockUnits = _stockUnits;
@synthesize productUse = _productUse;
@synthesize calciumContent = _calciumContent;
@synthesize uuid = _uuid;
@synthesize productDensity = _productDensity;
@synthesize productCode = _productCode;
@synthesize releaseTime = _releaseTime;
@synthesize productPriceWithTax = _productPriceWithTax;
@synthesize image = _image;
@synthesize meshNumberLayer = _meshNumberLayer;
@synthesize seller = _seller;
@synthesize productDensityValue = _productDensityValue;
@synthesize isShow = _isShow;
@synthesize productType = _productType;
@synthesize isAcceptBook = _isAcceptBook;
@synthesize providService = _providService;
@synthesize productStock = _productStock;
@synthesize combustion = _combustion;
@synthesize meshNumberLook = _meshNumberLook;
@synthesize productColour = _productColour;
@synthesize singlePackWeight = _singlePackWeight;
@synthesize reports = _reports;
@synthesize resultMessage = _resultMessage;
@synthesize productPriceWithoutTax = _productPriceWithoutTax;
@synthesize upordown = _upordown;
@synthesize collection = _collection;
@synthesize productName = _productName;
@synthesize productMaterial = _productMaterial;
@synthesize resultCode = _resultCode;
@synthesize visitNum = _visitNum;


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
            self.productDescribe = [self objectOrNilForKey:kPurchaseModelProductDescribe fromDictionary:dict];
            self.productProperties = [self objectOrNilForKey:kPurchaseModelProductProperties fromDictionary:dict];
//            self.category = [PurchaseCategory modelObjectWithDictionary:[dict objectForKey:kPurchaseModelCategory]];
            self.productImpurity = [[self objectOrNilForKey:kPurchaseModelProductImpurity fromDictionary:dict] doubleValue];
            self.productArea = [self objectOrNilForKey:kPurchaseModelProductArea fromDictionary:dict];
            self.productMoisture = [[self objectOrNilForKey:kPurchaseModelProductMoisture fromDictionary:dict] doubleValue];
            self.productCategory = [self objectOrNilForKey:kPurchaseModelProductCategory fromDictionary:dict];
            self.packing = [self objectOrNilForKey:kPurchaseModelPacking fromDictionary:dict];
            self.stockUnits = [self objectOrNilForKey:kPurchaseModelStockUnits fromDictionary:dict];
            self.productUse = [self objectOrNilForKey:kPurchaseModelProductUse fromDictionary:dict];
            self.calciumContent = [self objectOrNilForKey:kPurchaseModelCalciumContent fromDictionary:dict];
            self.uuid = [self objectOrNilForKey:kPurchaseModelUuid fromDictionary:dict];
            self.productDensity = [self objectOrNilForKey:kPurchaseModelProductDensity fromDictionary:dict];
            self.productCode = [self objectOrNilForKey:kPurchaseModelProductCode fromDictionary:dict];
            self.releaseTime = [self objectOrNilForKey:kPurchaseModelReleaseTime fromDictionary:dict];
            self.productPriceWithTax = [[self objectOrNilForKey:kPurchaseModelProductPriceWithTax fromDictionary:dict] doubleValue];
            self.image = [self objectOrNilForKey:kPurchaseModelImage fromDictionary:dict];
            self.meshNumberLayer = [self objectOrNilForKey:kPurchaseModelMeshNumberLayer fromDictionary:dict];
//            self.seller = [PurchaseSeller modelObjectWithDictionary:[dict objectForKey:kPurchaseModelSeller]];
            self.productDensityValue = [self objectOrNilForKey:kPurchaseModelProductDensityValue fromDictionary:dict];
            self.isShow = [self objectOrNilForKey:kPurchaseModelIsShow fromDictionary:dict];
            self.productType = [self objectOrNilForKey:kPurchaseModelProductType fromDictionary:dict];
            self.isAcceptBook = [self objectOrNilForKey:kPurchaseModelIsAcceptBook fromDictionary:dict];
            self.providService = [self objectOrNilForKey:kPurchaseModelProvidService fromDictionary:dict];
            self.productStock = [[self objectOrNilForKey:kPurchaseModelProductStock fromDictionary:dict] doubleValue];
            self.combustion = [self objectOrNilForKey:kPurchaseModelCombustion fromDictionary:dict];
            self.meshNumberLook = [self objectOrNilForKey:kPurchaseModelMeshNumberLook fromDictionary:dict];
            self.productColour = [self objectOrNilForKey:kPurchaseModelProductColour fromDictionary:dict];
            self.singlePackWeight = [[self objectOrNilForKey:kPurchaseModelSinglePackWeight fromDictionary:dict] doubleValue];
            self.reports = [self objectOrNilForKey:kPurchaseModelReports fromDictionary:dict];
            self.resultMessage = [self objectOrNilForKey:kPurchaseModelResultMessage fromDictionary:dict];
            self.productPriceWithoutTax = [[self objectOrNilForKey:kPurchaseModelProductPriceWithoutTax fromDictionary:dict] doubleValue];
            self.upordown = [self objectOrNilForKey:kPurchaseModelUpordown fromDictionary:dict];
            self.collection = [[self objectOrNilForKey:kPurchaseModelCollection fromDictionary:dict] boolValue];
            self.productName = [self objectOrNilForKey:kPurchaseModelProductName fromDictionary:dict];
            self.productMaterial = [self objectOrNilForKey:kPurchaseModelProductMaterial fromDictionary:dict];
            self.resultCode = [[self objectOrNilForKey:kPurchaseModelResultCode fromDictionary:dict] doubleValue];
            self.visitNum = [[self objectOrNilForKey:kPurchaseModelVisitNum fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productDescribe forKey:kPurchaseModelProductDescribe];
    [mutableDict setValue:self.productProperties forKey:kPurchaseModelProductProperties];
//    [mutableDict setValue:[self.category dictionaryRepresentation] forKey:kPurchaseModelCategory];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productImpurity] forKey:kPurchaseModelProductImpurity];
    [mutableDict setValue:self.productArea forKey:kPurchaseModelProductArea];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productMoisture] forKey:kPurchaseModelProductMoisture];
    [mutableDict setValue:self.productCategory forKey:kPurchaseModelProductCategory];
    [mutableDict setValue:self.packing forKey:kPurchaseModelPacking];
    [mutableDict setValue:self.stockUnits forKey:kPurchaseModelStockUnits];
    [mutableDict setValue:self.productUse forKey:kPurchaseModelProductUse];
    [mutableDict setValue:self.calciumContent forKey:kPurchaseModelCalciumContent];
    [mutableDict setValue:self.uuid forKey:kPurchaseModelUuid];
    [mutableDict setValue:self.productDensity forKey:kPurchaseModelProductDensity];
    [mutableDict setValue:self.productCode forKey:kPurchaseModelProductCode];
    [mutableDict setValue:self.releaseTime forKey:kPurchaseModelReleaseTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productPriceWithTax] forKey:kPurchaseModelProductPriceWithTax];
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
    [mutableDict setValue:self.meshNumberLayer forKey:kPurchaseModelMeshNumberLayer];
//    [mutableDict setValue:[self.seller dictionaryRepresentation] forKey:kPurchaseModelSeller];
    [mutableDict setValue:self.productDensityValue forKey:kPurchaseModelProductDensityValue];
    [mutableDict setValue:self.isShow forKey:kPurchaseModelIsShow];
    [mutableDict setValue:self.productType forKey:kPurchaseModelProductType];
    [mutableDict setValue:self.isAcceptBook forKey:kPurchaseModelIsAcceptBook];
    [mutableDict setValue:self.providService forKey:kPurchaseModelProvidService];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productStock] forKey:kPurchaseModelProductStock];
    [mutableDict setValue:self.combustion forKey:kPurchaseModelCombustion];
    [mutableDict setValue:self.meshNumberLook forKey:kPurchaseModelMeshNumberLook];
    [mutableDict setValue:self.productColour forKey:kPurchaseModelProductColour];
    [mutableDict setValue:[NSNumber numberWithDouble:self.singlePackWeight] forKey:kPurchaseModelSinglePackWeight];
    NSMutableArray *tempArrayForReports = [NSMutableArray array];
    for (NSObject *subArrayObject in self.reports) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForReports addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForReports addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForReports] forKey:kPurchaseModelReports];
    [mutableDict setValue:self.resultMessage forKey:kPurchaseModelResultMessage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productPriceWithoutTax] forKey:kPurchaseModelProductPriceWithoutTax];
    [mutableDict setValue:self.upordown forKey:kPurchaseModelUpordown];
    [mutableDict setValue:[NSNumber numberWithBool:self.collection] forKey:kPurchaseModelCollection];
    [mutableDict setValue:self.productName forKey:kPurchaseModelProductName];
    [mutableDict setValue:self.productMaterial forKey:kPurchaseModelProductMaterial];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultCode] forKey:kPurchaseModelResultCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.visitNum] forKey:kPurchaseModelVisitNum];

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

    self.productDescribe = [aDecoder decodeObjectForKey:kPurchaseModelProductDescribe];
    self.productProperties = [aDecoder decodeObjectForKey:kPurchaseModelProductProperties];
    self.category = [aDecoder decodeObjectForKey:kPurchaseModelCategory];
    self.productImpurity = [aDecoder decodeDoubleForKey:kPurchaseModelProductImpurity];
    self.productArea = [aDecoder decodeObjectForKey:kPurchaseModelProductArea];
    self.productMoisture = [aDecoder decodeDoubleForKey:kPurchaseModelProductMoisture];
    self.productCategory = [aDecoder decodeObjectForKey:kPurchaseModelProductCategory];
    self.packing = [aDecoder decodeObjectForKey:kPurchaseModelPacking];
    self.stockUnits = [aDecoder decodeObjectForKey:kPurchaseModelStockUnits];
    self.productUse = [aDecoder decodeObjectForKey:kPurchaseModelProductUse];
    self.calciumContent = [aDecoder decodeObjectForKey:kPurchaseModelCalciumContent];
    self.uuid = [aDecoder decodeObjectForKey:kPurchaseModelUuid];
    self.productDensity = [aDecoder decodeObjectForKey:kPurchaseModelProductDensity];
    self.productCode = [aDecoder decodeObjectForKey:kPurchaseModelProductCode];
    self.releaseTime = [aDecoder decodeObjectForKey:kPurchaseModelReleaseTime];
    self.productPriceWithTax = [aDecoder decodeDoubleForKey:kPurchaseModelProductPriceWithTax];
    self.image = [aDecoder decodeObjectForKey:kPurchaseModelImage];
    self.meshNumberLayer = [aDecoder decodeObjectForKey:kPurchaseModelMeshNumberLayer];
    self.seller = [aDecoder decodeObjectForKey:kPurchaseModelSeller];
    self.productDensityValue = [aDecoder decodeObjectForKey:kPurchaseModelProductDensityValue];
    self.isShow = [aDecoder decodeObjectForKey:kPurchaseModelIsShow];
    self.productType = [aDecoder decodeObjectForKey:kPurchaseModelProductType];
    self.isAcceptBook = [aDecoder decodeObjectForKey:kPurchaseModelIsAcceptBook];
    self.providService = [aDecoder decodeObjectForKey:kPurchaseModelProvidService];
    self.productStock = [aDecoder decodeDoubleForKey:kPurchaseModelProductStock];
    self.combustion = [aDecoder decodeObjectForKey:kPurchaseModelCombustion];
    self.meshNumberLook = [aDecoder decodeObjectForKey:kPurchaseModelMeshNumberLook];
    self.productColour = [aDecoder decodeObjectForKey:kPurchaseModelProductColour];
    self.singlePackWeight = [aDecoder decodeDoubleForKey:kPurchaseModelSinglePackWeight];
    self.reports = [aDecoder decodeObjectForKey:kPurchaseModelReports];
    self.resultMessage = [aDecoder decodeObjectForKey:kPurchaseModelResultMessage];
    self.productPriceWithoutTax = [aDecoder decodeDoubleForKey:kPurchaseModelProductPriceWithoutTax];
    self.upordown = [aDecoder decodeObjectForKey:kPurchaseModelUpordown];
    self.collection = [aDecoder decodeBoolForKey:kPurchaseModelCollection];
    self.productName = [aDecoder decodeObjectForKey:kPurchaseModelProductName];
    self.productMaterial = [aDecoder decodeObjectForKey:kPurchaseModelProductMaterial];
    self.resultCode = [aDecoder decodeDoubleForKey:kPurchaseModelResultCode];
    self.visitNum = [aDecoder decodeDoubleForKey:kPurchaseModelVisitNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productDescribe forKey:kPurchaseModelProductDescribe];
    [aCoder encodeObject:_productProperties forKey:kPurchaseModelProductProperties];
    [aCoder encodeObject:_category forKey:kPurchaseModelCategory];
    [aCoder encodeDouble:_productImpurity forKey:kPurchaseModelProductImpurity];
    [aCoder encodeObject:_productArea forKey:kPurchaseModelProductArea];
    [aCoder encodeDouble:_productMoisture forKey:kPurchaseModelProductMoisture];
    [aCoder encodeObject:_productCategory forKey:kPurchaseModelProductCategory];
    [aCoder encodeObject:_packing forKey:kPurchaseModelPacking];
    [aCoder encodeObject:_stockUnits forKey:kPurchaseModelStockUnits];
    [aCoder encodeObject:_productUse forKey:kPurchaseModelProductUse];
    [aCoder encodeObject:_calciumContent forKey:kPurchaseModelCalciumContent];
    [aCoder encodeObject:_uuid forKey:kPurchaseModelUuid];
    [aCoder encodeObject:_productDensity forKey:kPurchaseModelProductDensity];
    [aCoder encodeObject:_productCode forKey:kPurchaseModelProductCode];
    [aCoder encodeObject:_releaseTime forKey:kPurchaseModelReleaseTime];
    [aCoder encodeDouble:_productPriceWithTax forKey:kPurchaseModelProductPriceWithTax];
    [aCoder encodeObject:_image forKey:kPurchaseModelImage];
    [aCoder encodeObject:_meshNumberLayer forKey:kPurchaseModelMeshNumberLayer];
    [aCoder encodeObject:_seller forKey:kPurchaseModelSeller];
    [aCoder encodeObject:_productDensityValue forKey:kPurchaseModelProductDensityValue];
    [aCoder encodeObject:_isShow forKey:kPurchaseModelIsShow];
    [aCoder encodeObject:_productType forKey:kPurchaseModelProductType];
    [aCoder encodeObject:_isAcceptBook forKey:kPurchaseModelIsAcceptBook];
    [aCoder encodeObject:_providService forKey:kPurchaseModelProvidService];
    [aCoder encodeDouble:_productStock forKey:kPurchaseModelProductStock];
    [aCoder encodeObject:_combustion forKey:kPurchaseModelCombustion];
    [aCoder encodeObject:_meshNumberLook forKey:kPurchaseModelMeshNumberLook];
    [aCoder encodeObject:_productColour forKey:kPurchaseModelProductColour];
    [aCoder encodeDouble:_singlePackWeight forKey:kPurchaseModelSinglePackWeight];
    [aCoder encodeObject:_reports forKey:kPurchaseModelReports];
    [aCoder encodeObject:_resultMessage forKey:kPurchaseModelResultMessage];
    [aCoder encodeDouble:_productPriceWithoutTax forKey:kPurchaseModelProductPriceWithoutTax];
    [aCoder encodeObject:_upordown forKey:kPurchaseModelUpordown];
    [aCoder encodeBool:_collection forKey:kPurchaseModelCollection];
    [aCoder encodeObject:_productName forKey:kPurchaseModelProductName];
    [aCoder encodeObject:_productMaterial forKey:kPurchaseModelProductMaterial];
    [aCoder encodeDouble:_resultCode forKey:kPurchaseModelResultCode];
    [aCoder encodeDouble:_visitNum forKey:kPurchaseModelVisitNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    PurchaseModel *copy = [[PurchaseModel alloc] init];
    
    if (copy) {

        copy.productDescribe = [self.productDescribe copyWithZone:zone];
        copy.productProperties = [self.productProperties copyWithZone:zone];
//        copy.category = [self.category copyWithZone:zone];
        copy.productImpurity = self.productImpurity;
        copy.productArea = [self.productArea copyWithZone:zone];
        copy.productMoisture = self.productMoisture;
        copy.productCategory = [self.productCategory copyWithZone:zone];
        copy.packing = [self.packing copyWithZone:zone];
        copy.stockUnits = [self.stockUnits copyWithZone:zone];
        copy.productUse = [self.productUse copyWithZone:zone];
        copy.calciumContent = [self.calciumContent copyWithZone:zone];
//        copy.uuid = [self.uuid copyWithZone:zone];
        copy.productDensity = [self.productDensity copyWithZone:zone];
        copy.productCode = [self.productCode copyWithZone:zone];
        copy.releaseTime = [self.releaseTime copyWithZone:zone];
        copy.productPriceWithTax = self.productPriceWithTax;
        copy.image = [self.image copyWithZone:zone];
        copy.meshNumberLayer = [self.meshNumberLayer copyWithZone:zone];
//        copy.seller = [self.seller copyWithZone:zone];
        copy.productDensityValue = [self.productDensityValue copyWithZone:zone];
        copy.isShow = [self.isShow copyWithZone:zone];
        copy.productType = [self.productType copyWithZone:zone];
        copy.isAcceptBook = [self.isAcceptBook copyWithZone:zone];
        copy.providService = [self.providService copyWithZone:zone];
        copy.productStock = self.productStock;
        copy.combustion = [self.combustion copyWithZone:zone];
        copy.meshNumberLook = [self.meshNumberLook copyWithZone:zone];
        copy.productColour = [self.productColour copyWithZone:zone];
        copy.singlePackWeight = self.singlePackWeight;
        copy.reports = [self.reports copyWithZone:zone];
        copy.resultMessage = [self.resultMessage copyWithZone:zone];
        copy.productPriceWithoutTax = self.productPriceWithoutTax;
        copy.upordown = [self.upordown copyWithZone:zone];
        copy.collection = self.collection;
        copy.productName = [self.productName copyWithZone:zone];
        copy.productMaterial = [self.productMaterial copyWithZone:zone];
        copy.resultCode = self.resultCode;
        copy.visitNum = self.visitNum;
    }
    
    return copy;
}


@end
