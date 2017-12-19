//
//  PurchaseModel.h
//
//  Created by feijiu 1 on 2017/12/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PurchaseCategory, PurchaseSeller;

@interface PurchaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) id productDescribe;
@property (nonatomic, assign) id productProperties;
@property (nonatomic, strong) PurchaseCategory *category;
@property (nonatomic, assign) double productImpurity;
@property (nonatomic, strong) NSString *productArea;
@property (nonatomic, assign) double productMoisture;
@property (nonatomic, strong) NSString *productCategory;
@property (nonatomic, strong) NSString *packing;
@property (nonatomic, strong) NSString *stockUnits;
@property (nonatomic, strong) NSString *productUse;
@property (nonatomic, strong) NSString *calciumContent;
@property (nonatomic, assign) id uuid;
@property (nonatomic, strong) NSString *productDensity;
@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *releaseTime;
@property (nonatomic, assign) double productPriceWithTax;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, strong) NSString *meshNumberLayer;
@property (nonatomic, strong) PurchaseSeller *seller;
@property (nonatomic, strong) NSString *productDensityValue;
@property (nonatomic, strong) NSString *isShow;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, strong) NSString *isAcceptBook;
@property (nonatomic, strong) NSString *providService;
@property (nonatomic, assign) double productStock;
@property (nonatomic, strong) NSString *combustion;
@property (nonatomic, strong) NSString *meshNumberLook;
@property (nonatomic, strong) NSString *productColour;
@property (nonatomic, assign) double singlePackWeight;
@property (nonatomic, strong) NSArray *reports;
@property (nonatomic, strong) NSString *resultMessage;
@property (nonatomic, assign) double productPriceWithoutTax;
@property (nonatomic, strong) NSString *upordown;
@property (nonatomic, assign) BOOL collection;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productMaterial;
@property (nonatomic, assign) double resultCode;
@property (nonatomic, assign) double visitNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
