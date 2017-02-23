//
//  RecordViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/17.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
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
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"rell";
    UITableViewCell *cell=[self.table dequeueReusableCellWithIdentifier:aa];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    //    for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
    //        [suView removeFromSuperview];//移除全部子视图
    //    }
    UIView *backview = (UIView*)[cell viewWithTag:102];
    UIView *leftview = (UIView*)[cell viewWithTag:100];
    UIView *fengview = (UIView*)[cell viewWithTag:101];
    
    UILabel *title =(UILabel*)[cell viewWithTag:200];
    UIButton *class =(UIButton*)[cell viewWithTag:201];
    UILabel *groud =(UILabel*)[cell viewWithTag:202];
    UILabel *zhang =(UILabel*)[cell viewWithTag:203];
    UILabel *numbe =(UILabel*)[cell viewWithTag:204];
    UILabel *laiyu =(UILabel*)[cell viewWithTag:205];
    UILabel *fancu =(UILabel*)[cell viewWithTag:206];
    UILabel *fcnum =(UILabel*)[cell viewWithTag:207];
    UILabel *gwron =(UILabel*)[cell viewWithTag:208];
    UILabel *wrnum =(UILabel*)[cell viewWithTag:209];
    
    backview.backgroundColor =[UIColor whiteColor];
    backview.layer.cornerRadius =10;
    leftview.layer.borderWidth =0;
    fengview.layer.borderWidth =0;
    class.layer.cornerRadius =5;
    title.text =@"这是一个测试标题啦啦啦啦啦啦啦";
    [class setTitle:@"数学" forState:UIControlStateNormal];
    groud.text =@"初中一年级";
    zhang.text =@"第三册第五章";
    numbe.text =@"试题编号:102102";
    laiyu.text =@"来源:课堂测试";
    fancu.text =@"犯错次数:";
    fcnum.text =@"150次";
    gwron.text =@"个人犯错:";
    wrnum.text =@"3次";
    
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
