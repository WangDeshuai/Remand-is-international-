//
//  ReleaseModel.h
//
//  Created by feijiu 02 on 2017/12/25
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ReleaseModel : NSObject

@property (nonatomic, strong) NSString *productStock;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *productPriceWithoutTax;
@property (nonatomic, strong) NSString *resultMessage;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productDescribe;
@property (nonatomic, strong) NSString *productCategory;
@property (nonatomic, strong) NSString *productArea;
@property (nonatomic, strong) NSArray  *image;
@property (nonatomic, strong) NSString *resultCode;
@property (nonatomic, strong) NSString *stockUnits;
@property (nonatomic, strong) NSString *expiryTime;
@property (nonatomic, strong) NSString *productCategoryName;
@property (nonatomic, strong) NSString *productAreaName;
@property (nonatomic, strong) NSString *Country;
@property (nonatomic, strong) NSString *CountryCode;
@property (nonatomic, strong) NSString *stockUnitsName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
