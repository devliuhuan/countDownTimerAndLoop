//
//  LHProductTableViewCell.h
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/1.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHProductModel.h"

@interface LHProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *peoplePriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
- (IBAction)buyBtnClicked:(id)sender;


/**
 倒计时通知名称
 */
@property (nonatomic,copy) NSString *countDownNotifyName;

/**
 有人出价价格变化通知名称
 */
@property (nonatomic,strong) NSString * priceChangeNotifyName;

@property (nonatomic,strong) LHProductModel * model;
@end
