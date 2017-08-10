//
//  LHCountDownManager.m
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/10.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import "LHCountDownManager.h"

@interface LHCountDownManager()
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation LHCountDownManager
+ (instancetype)managerWithCountDownKey:(NSString *)countDownKey
{
    LHCountDownManager *manager = [LHCountDownManager new];
    manager.countDownNotifyKey = countDownKey;
    return manager;
}
- (void)start {
    // 启动定时器
    [self timer];
}

- (void)reload {
    // 刷新只要让时间差为0即可
    _timeInterval = 0;
}

- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
    self.timeInterval = 0;
}

- (void)timerAction {
    // 时间差+1
    self.timeInterval ++;
    
    // 发出通知--可以将时间差传递出去,或者直接通知类属性取
    [[NSNotificationCenter defaultCenter] postNotificationName:self.countDownNotifyKey object:nil userInfo:@{@"TimeInterval" : @(self.timeInterval)}];
    // 对最大值进行限制
    if (self.timeInterval >= NSUIntegerMax) {
        self.timeInterval = 0;
    }
    // 对最小值进行限制
    if (self.timeInterval <= 0) {
        self.timeInterval = 0;
    }
}
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
@end
