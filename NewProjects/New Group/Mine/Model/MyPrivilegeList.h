//
//  MyPrivilegeList.h
//
//  Created by feijiu 1 on 2017/12/25
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MyPrivilegeList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *time;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
