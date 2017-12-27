//
//  PurchaseModel.h
//
//  Created by feijiu 1 on 2017/12/27
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PurchaseCategory;

@interface PurchaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *isShow;
@property (nonatomic, assign) double productStock;
@property (nonatomic, strong) PurchaseCategory *category;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, assign) BOOL book;
@property (nonatomic, assign) double productPriceWithoutTax;
@property (nonatomic, strong) NSString *resultMessage;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) id productDescribe;
@property (nonatomic, strong) NSString *productCategory;
@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *productArea;
@property (nonatomic, assign) double visitNum;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, assign) double resultCode;
@property (nonatomic, strong) NSString *upordown;
@property (nonatomic, strong) NSString *stockUnits;
@property (nonatomic, strong) NSString *releaseTime;
@property (nonatomic, assign) BOOL collection;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
