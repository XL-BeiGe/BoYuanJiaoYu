//
//  FeedBackViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/16.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "FeedBackViewController.h"
#import "Color+Hex.h"
#import "BackInfoViewController.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
#import "FeedHistoryViewController.h"
@interface FeedBackViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float width;
    UILabel *messa;
    NSMutableArray *arr;
}
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    [self comeback];
    //[self navagat];
    [self ketangfankui];
    [self refrish];
    _backimg.hidden=YES;
    self.title =@"课堂反馈";
    // Do any additional setup after loading the view.
}
-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{

    [self.navigationController popViewControllerAnimated:YES];
}
//课堂反馈
-(void)ketangfankui{
    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/feedbackSubject";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",_classId,@"classId",[def objectForKey:@"officeId"],@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            [WarningBox warningBoxHide:YES andView:self.view];
            arr =[NSMutableArray array];
            arr =[[responseObject objectForKey:@"data"] objectForKey:@"feedbackSubjectList"];
            if(arr.count==0){
                _backimg.hidden =NO;
                _table.hidden =YES;
            }else{
                _table.hidden =NO;
                _backimg.hidden =YES;
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
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败" andView:self.view];
        NSLog(@"失败\n %@",error);
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
    [self ketangfankui];
    [refreshControl endRefreshing];
    //[self.table reloadData];// 刷新tableView即可
}

//-(void)navagat{
//    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
//    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"详情" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
//    [self.navigationItem setRightBarButtonItem:right];
//}
//
//-(void)History{
//    
//}

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
    _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 45;
    }
  
   else{
       return 80;
   }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 7;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"heheda";
    UITableViewCell *cell=[_table cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
//        for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
//            [suView removeFromSuperview];//移除全部子视图
//        }
    if(indexPath.row==0){
        
        UILabel *left1 =[[UILabel alloc]initWithFrame:CGRectMake(15,15,130, 20)];
        UIButton *left2 =[[UIButton alloc]initWithFrame:CGRectMake(width-100,15,70, 20)];
        UIView *fenview= [[UIView alloc]initWithFrame:CGRectMake(0,44,width,1)];
        if(nil==[arr[indexPath.section] objectForKey:@"classLevel"]){
        left1.text =@"";
        }else{
        left1.text = [NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"classLevel"]];
        }
        if(nil==[arr[indexPath.section] objectForKey:@"classType"]){
        [left2 setTitle:@"" forState:UIControlStateNormal];
        }else{
        [left2 setTitle:[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"classType"]] forState:UIControlStateNormal];
            left2.titleLabel.adjustsFontSizeToFitWidth =YES;
        }
        
        
        
        left1.font =[UIFont systemFontOfSize:15];
        left2.titleLabel.font =[UIFont systemFontOfSize:15];
        [left2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        left2.titleLabel.textAlignment =NSTextAlignmentCenter;
        left2.layer.cornerRadius =3;
        
        left2.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
        
        fenview.backgroundColor =[UIColor colorWithHexString:@"f4f4f4"];
        [cell addSubview:left1];
        [cell addSubview:left2];
        [cell addSubview:fenview];
    }
    else{
      
        UIButton *btn1 =[[UIButton alloc]initWithFrame:CGRectMake(10, 30,(width-50)/2, 30)];
        UIButton *btn2 =[[UIButton alloc]initWithFrame:CGRectMake(width/2, 30,(width-50)/2, 30)];
        [btn1 setTitle:@"今日作业" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor colorWithHexString:@"fe528e"] forState:UIControlStateNormal];
        btn1.titleLabel.font =[UIFont systemFontOfSize:15];
        [btn1 setImage:[UIImage imageNamed:@"zuoye.png"] forState:UIControlStateNormal];
        [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        btn1.layer.borderWidth =1;
        btn1.layer.cornerRadius =15;
        btn1.layer.borderColor =[[UIColor colorWithHexString:@"fe528e"]CGColor];
        
        
        [btn2 setTitle:@"历史作业" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor colorWithHexString:@"41beff"] forState:UIControlStateNormal];
        btn2.titleLabel.font =[UIFont systemFontOfSize:15];
        [btn2 setImage:[UIImage imageNamed:@"ceshi.png"] forState:UIControlStateNormal];
        [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        btn2.layer.borderWidth =1;
        btn2.layer.cornerRadius =15;
        btn2.layer.borderColor =[[UIColor colorWithHexString:@"41beff"]CGColor];
        
        [btn1  addTarget:self action:@selector(jinrizuoye:) forControlEvents:UIControlEventTouchUpInside];
        [btn2  addTarget:self action:@selector(lishizuoye:) forControlEvents:UIControlEventTouchUpInside];
        
      
        [cell addSubview:btn1];
        [cell addSubview:btn2];
        
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)jinrizuoye:(UIButton*)btn{
    UITableViewCell *cell=(UITableViewCell*)[[btn superview] superview];
    
    NSIndexPath *index=[_table indexPathForCell:cell];
    
        BackInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"backinfo"];
       his.classID=[NSString stringWithFormat:@"%@",[arr[index.row]objectForKey:@"classId"]];
        [self.navigationController pushViewController:his animated:YES];
}
-(void)lishizuoye:(UIButton*)btn{
   
    UITableViewCell *cell=(UITableViewCell*)[[btn superview] superview ];
    
    NSIndexPath *index=[_table indexPathForCell:cell];
    
    FeedHistoryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"feedhistory"];
    his.classID=[NSString stringWithFormat:@"%@",[arr[index.row]objectForKey:@"classId"]];
 
    [self.navigationController pushViewController:his animated:YES];
    
    
        
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BackInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"backinfo"];
//    his.classID=_classId;
//    [self.navigationController pushViewController:his animated:YES];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
