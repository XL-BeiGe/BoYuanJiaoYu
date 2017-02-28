//
//  BackHistoryViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/25.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "BackHistoryViewController.h"
#import "Color+Hex.h"
@interface BackHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float width;
}
@end

@implementation BackHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    self.title =@"反馈历史";
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
    return 60;
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
    
    UIView*shuxian=[[UIView alloc] initWithFrame:CGRectMake(15,5, 1,60)];
    shuxian.backgroundColor =[UIColor colorWithHexString:@"C9D0D6"];
    UIImageView*imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
    imageview.image =[UIImage imageNamed:@"attendance_history.png"];
    
    //内部构造
    UIView *backview =[[UIView alloc]initWithFrame:CGRectMake(30,10, width-40, 50)];
    backview.backgroundColor =[UIColor whiteColor];
    backview.layer.cornerRadius =5;
    UILabel *banji = [[UILabel alloc]initWithFrame:CGRectMake(10,15, 130, 20)];
    UILabel *xueke = [[UILabel alloc]initWithFrame:CGRectMake(backview.frame.size.width-130,15, 120, 20)];
    banji.font =[UIFont systemFontOfSize:15];
    xueke.font =[UIFont systemFontOfSize:15];
    xueke.textAlignment =NSTextAlignmentRight;
   
    banji.text =@"这旮沓是作业标题";
    xueke.text =@"时间:8:45";

    
    xueke.textColor=[UIColor colorWithHexString:@"41beff"];//蓝色
    //qianda.textColor=[UIColor colorWithHexString:@"fc619d"];//粉色
    
    [backview addSubview:banji];
    [backview addSubview:xueke];
    [cell addSubview:shuxian];
    [cell addSubview:imageview];
    [cell addSubview:backview];
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
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
