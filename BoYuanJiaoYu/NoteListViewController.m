//
//  NoteListViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/24.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "NoteListViewController.h"
#import "NoteInfoViewController.h"
#import "Color+Hex.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
@interface NoteListViewController ()
{
    float width;
    float height;
    NSMutableArray *arr;
}
@end

@implementation NoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    [self wangluo];
    self.title =@"通知列表";
    [self comeback];
    //没拿到具体列表名称 未读提示写的不全
    
    
    
    
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


-(void)wangluo{
    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/userInfo/pushList";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            [WarningBox warningBoxHide:YES andView:self.view];
            arr =[NSMutableArray array];
            arr =[[responseObject objectForKey:@"data"] objectForKey:@"List"];
            
            
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接错误" andView:self.view];
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
    [self wangluo];
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
    width =[UIScreen mainScreen].bounds.size.width;
    height =[UIScreen mainScreen].bounds.size.height;
    _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
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
    
    UIView*backview=[[UIView alloc] initWithFrame:CGRectMake(0,0,width-20,50)];
    backview.backgroundColor =[UIColor whiteColor];
    UIImageView*imageview=[[UIImageView alloc] initWithFrame:CGRectMake(15,10, 30, 30)];
    imageview.image =[UIImage imageNamed:@"attendance_history.png"];

    UILabel *banji = [[UILabel alloc]initWithFrame:CGRectMake(55,10,200,30)];
    
    banji.font =[UIFont systemFontOfSize:15];
    
    banji.text =@"这里是通知标题";
    UIImageView*imageview1=[[UIImageView alloc] initWithFrame:CGRectMake(width-40,35,15,10)];
    if(nil==[arr[indexPath.section]objectForKey:@""]){
      imageview1.image =[UIImage imageNamed:@"新消息提示-2.png"];
    }else{
      imageview1.image =[UIImage imageNamed:@""];
    }
   
    
    
    
    [backview addSubview:imageview];
    [backview addSubview:banji];
    [backview addSubview:imageview1];
    [cell addSubview:backview];
    
    
    backview.layer.cornerRadius =5;
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
     instantiateViewControllerWithIdentifier:@"noteinfo"];
    his.pushId =@"";
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
