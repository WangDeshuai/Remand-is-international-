//
//  ChildPublishList.h
//
//  Created by feijiu 1 on 2017/12/26
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ChildPublishList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, assign) double productStock;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, assign) double productPriceWithoutTax;
@property (nonatomic, assign) id productCategory;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *upordown;
@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, assign) id rejectContent;
@property (nonatomic, strong) NSString *isStatus;
@property (nonatomic, assign) id image;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *sellerCodeT;
@property (nonatomic, strong) NSString *stockUnits;
@property (nonatomic, assign) id expiryTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
