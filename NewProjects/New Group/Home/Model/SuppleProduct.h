//
//  SuppleProduct.h
//
//  Created by feijiu 1 on 2017/12/18
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SuppleProduct : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *positionY;
@property (nonatomic, assign) double productStatus;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSArray *productImage;
@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) double stockNum;
@property (nonatomic, strong) NSArray *properties;
@property (nonatomic, strong) NSString *stockUnits;
@property (nonatomic, strong) NSString *releaseTime;
@property (nonatomic, strong) NSString *imgWidth;
@property (nonatomic, strong) NSString *imgHeight;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
