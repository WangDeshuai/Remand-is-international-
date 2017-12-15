//
//  HomeViewList.h
//
//  Created by feijiu 1 on 2017/12/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HomeViewList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, strong) NSString *releaseTime;
@property (nonatomic, strong) NSString *productName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
