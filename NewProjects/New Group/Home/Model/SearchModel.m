//
//  SearchModel.m
//
//  Created by feijiu 1 on 2017/12/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "SearchModel.h"


NSString *const kSearchModelRecords = @"records";
NSString *const kSearchModelResultCode = @"resultCode";
NSString *const kSearchModelHotWords = @"hotWords";
NSString *const kSearchModelResultMessage = @"resultMessage";


@interface SearchModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchModel

@synthesize records = _records;
@synthesize resultCode = _resultCode;
@synthesize hotWords = _hotWords;
@synthesize resultMessage = _resultMessage;


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
        self.records=[NSMutableArray array];
            NSArray * arr = [self objectOrNilForKey:kSearchModelRecords fromDictionary:dict];
        [self.records addObjectsFromArray:arr];
        self.resultCode = [[self objectOrNilForKey:kSearchModelResultCode fromDictionary:dict] doubleValue];
            self.hotWords = [self objectOrNilForKey:kSearchModelHotWords fromDictionary:dict];
            self.resultMessage = [self objectOrNilForKey:kSearchModelResultMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForRecords = [NSMutableArray array];
    for (NSObject *subArrayObject in self.records) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRecords addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRecords addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRecords] forKey:kSearchModelRecords];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultCode] forKey:kSearchModelResultCode];
    NSMutableArray *tempArrayForHotWords = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hotWords) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHotWords addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHotWords addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHotWords] forKey:kSearchModelHotWords];
    [mutableDict setValue:self.resultMessage forKey:kSearchModelResultMessage];

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

    self.records = [aDecoder decodeObjectForKey:kSearchModelRecords];
    self.resultCode = [aDecoder decodeDoubleForKey:kSearchModelResultCode];
    self.hotWords = [aDecoder decodeObjectForKey:kSearchModelHotWords];
    self.resultMessage = [aDecoder decodeObjectForKey:kSearchModelResultMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_records forKey:kSearchModelRecords];
    [aCoder encodeDouble:_resultCode forKey:kSearchModelResultCode];
    [aCoder encodeObject:_hotWords forKey:kSearchModelHotWords];
    [aCoder encodeObject:_resultMessage forKey:kSearchModelResultMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchModel *copy = [[SearchModel alloc] init];
    
    if (copy) {

        copy.records = [self.records copyWithZone:zone];
        copy.resultCode = self.resultCode;
        copy.hotWords = [self.hotWords copyWithZone:zone];
        copy.resultMessage = [self.resultMessage copyWithZone:zone];
    }
    
    return copy;
}


@end
