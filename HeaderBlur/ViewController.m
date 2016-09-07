//
//  ViewController.m
//  HeaderBlur
//
//  Created by chuanglong02 on 16/7/5.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import "ViewController.h"
#import "MyViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIImageView *iconImageview;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong) UIVisualEffectView *effectview;
@end

@implementation ViewController
{
    CGFloat iconY ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor =[UIColor blueColor];
    UIImage *image =[UIImage imageNamed:@"yishu"];
    CGSize size = image.size;
    self.iconImageview.image = image;
    self.iconImageview.backgroundColor =[UIColor redColor];
    self.iconImageview.frame = CGRectMake(0, 0, KScreenW, KScreenW *size.height /size.width);
    [self.view addSubview:self.iconImageview];
    
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(self.iconImageview.frame), KScreenW, KScreenH);
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor =[UIColor clearColor];
    
    self.iconImageview.backgroundColor =[UIColor clearColor];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    
    
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    effectview.frame = self.iconImageview.bounds;
    
    [self.iconImageview addSubview:effectview];
    self.effectview = effectview;
    self.icon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 80, 80)];
    self.icon.backgroundColor =[UIColor redColor];
    self.icon.layer.cornerRadius = 40;
    self.icon.layer.masksToBounds = YES;
    self.icon.image = [UIImage imageNamed:@"IMG_0990.jpg"];
    [self.iconImageview addSubview:self.icon];
    iconY = self.icon.y;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text  =@"miss_li";
    cell.backgroundColor =[UIColor clearColor];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    UIImage *image =[UIImage imageNamed:@"yishu"];
    CGSize size = image.size;
//    NSLog(@"%f",yOffset);
   
    if (yOffset >= 0) {
        self.tableview.contentOffset = CGPointMake(0, 0);
        self.icon.y = iconY;
    }else
    {
        self.iconImageview.height =size.height - yOffset;
        self.effectview.height = self.iconImageview.height;
        self.icon.y = iconY - yOffset;

    }


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyViewController *myviewVc =[[MyViewController alloc]init];
    [self presentViewController:myviewVc animated:YES completion:nil];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}


- (UITableView *)tableview {
	if(_tableview == nil) {
		_tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
	}
	return _tableview;
}

- (UIImageView *)iconImageview {
	if(_iconImageview == nil) {
		_iconImageview = [[UIImageView alloc] init];
	}
	return _iconImageview;
}



- (UIImageView *)icon {
	if(_icon == nil) {
		_icon = [[UIImageView alloc] init];
	}
	return _icon;
}

@end
