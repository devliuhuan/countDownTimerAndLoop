//
//  ProductService.h
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/10.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHProductModel.h"
typedef void(^NormalDataBasicServiceBlock)(BOOL success,id msg);
typedef void(^PageDataBasicServiceBlock)(BOOL success,NSString *msg,BOOL hasMore);

@interface ProductService : NSObject
@property (nonatomic,strong) NSMutableArray * dataList;

/**
 请求第一页的数据

 @param block <#block description#>
 */
- (void)loadFirstPageProductListWithBlock:(PageDataBasicServiceBlock)block;

/**
 轮询数据

 @param originModel <#originModel description#>
 @param block <#block description#>
 */
- (void)pollingModelWithModel:(LHProductModel *)originModel block:(NormalDataBasicServiceBlock)block;
@end
