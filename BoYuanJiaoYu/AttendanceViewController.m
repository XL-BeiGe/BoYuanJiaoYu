//
//  AttendanceViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/14.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "AttendanceViewController.h"
#import "AttenHistoryViewController.h"
@interface AttendanceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float width;
}
@end

@implementation AttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navagat];
    [self delegate];
    self.title =@"最新考勤";
    width =[UIScreen mainScreen].bounds.size.width;
    // Do any additional setup after loading the view.
}
-(void)navagat{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"考勤历史" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)History{
    AttenHistoryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"atthistory"];
    [self.navigationController pushViewController:his animated:YES];
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
    _BackImage.hidden =YES;
    _table.hidden =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row==0){
//        return 55;
//    }else{
//        return 135;
//    }
    return 185;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"heheda";
   UITableViewCell *cell = [_table cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    
//    for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
//        [suView removeFromSuperview];//移除全部子视图
//    }
//    if(indexPath.row==0){
//        
//        UIView *titleview =[[UIView alloc]initWithFrame:CGRectMake(10, 0, width-20, 55)];
//        titleview.backgroundColor =[UIColor whiteColor];
//        UIImageView *leftimg =[[UIImageView alloc]initWithFrame:CGRectMake(-3, 0, 15, 55)];
//        UILabel *banj =[[UILabel alloc]initWithFrame:CGRectMake(30, 15, 120, 25)];
//        UILabel *xuek =[[UILabel alloc]initWithFrame:CGRectMake(titleview.frame.size.width-100, 15,70, 25)];
//        leftimg.image =[UIImage imageNamed:@"banyuan.png"];
//        //leftimg.contentMode = UIViewContentModeScaleAspectFill;//自适应宽度
//        leftimg.contentMode = UIViewContentModeScaleAspectFit;//自适应高度
//        banj.text =@"初一数学A2班";
//        xuek.text =@"数学";
//        xuek.textAlignment =NSTextAlignmentRight;
//        
//        [titleview addSubview:leftimg];
//        [titleview addSubview:banj];
//        [titleview addSubview:xuek];
//        [cell addSubview:titleview];
//        
//    }
//    else if(indexPath.row==1){
//     
//     UIView *mainview =[[UIView alloc]initWithFrame:CGRectMake(20,0, width-40,130)];
//        mainview.backgroundColor =[UIColor whiteColor];
//     UIImageView *toux =[[UIImageView alloc]initWithFrame:CGRectMake(10,10, 25,25)];
//     UIImageView *time =[[UIImageView alloc]initWithFrame:CGRectMake(10,55, 25,25)];
//     UIImageView *beiz =[[UIImageView alloc]initWithFrame:CGRectMake(10,95, 25,25)];
//     
//     UIView *fengev1 =[[UIView alloc]initWithFrame:CGRectMake(10, 45, mainview.frame.size.width-20, 1)];
//     UIView *fengev2 =[[UIView alloc]initWithFrame:CGRectMake(10, 90,  mainview.frame.size.width-20, 1)];
//     
//     fengev1.backgroundColor =[UIColor lightGrayColor];
//     fengev2.backgroundColor =[UIColor lightGrayColor];
//     toux.image =[UIImage imageNamed:@"item_teacher.png"];
//     time.image =[UIImage imageNamed:@"item_time.png"];
//     beiz.image =[UIImage imageNamed:@"item_beizhu.png"];
//        
//        
//     UILabel *name =[[UILabel alloc]initWithFrame:CGRectMake(35, 10, 100, 25)];
//     UILabel *tims =[[UILabel alloc]initWithFrame:CGRectMake(mainview.frame.size.width-140, 15, 120, 25)];
//     UILabel *qian =[[UILabel alloc]initWithFrame:CGRectMake(35, 55, 120, 25)];
//     UILabel *qtyp =[[UILabel alloc]initWithFrame:CGRectMake(mainview.frame.size.width-90, 55, 70, 25)];
//     UILabel *bzhu =[[UILabel alloc]initWithFrame:CGRectMake(35, 95,mainview.frame.size.width-50, 25)];
//        
//     name.text =@"马尔扎哈";
//     tims.text =@"周六:9:00-11:30";
//     qian.text =@"签到时间:8:45";
//     qtyp.text =@"已签到";
//     bzhu.text = @"备注:好好的玩游戏";
//     name.font =[UIFont systemFontOfSize:15];
//     tims.font =[UIFont systemFontOfSize:15];
//     qian.font =[UIFont systemFontOfSize:15];
//     qtyp.font =[UIFont systemFontOfSize:15];
//     bzhu.font =[UIFont systemFontOfSize:15];
//     tims.textAlignment =NSTextAlignmentRight;
//     qtyp.textAlignment =NSTextAlignmentRight;
//        
//        [mainview addSubview:fengev1];
//        [mainview addSubview:fengev2];
//        [mainview addSubview:toux];
//        [mainview addSubview:time];
//        [mainview addSubview:beiz];
//        [mainview addSubview:name];
//        [mainview addSubview:tims];
//        [mainview addSubview:qian];
//        [mainview addSubview:qtyp];
//        [mainview addSubview:bzhu];
//        [cell addSubview:mainview];
//    }
    UIImageView *backimg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 185)];
    backimg.image =[UIImage imageNamed:@"考勤背景.png"];
    UILabel *banj =[[UILabel alloc]initWithFrame:CGRectMake(30, 15, 120, 25)];
    UILabel *xuek =[[UILabel alloc]initWithFrame:CGRectMake(width-110, 15,70, 25)];
    xuek.textAlignment =NSTextAlignmentRight;
    UIImageView *toux =[[UIImageView alloc]initWithFrame:CGRectMake(40,65, 25,25)];
    UIImageView *time =[[UIImageView alloc]initWithFrame:CGRectMake(40,105, 25,25)];
    UIImageView *beiz =[[UIImageView alloc]initWithFrame:CGRectMake(40,145, 25,25)];
    UIView *fengev1 =[[UIView alloc]initWithFrame:CGRectMake(40, 95,width-80, 1)];
    UIView *fengev2 =[[UIView alloc]initWithFrame:CGRectMake(40, 140,width-80, 1)];
    fengev1.backgroundColor =[UIColor lightGrayColor];
    fengev2.backgroundColor =[UIColor lightGrayColor];
    toux.image =[UIImage imageNamed:@"item_teacher.png"];
    time.image =[UIImage imageNamed:@"item_time.png"];
    beiz.image =[UIImage imageNamed:@"item_beizhu.png"];
    UILabel *name =[[UILabel alloc]initWithFrame:CGRectMake(70, 65, 100, 25)];
    UILabel *tims =[[UILabel alloc]initWithFrame:CGRectMake(width-160, 65, 120, 25)];
    UILabel *qian =[[UILabel alloc]initWithFrame:CGRectMake(70, 105, 120, 25)];
    UILabel *qtyp =[[UILabel alloc]initWithFrame:CGRectMake(width-110,105, 70, 25)];
    UILabel *bzhu =[[UILabel alloc]initWithFrame:CGRectMake(70, 145,width-105, 25)];
    name.font =[UIFont systemFontOfSize:15];
    tims.font =[UIFont systemFontOfSize:15];
    qian.font =[UIFont systemFontOfSize:15];
    qtyp.font =[UIFont systemFontOfSize:15];
    bzhu.font =[UIFont systemFontOfSize:15];
    tims.textAlignment =NSTextAlignmentRight;
    qtyp.textAlignment =NSTextAlignmentRight;
    
    
    banj.text =@"初一数学A2班";
    xuek.text =@"数学";
    name.text =@"马尔扎哈哈哈";
    tims.text =@"周六:9:00-11:30";
    qian.text =@"签到时间:8:45";
    qtyp.text =@"已签到";
    bzhu.text = @"备注:工作";
    
    [cell addSubview:backimg];
    [cell addSubview:banj];
    [cell addSubview:xuek];
    [cell addSubview:fengev1];
    [cell addSubview:fengev2];
    [cell addSubview:toux];
    [cell addSubview:time];
    [cell addSubview:beiz];
    [cell addSubview:name];
    [cell addSubview:tims];
    [cell addSubview:qian];
    [cell addSubview:qtyp];
    [cell addSubview:bzhu];
    
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
