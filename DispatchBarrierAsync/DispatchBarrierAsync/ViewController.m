//
//  ViewController.m
//  DispatchBarrierAsync
//
//  Created by a on 2018/1/19.
//  Copyright © 2018年 a. All rights reserved.
//

#import "ViewController.h"
#import "BarrierCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /*
     dispatch_barrier_async:
     
     1.在访问数据库或文件时,为了高效率地进行访问,读取处理追加到Concurrent Dispatch Queue 中,
     写入处理在任一个读取处理没有执行的状态下,追加到Serial Dispatch Queue 中即可(在写入处理结束之前,读取处理不可执行)。
     
     2.dispatch_barrier_async函数会等待追加到Concurrent Dispatch Queue上的并行执行的全部处理结束之后,再将指定的处理
     追加到该Concurrent Dispatch Queue中。然后由dispatch_barrier_async函数追加的处理执行完毕后,Concurrent Dispatch Queue才恢复为一般动作,追加到Concurrent Dispatch Queue的处理又开始 并行执行。
     
     3.使用Concurrent Dispatch Queue 和 dispatch_barrier_async函数可实现高效率的 数据库访问 和 文件访问。
    */
    
    
    BarrierCache *manager = [BarrierCache share];
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    
    //读操作
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-1");
        [manager  cacheWithKey:@"n"];
    });
    
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-2");
        [manager  cacheWithKey:@"l"];
    });
    
    
    //写操作 -- 暂时不需要开(追加)多个dispatch_barrier_async异步子线程,因为开线程也需要耗时
    //保证同时'写'的的只有一个
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
        [manager  setCacheObject:@"1" withKey:@"k"];
        [manager  setCacheObject:@"2" withKey:@"l"];
        [manager  setCacheObject:@"3" withKey:@"n"];
    });
    
    
    //读操作
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-3");
        NSLog(@"接收k:%@", [manager  cacheWithKey:@"k"]);
    });
    
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-4");
        NSLog(@"接收l:%@", [manager  cacheWithKey:@"l"]);
    });

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
