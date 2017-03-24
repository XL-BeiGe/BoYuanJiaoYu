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
@interface StuRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
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
    [self delegate];
    self.title =@"学习档案";
    tab=YES;
    
    [self baobanliebiao];
    [self thdigls];
    
    // Do any additional setup after loading the view.
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
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/attendanceInfoList";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",[def objectForKey:@"officeId"],@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            arr =[NSMutableArray array];
            arr =[[responseObject objectForKey:@"data"] objectForKey:@"classList"];
            if(arr.count==0){
                _table.hidden =YES;
                [WarningBox warningBoxModeText:@"尚未选课" andView:self.view];
            }else{
             [_table reloadData];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];

}
-(void)thdigls{
    _tableView.layer.masksToBounds =YES;
    _table.frame=CGRectMake(0, 0-_tableView.frame.size.height, _tableView.frame.size.width,170) ;
}
-(void)upanimal{
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.5];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
    _table.frame=CGRectMake(0, 0-_tableView.frame.size.height, _tableView.frame.size.width,170);
    [UIView commitAnimations];
    
}
-(void)didStopAnimation{
    
 _tableView.hidden =YES;
}
-(void)didbeginAnimation{
 _tableView.hidden=NO;
}
- (IBAction)tabelll:(id)sender {
    if(tab==YES){
        tab=NO;
        _tableView.hidden=NO;
        [UIView beginAnimations:nil context:nil];
        //执行动画
        //设置动画执行时间
        [UIView setAnimationDuration:0.5];
        //设置代理
        [UIView setAnimationDelegate:self];
        //设置动画执行完毕调用的事件
        [UIView setAnimationDidStopSelector:@selector(didbeginAnimation)];
        _table.frame=CGRectMake(0,0,_tableView.frame.size.width,170);

        [UIView commitAnimations];
        
    }else{
        tab=YES;
        [self upanimal];
       
       // _tableView.hidden =YES;
    }
    
    
}

- (IBAction)FanKui:(id)sender {
    
    if([_clas.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"您没有选课" andView:self.view];
    }else{
    
    FeedBackViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"feedback"];
        his.classId =clasid;
//        [[NSUserDefaults standardUserDefaults]setObject:clasid forKey:@"classid"];
        
    [self.navigationController pushViewController:his animated:YES];
    }
}

- (IBAction)CuoTi:(id)sender {
//    if([_clas.text isEqualToString:@""]){
//        [WarningBox warningBoxModeText:@"您没有选课" andView:self.view];
//    }else{
    RecordViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"record"];
    [self.navigationController pushViewController:his animated:YES];
    //[self.navigationController pushViewController:atten animated:YES];
    //}
}

-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor =[UIColor clearColor];
   self.table.tableFooterView=[[UIView alloc] init];
    _table.bounces =NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
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
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"className"]];
    cell.textLabel.textAlignment =NSTextAlignmentRight;
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _clas.text =[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"className"]];
    clasid =[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"classId"]];
    [self upanimal];
    tab=YES;
}

@end
