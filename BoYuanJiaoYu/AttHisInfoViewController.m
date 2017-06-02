//
//  AttHisInfoViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "AttHisInfoViewController.h"
#import "Color+Hex.h"
#import "XL_wangluo.h"
#import "WarningBox.h"
#import "AttentionInfoViewController.h"
@interface AttHisInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float width;
    NSMutableArray *arr;
    NSDictionary *historylis;
}
@end

@implementation AttHisInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"考勤历史";
    [self comeback];
    [self delegate];
     [self wlrequest];
    [self refrish];
    width =[UIScreen mainScreen].bounds.size.width;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
  
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)wlrequest{
    
   [WarningBox warningBoxModeIndeterminate:@"正在加载,请稍后" andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/attend/attendanceHistoryList";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",@"1",@"pageNo",@"10",@"pageSize",_claassID,@"classId",[def objectForKey:@"officeId"],@"officeId", nil];
    NSLog(@"%@",datadic);
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
       [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]){
            arr =[NSMutableArray array];
            arr=[[responseObject objectForKey:@"data"] objectForKey:@"attendList"];
            if(arr.count==0){
                _backimg.hidden =NO;
                _table.hidden=YES;
                
            }else{
                 _backimg.hidden =YES;
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
    [self wlrequest];
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
    _backimg.hidden =YES;
    // _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
    
    UIView*shuxian=[[UIView alloc] initWithFrame:CGRectMake(15,5, 1,90)];
    shuxian.backgroundColor =[UIColor colorWithHexString:@"C9D0D6"];
    UIImageView*imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
    imageview.image =[UIImage imageNamed:@"attendance_history.png"];
    
    //内部构造
    UIView *backview =[[UIView alloc]initWithFrame:CGRectMake(30,10, width-40, 80)];
    backview.backgroundColor =[UIColor whiteColor];
    backview.layer.cornerRadius =5;
    UILabel *banji = [[UILabel alloc]initWithFrame:CGRectMake(backview.frame.size.width-130,15, 120, 20)];
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(10,15, 130, 20)];
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(10,50, 200, 20)];
    
    banji.font =[UIFont systemFontOfSize:15];
    type.font =[UIFont systemFontOfSize:15];
    time.font =[UIFont systemFontOfSize:15];
    banji.textAlignment =NSTextAlignmentRight;
    
    
    
    //签到时间
    if(nil==[arr[indexPath.row]objectForKey:@"attendanceTime"]){
        time.text =@"";
    }else{
        NSString *ss =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"attendanceTime"]];
        ss =[ss substringToIndex:10];
        time.text =[NSString stringWithFormat:@"签到时间:%@",ss];
        
    }
    //签到状态
    if(nil==[arr[indexPath.row]objectForKey:@"state"]){
        type.text =@"";
    }else{
        NSString *sda =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"state"]];
        if([sda intValue]==1){
            type.text =@"未签到";
            type.textColor =[UIColor colorWithHexString:@"C9D0D6"];
        }else if ([sda intValue]==2){
            type.text =@"已签到";
            type.textColor =[UIColor colorWithHexString:@"40bcff"];
        }else if ([sda intValue]==3){
            type.text =@"请假";
            type.textColor =[UIColor colorWithHexString:@"EA2121"];
        }else if ([sda intValue]==4){
            type.text =@"补课";
            type.textColor =[UIColor colorWithHexString:@"fc619d"];
            
        }
     
    }
    //班级
    if(nil==[arr[indexPath.row]objectForKey:@"classType"]){
        banji.text =@"";
    }else{
        banji.text =[NSString stringWithFormat:@"学科:%@",[arr[indexPath.row]objectForKey:@"classType"]];
        
    }
    
    [backview addSubview:type];
    [backview addSubview:banji];
    [backview addSubview:time];
    [cell addSubview:shuxian];
    [cell addSubview:imageview];
    [cell addSubview:backview];
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed=YES;
    AttentionInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"atteninfo"];
    
    historylis =arr[indexPath.row];
    
    his.Historylist =historylis;
    
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
