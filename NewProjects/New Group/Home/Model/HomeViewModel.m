//
//  HomeViewModel.m
//
//  Created by feijiu 1 on 2017/12/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeViewList.h"


NSString *const kHomeViewModelResultCode = @"resultCode";
NSString *const kHomeViewModelResultMessage = @"resultMessage";
NSString *const kHomeViewModelList = @"list";


@interface HomeViewModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeViewModel

@synthesize resultCode = _resultCode;
@synthesize resultMessage = _resultMessage;
@synthesize list = _list;


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
            self.resultCode = [[self objectOrNilForKey:kHomeViewModelResultCode fromDictionary:dict] doubleValue];
            self.resultMessage = [self objectOrNilForKey:kHomeViewModelResultMessage fromDictionary:dict];
    NSObject *receivedHomeViewList = [dict objectForKey:kHomeViewModelList];
    NSMutableArray *parsedHomeViewList = [NSMutableArray array];
    if ([receivedHomeViewList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHomeViewList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHomeViewList addObject:[HomeViewList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHomeViewList isKindOfClass:[NSDictionary class]]) {
       [parsedHomeViewList addObject:[HomeViewList modelObjectWithDictionary:(NSDictionary *)receivedHomeViewList]];
    }

    self.list = [NSArray arrayWithArray:parsedHomeViewList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultCode] forKey:kHomeViewModelResultCode];
    [mutableDict setValue:self.resultMessage forKey:kHomeViewModelResultMessage];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kHomeViewModelList];

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

    self.resultCode = [aDecoder decodeDoubleForKey:kHomeViewModelResultCode];
    self.resultMessage = [aDecoder decodeObjectForKey:kHomeViewModelResultMessage];
    self.list = [aDecoder decodeObjectForKey:kHomeViewModelList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resultCode forKey:kHomeViewModelResultCode];
    [aCoder encodeObject:_resultMessage forKey:kHomeViewModelResultMessage];
    [aCoder encodeObject:_list forKey:kHomeViewModelList];
}

- (id)copyWithZone:(NSZone *)zone
{
    HomeViewModel *copy = [[HomeViewModel alloc] init];
    
    if (copy) {

        copy.resultCode = self.resultCode;
        copy.resultMessage = [self.resultMessage copyWithZone:zone];
        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
