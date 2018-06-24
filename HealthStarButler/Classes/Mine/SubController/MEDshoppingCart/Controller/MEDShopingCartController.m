//
//  MEDShopingCartController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDShopingCartController.h"
#import "MEDShopCartCell.h"
#import "MEDShopCartModel.h"
#import "MEDShopCartToolBar.h"


static CGFloat toolBarH = 50;
static NSString *cellID = @"wine";

@interface MEDShopingCartController ()<UITableViewDataSource, UITableViewDelegate, MEDShopCartDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *goodArray;
@property (nonatomic, strong) MEDShopCartToolBar *toolBar;


@end

@implementation MEDShopingCartController


#pragma mark - Lazy

#pragma mark 模拟数据
- (NSArray *)goodArray {
    if (!_goodArray) {
        //不好使-待查明
//        _goodArray = [MEDShopCartModel mj_objectArrayWithFile:@"drinks.plist"];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"drinks.plist" ofType:nil];
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
        _goodArray = [MEDShopCartModel mj_objectArrayWithKeyValuesArray:tempArray];
        
        // 为每个商品模型添加KVO监听
//        for (MEDShopCartModel *shopCartModel in _goodArray) {
//            [shopCartModel addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionNew context:nil];
//            // 查看kVO生成的子类(派生类)
//            NSLog(@"%@", [shopCartModel valueForKeyPath:@"isa"] );
//        }
        
    }
    return _goodArray;
}

- (UITableView *)tableView
{
    if(!_tableView) {
        CGFloat tableH = SCREEN_HEIGHT - Navigation_Height - toolBarH - MED_TabbarSafeBottomMargin;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Navigation_Height, SCREEN_WIDTH ,tableH) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.allowsSelection = NO;
        
        // ----- 性能优化 -----
        _tableView.layer.shouldRasterize = true;   // 栅格化cell，滚动时只显示图片
        _tableView.layer.rasterizationScale = [UIScreen mainScreen].scale;   // 默认缩放比例是1，要适配当前屏幕
        _tableView.layer.drawsAsynchronously = YES; // 开启异步绘制
        // ----- 性能优化 -----
    }
    return _tableView;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
//    // 监听通知
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(plusClick:) name:@"plusClickNotification" object:nil];
//    [center addObserver:self selector:@selector(minusClick:) name:@"minusClickNotification" object:nil];
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
//    // 移除KVO监听
//    for (MEDShopCartModel *shopCartModel in _goodArray) {
//        [shopCartModel removeObserver:self forKeyPath:@"count"];
//    }
}


#pragma mark - KVO 监听
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    
////    NSLog(@"observeValueForKeyPath");
//    
//    MEDShopCartModel *shopCartModel = object;
//    
//    int new = [change[NSKeyValueChangeNewKey] intValue];
//    int old = [change[NSKeyValueChangeOldKey] intValue];
//    
//    if (new > old) { // 点击了加号
//        // 计算总价
//        int totalPrice = self.toolBar.totalPriceLabel.text.intValue + shopCartModel.money.intValue;
//        // 设置总价
//        self.toolBar.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
//        // 控制购买按钮状态
//        self.toolBar.buyButton.enabled = YES;
//        
//    }else {          // 点击了减号
//        
//        // 计算总价
//        int totalPrice = self.toolBar.totalPriceLabel.text.intValue - shopCartModel.money.intValue;
//        // 设置总价
//        self.toolBar.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
//        // 控制购买按钮状态
//        self.toolBar.buyButton.enabled = totalPrice > 0;
//    }
//    
//}

#pragma mark - Delegate 监听

- (void)shopCartCellDidClickPlusButton:(MEDShopCartCell *)cell {
    
    // 计算总价
    int totalPrice = self.toolBar.totalPriceLabel.text.intValue + cell.goods.money.intValue;
    // 设置总价
    self.toolBar.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    // 控制购买按钮状态
    self.toolBar.buyButton.enabled = YES;
    
}

- (void)shopCartCellDidClickMinusButton:(MEDShopCartCell *)cell {
    
    // 计算总价
    int totalPrice = self.toolBar.totalPriceLabel.text.intValue - cell.goods.money.intValue;
    // 设置总价
    self.toolBar.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    // 控制购买按钮状态
    self.toolBar.buyButton.enabled = totalPrice > 0;
    
}





#pragma mark - 通知的监听方法
//- (void)plusClick:(NSNotification *)note {
//    NSLog(@"监听到加号按钮点击");
//
//    MEDShopCartCell *cell = note.object;
//    // 计算总价
//    int totalPrice = self.toolBar.totalPriceLabel.text.intValue + cell.goods.money.intValue;
//    // 设置总价
//    self.toolBar.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
//    // 控制购买按钮状态
//    self.toolBar.buyButton.enabled = YES;
//}
//
//- (void)minusClick:(NSNotification *)note {
//    NSLog(@"监听到减号按钮点击");
//
//    MEDShopCartCell *cell = note.object;
//    // 计算总价
//    int totalPrice = self.toolBar.totalPriceLabel.text.intValue - cell.goods.money.intValue;
//    // 设置总价
//    self.toolBar.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
//    // 控制购买按钮状态
//    self.toolBar.buyButton.enabled = totalPrice > 0;
//}

#pragma mark - Config UI

- (void)configUI {
    
    //BaseSet
    self.navigationItem.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MEDShopCartCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    
    // ToolBar
    MEDShopCartToolBar *toolBar = [[MEDShopCartToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - toolBarH - MED_TabbarSafeBottomMargin, SCREEN_WIDTH, toolBarH)];
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    toolBar.buttonBlock = ^(UIButton *button) {
        if (button.tag == 6181) {
            [self clearClick];
        }else if (button.tag == 6182){
            [self buyClick];
        }
    };
}

#pragma mark - event

// 清空购物车
- (void)clearClick {
    // NSLog(@"控制器清空购物车");

    for (MEDShopCartModel *good in self.goodArray) {
        good.count = 0;
    }
    [self.tableView reloadData];
    
    self.toolBar.totalPriceLabel.text = @"0";
    
    self.toolBar.buyButton.enabled = NO; // 禁用购买按钮
}

// 购买--结算
- (void)buyClick {
    NSLog(@"控制器购买商品-跳转至结算页面");
    
}


#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MEDShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.goods = self.goodArray[indexPath.row];
    cell.delegate = self;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 关闭选择，如果进一步开发，可在此处点击进入详情页面
}



@end
