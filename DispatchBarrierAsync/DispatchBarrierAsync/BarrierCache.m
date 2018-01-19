//
//  BarrierCache.m
//  DispatchBarrierAsync
//
//  Created by a on 2018/1/19.
//  Copyright © 2018年 a. All rights reserved.
//

#import "BarrierCache.h"
@interface BarrierCache ()
@property (nonatomic, strong) NSMutableDictionary *mutableCacheDic;
@end

@implementation BarrierCache

- (NSMutableDictionary *)mutableCacheDic
{
    if (!_mutableCacheDic) {
        self.mutableCacheDic = [[NSMutableDictionary alloc] init];
    }return _mutableCacheDic;
}

//单例
+ (instancetype)share
{
    static BarrierCache *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //初始化单例
        manager = [[BarrierCache alloc] init];
    });
    return manager;
}

//读取操作
- (id)cacheWithKey:(id)key
{
    return [self.mutableCacheDic  objectForKey:key];
}

//写入操作
- (void)setCacheObject:(id)object
               withKey:(id)key
{
    [self.mutableCacheDic setObject:object forKey:key];
}

@end
