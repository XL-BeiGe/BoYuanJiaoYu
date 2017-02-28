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
@interface StuRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arr;
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
    arr =[NSMutableArray arrayWithObjects:@"语文",@"数学",@"英语",@"物理",@"化学",@"生物",@"思想政治", nil ];
    
    
    
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

- (IBAction)tabelll:(id)sender {
    _table.hidden=NO;
    
}

- (IBAction)FanKui:(id)sender {
    FeedBackViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"feedback"];
    [self.navigationController pushViewController:his animated:YES];
}

- (IBAction)CuoTi:(id)sender {
    RecordViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"record"];
    [self.navigationController pushViewController:his animated:YES];
    //[self.navigationController pushViewController:atten animated:YES];
}

-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    //_table.backgroundColor =[UIColor clearColor];
   self.table.tableFooterView=[[UIView alloc] init];
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
    cell.textLabel.text=arr[indexPath.row];
    cell.textLabel.textAlignment =NSTextAlignmentRight;
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _clas.text =arr[indexPath.row];
    _table.hidden=YES;

}

@end
