//
//  BarrierCache.h
//  DispatchBarrierAsync
//
//  Created by a on 2018/1/19.
//  Copyright © 2018年 a. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarrierCache : NSObject

//单例
+ (instancetype)share;

//读取操作
- (id)cacheWithKey:(id)key;

//写入操作
- (void)setCacheObject:(id)object
               withKey:(id)key;

@end
