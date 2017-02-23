//
//  ClassCenterViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/15.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "ClassCenterViewController.h"
#import "Color+Hex.h"
#import "ClassInfoViewController.h"
@interface ClassCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float width;

}
@end

@implementation ClassCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    self.title =@"课程中心";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor =[UIColor clearColor];
    //self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    width =[UIScreen mainScreen].bounds.size.width;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"heheda";
    UITableViewCell *cell=[self.table dequeueReusableCellWithIdentifier:aa];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    //    for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
    //        [suView removeFromSuperview];//移除全部子视图
    //    }
    
    UIImageView*imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,width, 155)];
    UIImageView*lsimg=[[UIImageView alloc] initWithFrame:CGRectMake(width/2-100,70,20, 20)];
    UIImageView*njimg=[[UIImageView alloc] initWithFrame:CGRectMake(width/2+20,70,20, 20)];
    UIImageView*bmimg=[[UIImageView alloc] initWithFrame:CGRectMake(width/2-100,110,20, 20)];
    UIImageView*xqimg=[[UIImageView alloc] initWithFrame:CGRectMake(width/2+20,110,20, 20)];
    UILabel *banji = [[UILabel alloc]initWithFrame:CGRectMake(30,30, 130, 20)];
    UILabel *jiaos = [[UILabel alloc]initWithFrame:CGRectMake(width/2-75,70,100, 20)];
    UILabel *nianj = [[UILabel alloc]initWithFrame:CGRectMake(width/2+45,70,100, 20)];
    UILabel *baomi = [[UILabel alloc]initWithFrame:CGRectMake(width/2-75,110,100, 20)];
    UILabel *xiang = [[UILabel alloc]initWithFrame:CGRectMake(width/2+45,110,100, 20)];
    
    UILabel *kemu =[[UILabel alloc]initWithFrame:CGRectMake(width-90,30,70, 20)];
    //kemu.backgroundColor =[UIColor blueColor];
    kemu.textAlignment =NSTextAlignmentCenter;
    imageview.image =[UIImage imageNamed:@"课程-背景.png"];
    lsimg.image =[UIImage imageNamed:@"课程-老师.png"];
    njimg.image =[UIImage imageNamed:@"课程-年级.png"];
    bmimg.image =[UIImage imageNamed:@"课程-已报名.png"];
    xqimg.image =[UIImage imageNamed:@"课程-查看详情.png"];
    nianj.font =[UIFont systemFontOfSize:15];
    kemu.font =[UIFont systemFontOfSize:15];
    jiaos.font =[UIFont systemFontOfSize:15];
    banji.font =[UIFont systemFontOfSize:15];
    baomi.font =[UIFont systemFontOfSize:15];
    xiang.font =[UIFont systemFontOfSize:15];
   
    kemu.text =@"政治教育";
    banji.text =@"初一数学A2班";
    jiaos.text =@"张老师";
    nianj.text =@"初中一年级";
    baomi.text =@"已报名";
    xiang.text =@"查看详情";
    
    // qianda.backgroundColor=[UIColor colorWithHexString:@"41beff"];//蓝色
    //qianda.backgroundColor=[UIColor colorWithHexString:@"fc619d"];//粉色
    [cell addSubview:imageview];
    [cell addSubview:lsimg];
    [cell addSubview:njimg];
    [cell addSubview:bmimg];
    [cell addSubview:xqimg];
    
    [cell addSubview:kemu];
    [cell addSubview:nianj];
    [cell addSubview:jiaos];
    [cell addSubview:banji];
    [cell addSubview:baomi];
    [cell addSubview:xiang];
    
    //[cell addSubview:backview];
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"classinfo"];
    [self.navigationController pushViewController:his animated:YES];

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
