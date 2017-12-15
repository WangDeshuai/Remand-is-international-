//
//  HomeViewModel.h
//
//  Created by feijiu 1 on 2017/12/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HomeViewModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resultCode;
@property (nonatomic, strong) NSString *resultMessage;
@property (nonatomic, strong) NSArray *list;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
