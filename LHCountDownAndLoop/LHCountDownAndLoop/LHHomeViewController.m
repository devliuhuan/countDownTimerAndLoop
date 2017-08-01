//
//  LHHomeViewController.m
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/1.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import "LHHomeViewController.h"
#import "LHProductTableViewCell.h"

@interface LHHomeViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataList;
@end

@implementation LHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<100; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [self.dataList addObject:dict];
    }
    [self.view addSubview:self.tableView];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHProductTableViewCell"];
    return cell;
}
- (NSMutableArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
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
@end
