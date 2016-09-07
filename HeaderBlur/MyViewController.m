//
//  MyViewController.m
//  HeaderBlur
//
//  Created by chuanglong02 on 16/7/6.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import "MyViewController.h"
#define kScreenWidth [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight [[UIScreen mainScreen]bounds].size.height

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
//属性列表
/** 顶部图片视图 */
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *headerBackView;
/** 个人信息界面 */
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MyViewController


-(UIView *)headerBackView{
    if (_headerBackView == nil) {
        _headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 200.0 / 375)];
        [_headerBackView setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _headerBackView;
}
-(UIImageView *)headerImageView{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        [_headerImageView setImage:[UIImage imageNamed:@"yishu"]];
        [_headerImageView setBackgroundColor:[UIColor greenColor]];
        [_headerImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headerImageView setClipsToBounds:YES];
    }
    return _headerImageView;
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //添加子视图
    [self addChildViews];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态。
    // 加上此句，返回时直接就是非选中状态。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //初始化cell数据!
    [cell.textLabel setText:@"阿伟"];
    [cell.detailTextLabel setText:@"2016-03-22"];
    
    return cell;
}

//滚动tableview 完毕之后
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //图片高度
    CGFloat imageHeight = self.headerBackView.frame.size.height;
    //图片宽度
    CGFloat imageWidth = kScreenWidth;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    
//    NSLog(@"图片上下偏移量 imageOffsetY:%f ->",imageOffsetY);
    
    
    
    //上移
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        
        self.headerImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
//        self.headerImageView.height = totalOffset;
    }
    
        //下移
        if (imageOffsetY > 0) {
//            CGFloat totalOffset = imageHeight - ABS(imageOffsetY);
//            CGFloat f = totalOffset / imageHeight;
//    
//            [self.headerImageView setFrame:CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset)];
            self.tableView.contentOffset = CGPointMake(0, 0);
        }
    NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));
    NSLog(@"%@",NSStringFromCGRect(self.headerBackView.frame));
    NSLog(@"%@",NSStringFromCGRect(self.headerImageView.frame));
}

#pragma mark - 类内方法
//添加子视图
-(void)addChildViews{
    //添加表格
    [self.view addSubview:self.tableView];
    //添加头像图片
    [self addHeaderImageView];
}
//添加头像
-(void)addHeaderImageView{
    [self.tableView setTableHeaderView:self.headerBackView];
    [self.headerImageView setFrame:self.headerBackView.bounds];
    [self.headerBackView addSubview:self.headerImageView];
}


@end
