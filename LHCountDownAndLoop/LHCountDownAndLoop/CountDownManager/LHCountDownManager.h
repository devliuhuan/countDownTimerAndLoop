//
//  LHCountDownManager.h
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/10.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCountDownManager : NSObject
// 倒计时通知名字
@property (nonatomic,copy) NSString  *countDownNotifyKey;
/// 时间差(单位:秒)
@property (nonatomic, assign) NSInteger timeInterval;

/// 开始倒计时
- (void)start;
/// 刷新倒计时
- (void)reload;
/// 停止倒计时
- (void)invalidate;

+ (instancetype)managerWithCountDownKey:(NSString *)countDownKey;
@end
