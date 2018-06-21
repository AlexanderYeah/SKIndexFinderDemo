//
//  ViewController.m
//  SKIndexDemo
//
//  Created by Alexander on 2018/6/21.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "LGUIView.h"

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kW  [UIScreen mainScreen].bounds.size.width*1.0/375

#define kH    (iPhoneX ? 1 : [UIScreen mainScreen].bounds.size.height*1.0/668)

/**
 *  主屏幕宽
 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**
 *  主屏幕高
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) LGUIView *lgView;


@property (nonatomic,strong)UITableView *tableview;


@property (nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation ViewController


- (NSMutableArray *)dataArr
{
	if (!_dataArr) {
		NSArray *arr = @[@{@"header":@"A",@"contents":@[@"Apple",@"AIGUOZHE",@"ADDDIS",@"AIBNI",@"AMM",@"AKM",@"AQOP",@"ANIMA"]},
		@{@"header":@"H",@"contents":@[@"HUAWEI",@"HUMMER",@"HD",@"HF",@"H3",@"H7"]},
		@{@"header":@"O",@"contents":@[@"OPPO",@"OX",@"OM",@"OX",@"OA",@"OO"]},
		@{@"header":@"X",@"contents":@[@"XiaoMi",@"X21",@"XBV",@"XD",@"XG",@"X4",@"X9"]},
		];
		_dataArr = [NSMutableArray arrayWithArray:arr];
	}
	
	return _dataArr;

}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self createUI];
	
	NSMutableArray *indexArr = [NSMutableArray arrayWithObjects:@"A",@"H",@"O",@"X",nil];
	
	self.lgView = [[LGUIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 64, 40, SCREEN_HEIGHT - 64) indexArray:indexArr];
    [self.view addSubview:_lgView];
    __weak typeof(self) weak_self = self;
    [_lgView selectIndexBlock:^(NSInteger section) {
		
			NSLog(@"section--%ld",section);
			// 滚动到对应的区域
			[weak_self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
		
    }];


	
	
}



- (void)createUI
{
	self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
	self.tableview.delegate = self;
	self.tableview.dataSource = self;
	self.tableview.rowHeight = 44;
	self.tableview.sectionHeaderHeight = 36;
	[self.view addSubview:self.tableview];

}



#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataArr[section][@"contents"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	
	return self.dataArr.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UILabel *lbl = [[UILabel alloc]init];
	lbl.textColor = [UIColor redColor];
	lbl.font = [UIFont systemFontOfSize:15.f];
	lbl.text = self.dataArr[section][@"header"];
	lbl.textAlignment = NSTextAlignmentCenter;
	lbl.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
	return lbl;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *ID = @"ID";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
	}
	
	cell.textLabel.text = self.dataArr[indexPath.section][@"contents"][indexPath.row];
	
	return cell;

	

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
