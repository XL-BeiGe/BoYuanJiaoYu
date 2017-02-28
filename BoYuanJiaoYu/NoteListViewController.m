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
@interface NoteListViewController ()
{
    float width;
    float height;
}
@end

@implementation NoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    self.title =@"通知列表";
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
    height =[UIScreen mainScreen].bounds.size.height;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
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
    
    UIView*shuxian=[[UIView alloc] initWithFrame:CGRectMake(0,0,width,50)];
    shuxian.backgroundColor =[UIColor whiteColor];
    UIImageView*imageview=[[UIImageView alloc] initWithFrame:CGRectMake(15,10, 30, 30)];
    imageview.image =[UIImage imageNamed:@"attendance_history.png"];

    UILabel *banji = [[UILabel alloc]initWithFrame:CGRectMake(55,10,200,30)];
    
    banji.font =[UIFont systemFontOfSize:15];

    banji.text =@"这里是通知标题";
    [shuxian addSubview:imageview];
    [shuxian addSubview:banji];
    [cell addSubview:shuxian];
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
     instantiateViewControllerWithIdentifier:@"noteinfo"];
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
