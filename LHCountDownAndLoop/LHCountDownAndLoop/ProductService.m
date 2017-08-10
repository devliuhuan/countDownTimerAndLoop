//
//  ProductService.m
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/10.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import "ProductService.h"
#import <YYModel/YYModel.h>

@implementation ProductService
- (void)loadFirstPageProductListWithBlock:(PageDataBasicServiceBlock)block
{
    // 模拟请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"productList" ofType:@"plist"];
        NSArray *list = [[NSArray alloc] initWithContentsOfFile:filePath];
        [self.dataList addObjectsFromArray:[NSArray yy_modelArrayWithClass:[LHProductModel class] json:list]];
        if (block) {
            block(YES,@"",NO);
        }
    });
}
- (void)pollingModelWithModel:(LHProductModel *)originModel block:(NormalDataBasicServiceBlock)block
{
    // 模拟请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 模拟网络请求后将数据更新,更新价格、时间、购买者
        originModel.goodsTime = (arc4random() % 10) + 1;
        originModel.goodsPrice += 0.1;
        NSArray *names = @[@"丁春秋",@"王语嫣",@"虚竹",@"段誉",@"乔峰",@"郭靖",@"黄药师",@"乔峰",@"杨过",@"一灯大师",@"令狐冲",@"张三丰"];
        NSInteger nameIndex = arc4random()%names.count;
        if (nameIndex < names.count) {
            originModel.goodsBuyer =names[nameIndex];
        }
        // ----模拟结束
        if (block) {
            block(YES,originModel);
        }
    });
}
- (NSMutableArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
