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
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/feedbackSubject";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",_classId,@"classId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            arr =[NSMutableArray array];
            arr =[[responseObject objectForKey:@"data"] objectForKey:@"feedbackSubjectList"];
            if(arr.count==0){
                NSLog(@"暂无反馈");
            }else{
             [_table reloadData];
            }
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];

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
        return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 45;
    }
  else if(indexPath.row==1){
            return 40;
        }
   else if (indexPath.row==2){
            NSString* ss=[[NSString alloc] init];
                        if(nil==[arr[indexPath.section] objectForKey:@"comment"]){
                            ss =@"";
                        }else{
                            ss =[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"comment"]];
                       }
            messa=[[UILabel alloc] init];
            UIFont *font = [UIFont fontWithName:@"Arial" size:15];
            NSAttributedString *attributedText =
            [[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-50, CGFLOAT_MAX}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
            
            messa.text=ss;
            [messa setFrame:CGRectMake(20,4, rect.size.width, rect.size.height)];
            
            return messa.frame.size.height+15>40? messa.frame.size.height+5:40;
        }
   else{
       return 60;
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
    else if (indexPath.row==1){
    
        UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 30, 30)];
        UILabel *dianp =[[UILabel alloc]initWithFrame:CGRectMake(50,10,70, 20)];
         dianp.font =[UIFont systemFontOfSize:15];
         dianp.text =@"教师点评:";
         img.image =[UIImage imageNamed:@"teacher.png"];
        [cell addSubview:img];
        [cell addSubview:dianp];
    }
    else if (indexPath.row==2){
      
        messa.numberOfLines =0;
        messa.font =[UIFont fontWithName:@"Arial" size:15];
        
        [cell addSubview:messa];
    }
    else{
      
        UIButton *btn1 =[[UIButton alloc]initWithFrame:CGRectMake(width/2-140, 10, 130, 30)];
        UIButton *btn2 =[[UIButton alloc]initWithFrame:CGRectMake(width/2+20, 10, 130, 30)];
        [btn1 setTitle:@"今日作业" forState:UIControlStateNormal];
        [btn2 setTitle:@"课堂测试" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor colorWithHexString:@"fe528e"] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor colorWithHexString:@"01b9fe"] forState:UIControlStateNormal];
        btn1.titleLabel.font =[UIFont systemFontOfSize:15];
        btn2.titleLabel.font =[UIFont systemFontOfSize:15];
        [btn1 setImage:[UIImage imageNamed:@"zuoye.png"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"ceshi.png"] forState:UIControlStateNormal];
        [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        btn1.layer.borderWidth =1;
        btn2.layer.borderWidth =1;
        btn1.layer.cornerRadius =15;
        btn2.layer.cornerRadius =15;
        btn1.layer.borderColor =[[UIColor colorWithHexString:@"fe528e"]CGColor];
        btn2.layer.borderColor =[[UIColor colorWithHexString:@"01b9fe"]CGColor];
        [cell addSubview:btn1];
        [cell addSubview:btn2];
        
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BackInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"backinfo"];
    his.currentBatchId =[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"currentBatchId"]];
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
