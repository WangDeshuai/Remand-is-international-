//
//  SearchModel.h
//
//  Created by feijiu 1 on 2017/12/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SearchModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSMutableArray *records;
@property (nonatomic, assign) double resultCode;
@property (nonatomic, strong) NSArray *hotWords;
@property (nonatomic, strong) NSString *resultMessage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
