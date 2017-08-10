//
//  LHGoodsDetailController.m
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/10.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import "LHGoodsDetailController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LHGoodsDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *text;

@end

@implementation LHGoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.model.goodsImage]];
    self.text.text = self.model.goodsDesc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
