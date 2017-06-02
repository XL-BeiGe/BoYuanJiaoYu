//
//  AttendanceViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/14.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "AttendanceViewController.h"
#import "AttenHistoryViewController.h"
#import "Color+Hex.h"
#import "XL_wangluo.h"
#import "WarningBox.h"
@interface AttendanceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float width;
    NSMutableArray *arr;
}
@end

@implementation AttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navagat];
    [self delegate];
   
    [self refrish];
    self.title =@"最新考勤";
    width =[UIScreen mainScreen].bounds.size.width;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
 [self lirequest];
}

-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)navagat{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"历史考勤" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)History{
    
    self.hidesBottomBarWhenPushed=YES;
    AttenHistoryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"atthistory"];
    [self.navigationController pushViewController:his animated:YES];
     self.hidesBottomBarWhenPushed=NO;
}


-(void)lirequest{
    [WarningBox warningBoxModeIndeterminate:@"正在加载,请稍后" andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/attend/attendMainList";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",[def objectForKey:@"officeId"],@"officeId",@"1",@"pageNo",@"10",@"pageSize", nil];
   
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
       [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            
            arr = [NSMutableArray array];
            arr=[[responseObject objectForKey:@"data"] objectForKey:@"attendList"];
            if(arr.count==0){
                _BackImage.hidden=NO;
                _table.hidden=YES;
                
            }else{
                _BackImage.hidden=YES;
                _table.hidden=NO;
                [_table reloadData];
            }
        
          
        }
        else if ([[responseObject objectForKey:@"code"]isEqual:@"9999"]){
            //账号在其他手机登录，请重新登录。
            [XL_wangluo sigejiu:self];
        }
        else{
            [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！" andView:self.view];
    }];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--刷新方法
-(void)refrish{
    //NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:refreshControl];
    
}
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    
    [refreshControl beginRefreshing];
    
    // NSLog(@"refreshClick: -- 刷新触发");
    // 此处添加刷新tableView数据的代码
    [self lirequest];
    [refreshControl endRefreshing];
    //[self.table reloadData];// 刷新tableView即可
}
-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor =[UIColor clearColor];
    //self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _BackImage.hidden=YES;
    //_table.bounces =NO;
   // _table.hidden =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

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
    //备用方案
    {
        
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
    }
    
    UIImageView *backimg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 185)];
    backimg.image =[UIImage imageNamed:@"考勤背景.png"];
    UILabel *banj =[[UILabel alloc]initWithFrame:CGRectMake(30, 15,180, 25)];
    UILabel *xuek =[[UILabel alloc]initWithFrame:CGRectMake(width-120, 15,80, 25)];
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
    UILabel *qian =[[UILabel alloc]initWithFrame:CGRectMake(70, 105, 140, 25)];
    UILabel *qtyp =[[UILabel alloc]initWithFrame:CGRectMake(width-110,105, 70, 25)];
    UILabel *bzhu =[[UILabel alloc]initWithFrame:CGRectMake(70, 145,width-105, 25)];
    banj.adjustsFontSizeToFitWidth =YES;
    xuek.adjustsFontSizeToFitWidth =YES;
    name.font =[UIFont systemFontOfSize:15];
    tims.font =[UIFont systemFontOfSize:15];
    qian.font =[UIFont systemFontOfSize:15];
    qtyp.font =[UIFont systemFontOfSize:15];
    bzhu.font =[UIFont systemFontOfSize:15];
    tims.textAlignment =NSTextAlignmentRight;
    qtyp.textAlignment =NSTextAlignmentRight;
   
    //班级名称
    if(nil==[arr[indexPath.section]objectForKey:@"className"]){
        banj.text =@"";
    }else{
      banj.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"className"]];
       
    }
    //科目
    if(nil==[arr[indexPath.section]objectForKey:@"classType"]){
       xuek.text =@"";
    }else{
        xuek.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"classType"]];
       
    }
    //授课教师
    if(nil==[arr[indexPath.section]objectForKey:@"teacherName"]){
       name.text =@"";
    }else{
        NSString *iqoq =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"teacherName"]];
        iqoq =[iqoq substringToIndex:1];
        name.text =[NSString stringWithFormat:@"%@老师",iqoq];
        
    }
    //上课时间
    if(nil==[arr[indexPath.section]objectForKey:@"classTimeBegin"]){
        tims.text =@"";
    }else{
        tims.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"classTimeBegin"]];
       
    }
    //签到时间
    if(nil==[arr[indexPath.section]objectForKey:@"attendanceTime"]){
        qian.text =@"";
    }else{
        NSString *ss =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"attendanceTime"]];
        ss =[ss substringFromIndex:ss.length-8];
        qian.text =[NSString stringWithFormat:@"签到时间:%@",ss];
       
    }
    //签到状态
    if(nil==[arr[indexPath.section]objectForKey:@"state"]){
        qtyp.text =@"";
    }else{
        NSString *sda =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"state"]];
        if([sda intValue]==1){
        qtyp.text =@"未签到";
        qtyp.textColor =[UIColor colorWithHexString:@"C9D0D6"];
        }else if ([sda intValue]==2){
        qtyp.text =@"已签到";
        qtyp.textColor =[UIColor colorWithHexString:@"40bcff"];
        }else if ([sda intValue]==3){
          qtyp.text =@"请假";
         qtyp.textColor =[UIColor colorWithHexString:@"40bcff"];
        }else if ([sda intValue]==4){
            qtyp.text =@"补课";
         qtyp.textColor =[UIColor colorWithHexString:@"40bcff"];
          
        }
        
        
        
       
    }
    //备注
    if(nil==[arr[indexPath.section]objectForKey:@"info"]){
      bzhu.text =@"";
    }else{
    
        bzhu.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"info"]];
    }
    
    
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
