//
//  LHProductModel.h
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/10.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHProductModel : NSObject
@property (nonatomic,copy) NSString *goodsId;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *goodsImage;
@property (nonatomic,copy) NSString *goodsBuyer;
@property (nonatomic,assign) float goodsPrice;
@property (nonatomic,assign) NSInteger goodsTime;
@property (nonatomic,copy) NSString *goodsDesc;
@end
