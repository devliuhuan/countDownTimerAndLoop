//
//  LHHomeViewController.m
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/1.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import "LHHomeViewController.h"
#import "LHProductTableViewCell.h"
#import "ProductService.h"
#import "LHCountDownManager.h"
#import "LHGoodsDetailController.h"

#define kHomeCountDownTimerNotifiyKey @"kHomeCountDownTimerNotifiyKey"
#define kHomeProductChangeNotifiyKey @"kHomeProductChnageNotifiyKey"

@interface LHHomeViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) ProductService * service;
@property (nonatomic,strong) LHCountDownManager * countDownManager;
@property (nonatomic,strong) NSMutableArray * pollingListM;
@end

@implementation LHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _loadFirstPage];
    [self _addNotifications];
}
- (void)_loadFirstPage
{
    __weak typeof(self) weakSelf = self;
    [self.service loadFirstPageProductListWithBlock:^(BOOL success, NSString *msg, BOOL hasMore) {
        if (success) {
            [weakSelf.pollingListM removeAllObjects];
            // 有重新加载了数据就要将轮询数组里的数据全清空一遍
            [weakSelf.tableView reloadData];
        }
    }];
}
- (void)_addNotifications
{
    // 添加定时器变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(countDownChange:)
                                                 name:kHomeCountDownTimerNotifiyKey
                                               object:nil];
}
#pragma mark - ******** 轮询所有保存在轮询数组里的内容
- (void)countDownChange:(NSNotification *)notify
{
    // 2秒轮询一次
    if (self.countDownManager.timeInterval % 2 == 0) {
        NSString *ids = [[self.pollingListM valueForKeyPath:@"goodsId"] componentsJoinedByString:@","];
        NSLog(@"变量的数组：%@",ids);
        // 对所有轮询数组里的数据进行轮询请求
        for (LHProductModel *model in self.pollingListM) {
            // 这个方法只改变model的值，不重新创建model
            [self.service pollingModelWithModel:model block:^(BOOL success, id msg) {
                // 如果请求成功，发送通知修改显示内容
                if (success && [msg isKindOfClass:[LHProductModel class]]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kHomeProductChangeNotifiyKey object:nil userInfo:@{@"goodsId":((LHProductModel *)msg).goodsId?:@""}];
                }
            }];
        }
    }
}
#pragma mark - ******** 进入页面或离开页面开启关闭定时器
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.countDownManager start];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.countDownManager invalidate];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ******** UITableViewDataSource && UITabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.service.dataList.count;
    return count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHProductModel *model = self.service.dataList[indexPath.row];
    LHProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHProductTableViewCell"];
    // 将重用Cell之前保存的model从轮询数组里去除
    if (cell.model != nil) {
        [self.pollingListM removeObject:cell.model];
    }
    // 将接近要显示的Cell保存的model放到轮询数组里用于轮询
    if (model != nil) {
        [self.pollingListM addObject:model];
    }
    // 设置让Cell可以处理倒计时的通知
    cell.countDownNotifyName = kHomeCountDownTimerNotifiyKey;
    cell.priceChangeNotifyName = kHomeProductChangeNotifiyKey;
    // 将数据赋值给Cell显示
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
    LHProductModel *model = self.service.dataList[indexPath.row];
    LHGoodsDetailController *vc = [LHGoodsDetailController new];
    vc.model = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - ******** getter && setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"LHProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"LHProductTableViewCell"];
    }
    return _tableView;
}
- (ProductService *)service
{
    if (_service == nil) {
        _service = [ProductService new];
    }
    return _service;
}
- (LHCountDownManager *)countDownManager
{
    if (_countDownManager == nil) {
        _countDownManager = [LHCountDownManager managerWithCountDownKey:kHomeCountDownTimerNotifiyKey];
    }
    return _countDownManager;
}
- (NSMutableArray *)pollingListM
{
    if (_pollingListM == nil) {
        _pollingListM = [NSMutableArray array];
    }
    return _pollingListM;
}
@end
