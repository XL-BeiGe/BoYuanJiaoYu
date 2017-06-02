//
//  StuRecordViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/20.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "StuRecordViewController.h"
#import "FeedBackViewController.h"
#import "RecordViewController.h"
#import "Color+Hex.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
@interface StuRecordViewController ()
{
    BOOL tab;
    NSMutableArray *arr;
    NSString*clasid;
    
}
@end

@implementation StuRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _view1.layer.borderWidth =1;
    _view1.layer.cornerRadius =20;
    _view1.layer.borderColor =[[UIColor lightGrayColor]CGColor];
    //[self delegate];
    self.title =@"学习档案";
    //tab=YES;
    
    
    //[self thdigls];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
   [self baobanliebiao];
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
//报班集合
-(void)baobanliebiao{
    [WarningBox warningBoxModeIndeterminate:@"正在加载,请稍后" andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/attendanceInfoList";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",[def objectForKey:@"officeId"],@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
       
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
             [WarningBox warningBoxHide:YES andView:self.view];
            arr =[NSMutableArray array];
            arr =[[responseObject objectForKey:@"data"] objectForKey:@"classList"];
            if(arr.count==0){
                _table.hidden =YES;
                [WarningBox warningBoxModeText:@"尚未选课" andView:self.view];
            }else{
            // [_table reloadData];
           
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
         [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败" andView:self.view];
        NSLog(@"失败\n %@",error);
    }];

}
- (IBAction)tabelll:(id)sender {
    [self tan];
//    if(tab==YES){
//        tab=NO;
//        _tableView.hidden=NO;
//        [UIView beginAnimations:nil context:nil];
//        //执行动画
//        //设置动画执行时间
//        [UIView setAnimationDuration:0.5];
//        //设置代理
//        [UIView setAnimationDelegate:self];
//        //设置动画执行完毕调用的事件
//        [UIView setAnimationDidStopSelector:@selector(didbeginAnimation)];
//        _table.frame=CGRectMake(0,0,_tableView.frame.size.width,170);
//
//        [UIView commitAnimations];
//        
//    }else{
//        tab=YES;
//        [self upanimal];
//       
//       // _tableView.hidden =YES;
//    }
    
    
}

-(void)tan{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      clasid =[NSString stringWithFormat:@"0"];
       _clas.text =[NSString stringWithFormat:@"全部"];
   
    }];
    
    [alert addAction:action];
    for (int index = 0; index <arr.count; index++) {
        int  key = index;
        NSString*message=[NSString stringWithFormat:@"%@",[arr[key] objectForKey:@"className"]];
        UIAlertAction * action = [UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _clas.text =[NSString stringWithFormat:@"%@",[arr[key] objectForKey:@"className"]];
            clasid =[NSString stringWithFormat:@"%@",[arr[key] objectForKey:@"classId"]];
            
            
            
        }];
        [alert addAction:action];
    }
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



- (IBAction)FanKui:(id)sender {
    
    if([_clas.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"您没有选课" andView:self.view];
    }else{
     self.hidesBottomBarWhenPushed=YES;
    FeedBackViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"feedback"];
        his.classId =clasid;
//        [[NSUserDefaults standardUserDefaults]setObject:clasid forKey:@"classid"];
        
    [self.navigationController pushViewController:his animated:YES];
         self.hidesBottomBarWhenPushed=NO;
    }
}

- (IBAction)CuoTi:(id)sender {
    if([_clas.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"您没有选课" andView:self.view];
    }else{
        self.hidesBottomBarWhenPushed=YES;  
    RecordViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"record"];
    [self.navigationController pushViewController:his animated:YES];
         self.hidesBottomBarWhenPushed=NO;
    //[self.navigationController pushViewController:atten animated:YES];
    }
}

//-(void)thdigls{
//    _tableView.layer.masksToBounds =YES;
//    _table.frame=CGRectMake(0, 0-_tableView.frame.size.height, _tableView.frame.size.width,170) ;
//}
//-(void)upanimal{
//    [UIView beginAnimations:nil context:nil];
//    //执行动画
//    //设置动画执行时间
//    [UIView setAnimationDuration:0.5];
//    //设置代理
//    [UIView setAnimationDelegate:self];
//    //设置动画执行完毕调用的事件
//    [UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
//    _table.frame=CGRectMake(0, 0-_tableView.frame.size.height, _tableView.frame.size.width,170);
//    [UIView commitAnimations];
//    
//}
//-(void)didStopAnimation{
//    
//    _tableView.hidden =YES;
//}
//-(void)didbeginAnimation{
//    _tableView.hidden=NO;
//}



//-(void)delegate{
//    _table.delegate=self;
//    _table.dataSource=self;
//    _table.backgroundColor =[UIColor clearColor];
//   self.table.tableFooterView=[[UIView alloc] init];
//    _table.bounces =NO;
////    self.automaticallyAdjustsScrollViewInsets = NO;
////    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return arr.count;
//    
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 44;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *aa=@"heheda";
//    UITableViewCell *cell = [_table cellForRowAtIndexPath:indexPath];
//    if (cell==nil) {
//        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
//    }
//    cell.textLabel.text=[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"className"]];
//    cell.textLabel.textAlignment =NSTextAlignmentRight;
//    
//    cell.selectionStyle =UITableViewCellSelectionStyleNone;
//    return cell;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    _clas.text =[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"className"]];
//    clasid =[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"classId"]];
//    [self upanimal];
//    tab=YES;
//}

@end
