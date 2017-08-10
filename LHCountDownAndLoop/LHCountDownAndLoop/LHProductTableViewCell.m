//
//  LHProductTableViewCell.m
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/1.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import "LHProductTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface LHProductTableViewCell()
@property (nonatomic,copy) NSString *oldNamePrice;
@end

@implementation LHProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buyBtnClicked:(id)sender {
}
#pragma mark - ******** 倒计时通知处理
- (void)setCountDownNotifyName:(NSString *)countDownNotifyName
{
    // 如果以前设置的倒计时通知有变化，去除以前的通知
    if (_countDownNotifyName != nil && ![_countDownNotifyName isEqualToString:countDownNotifyName]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_countDownNotifyName object:nil];
    }
    // 如果现在设置的通知与之前的不一致，添加通知
    if (countDownNotifyName !=nil && ![_countDownNotifyName isEqualToString:countDownNotifyName]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownChange:) name:countDownNotifyName object:nil];
    }
    _countDownNotifyName = countDownNotifyName;
}
#pragma mark 显示倒计时减一
- (void)countDownChange:(NSNotification *)notify
{
    // 倒计时减一
    self.model.goodsTime --;
    NSInteger countDown = self.model.goodsTime;
    /// 当倒计时到了进行回调
    if (countDown <= 0) {
        countDown = 0;
    }
    NSString *cuountDownText = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];
    self.timeLbl.text = cuountDownText;
}
#pragma mark - ******** 轮询价格变化处理
- (void)setPriceChangeNotifyName:(NSString *)priceChangeNotifyName
{
    // 如果以前设置的倒计时通知有变化，去除以前的通知
    if (_priceChangeNotifyName != nil && ![_priceChangeNotifyName isEqualToString:priceChangeNotifyName]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_priceChangeNotifyName object:nil];
    }
    // 如果现在设置的通知与之前的不一致，添加通知
    if (priceChangeNotifyName !=nil && ![_priceChangeNotifyName isEqualToString:priceChangeNotifyName]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(priceChange:) name:priceChangeNotifyName object:nil];
    }
    _priceChangeNotifyName = priceChangeNotifyName;
}
#pragma mark 内容经过轮询后显示最新内容
- (void)priceChange:(NSNotification *)notify
{
    NSDictionary *userInfo = notify.userInfo;
    NSString *goodsId = userInfo[@"goodsId"];
    // goodsId等于空或不是当前Cell显示的model，直接不处理
    if (goodsId == nil || [goodsId isEqualToString:@""] || ![goodsId isEqualToString:self.model.goodsId]) {
        return;
    }
    
    NSString *currentNamePrice = [NSString stringWithFormat:@"%@出价￥%.2f",self.model.goodsBuyer,self.model.goodsPrice];
    // 如果购买者或者购买的价格没有变化不处理
    if (currentNamePrice == nil || [self.oldNamePrice isEqualToString:currentNamePrice]) {
        return;
    }
    // 更新数据
    self.peoplePriceLbl.text = currentNamePrice;
    NSInteger countDown = self.model.goodsTime;
    /// 当倒计时到了进行回调
    if (countDown <= 0) {
        countDown = 0;
        
    }
    NSString *cuountDownText = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];
    self.timeLbl.text = cuountDownText;
    self.oldNamePrice = currentNamePrice;
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - ******** 设置数据
- (void)setModel:(LHProductModel *)model
{
    _model = model;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:model.goodsImage] placeholderImage:[UIImage imageNamed:@"nahan"]];
    self.nameLbl.text = model.goodsName;
    NSString *currentNamePrice = [NSString stringWithFormat:@"%@出价￥%.2f",self.model.goodsBuyer,self.model.goodsPrice];
    self.peoplePriceLbl.text = currentNamePrice;
    self.oldNamePrice = currentNamePrice;
    NSInteger countDown = model.goodsTime;
    /// 当倒计时到了进行回调
    if (countDown <= 0) {
        countDown = 0;
        
    }
    NSString *cuountDownText = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];
    self.timeLbl.text = cuountDownText;
}
@end
