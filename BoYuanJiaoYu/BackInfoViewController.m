//
//  BackInfoViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/25.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "BackInfoViewController.h"
#import "BackHistoryViewController.h"
#import "Color+Hex.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
@interface BackInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float width;
    UILabel *title;
    UILabel *ownans;
    UILabel *answer;
}
@end

@implementation BackInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navagat];
    [self delegate];
    [self fankuixiangqing];
    self.title =@"反馈详情";
    // Do any additional setup after loading the view.
}
-(void)navagat{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"反馈历史" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)History{
    BackHistoryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"backhis"];
    [self.navigationController pushViewController:his animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fankuixiangqing{
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/feedbackInfo";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",_currentBatchId,@"currentBatchId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
          
            
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];


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
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else{
        return 3;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 60;
    }else{
        if(indexPath.row==0){
            NSString* ss=[[NSString alloc] init];
                        //            if(nil==[pushTemplate objectForKey:@"title"]){
                        //                ss =@"";
                        //            }else{
                        //                ss =[NSString stringWithFormat:@"%@",[pushTemplate objectForKey:@"context"]];
                        //            }
            ss =@"因为iPhone平庸了几代，也因为今年是iPhone诞生十周年，人们对iPhone 8的期望格外高一些。关于即将到来的iPhone 8，坊间曾盛传其将取消实体Home键，支持屏幕指纹识别功能。如果说这之前是人们一厢情愿的期望，那么现在还真已经有了一些切实依据。据了解，苹果曾收购过一家叫做LuxVue的公司，而该公司在micro-LED方面颇有研究。通过收购，苹果已经获得了包括一种超薄柔性屏生产方法在内的一系列知识产权。现如今，苹果又获得了一项专利，详细描述了一种通过红外发射器、传感器和高分辨率触摸来读取指纹的屏幕。";
            title=[[UILabel alloc] init];
            UIFont *font = [UIFont fontWithName:@"Arial" size:15];
            NSAttributedString *attributedText =[[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-50, CGFLOAT_MAX}
                                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                                   context:nil];
            
            title.text=ss;
            [title setFrame:CGRectMake(25,10, rect.size.width, rect.size.height)];
                        
            return title.frame.size.height+15>40? title.frame.size.height+15:40;
            }
        

      
        if (indexPath.row==1){
            NSString* ss=[[NSString alloc] init];
            //            if(nil==[pushTemplate objectForKey:@"title"]){
            //                ss =@"";
            //            }else{
            //                ss =[NSString stringWithFormat:@"%@",[pushTemplate objectForKey:@"context"]];
            //            }
            ss =@"因为iPhone平庸了几代，也因为今年是iPhone诞生十周年，人们对iPhone 8的期望格外高一些。关于即将到来的iPhone 8，坊间曾盛传其将取消实体Home键，支持屏幕指纹识别功能。如果说这之前是人们一厢情愿的期望，那么现在还真已经有了一些切实依据。据了解，苹果曾收购过一家叫做LuxVue的公司，而该公司在micro-LED方面颇有研究。通过收购，苹果已经获得了包括一种超薄柔性屏生产方法在内的一系列知识产权。现如今，苹果又获得了一项专利，详细描述了一种通过红外发射器、传感器和高分辨率触摸来读取指纹的屏幕。";
            ownans=[[UILabel alloc] init];
            UIFont *font = [UIFont fontWithName:@"Arial" size:15];
            NSAttributedString *attributedText =
            [[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-150, CGFLOAT_MAX}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
            
            ownans.text=ss;
            [ownans setFrame:CGRectMake(100,15, rect.size.width, rect.size.height)];
            
            return ownans.frame.size.height+15>40? ownans.frame.size.height+15:40;
        }
        if (indexPath.row==2){
            NSString* ss=[[NSString alloc] init];
            //            if(nil==[pushTemplate objectForKey:@"title"]){
            //                ss =@"";
            //            }else{
            //                ss =[NSString stringWithFormat:@"%@",[pushTemplate objectForKey:@"context"]];
            //            }
            ss =@"因为iPhone平庸了几代，也因为今年是iPhone诞生十周年，人们对iPhone 8的期望格外高一些。关于即将到来的iPhone 8，坊间曾盛传其将取消实体Home键，支持屏幕指纹识别功能。如果说这之前是人们一厢情愿的期望，那么现在还真已经有了一些切实依据。据了解，苹果曾收购过一家叫做LuxVue的公司，而该公司在micro-LED方面颇有研究。通过收购，苹果已经获得了包括一种超薄柔性屏生产方法在内的一系列知识产权。现如今，苹果又获得了一项专利，详细描述了一种通过红外发射器、传感器和高分辨率触摸来读取指纹的屏幕。";
            answer=[[UILabel alloc] init];
            UIFont *font = [UIFont fontWithName:@"Arial" size:15];
            NSAttributedString *attributedText =
            [[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-130, CGFLOAT_MAX}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
            
            answer.text=ss;
            [answer setFrame:CGRectMake(100,15, rect.size.width, rect.size.height)];
            
            return answer.frame.size.height+25>40? answer.frame.size.height+25:40;
        }
        else{
            return 40;
        }
     
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else
        return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"heheda";
    UITableViewCell *cell=[self.table cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    //    for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
    //        [suView removeFromSuperview];//移除全部子视图
    //    }
    if(indexPath.section==0){
        UILabel *score =[[UILabel alloc]initWithFrame:CGRectMake(width/2-40,10,70,40)];
        
        score.textAlignment =NSTextAlignmentCenter;
        score.font =[UIFont systemFontOfSize:25];
        score.text =@"100分";
        score.textColor =[UIColor redColor];
        [cell addSubview:score];
        cell.backgroundColor =[UIColor clearColor];
    }else{
        if(indexPath.row==0){
           
            UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(10, 15,10,10)];
            img.image =[UIImage imageNamed:@"teacher.png"];
            title.numberOfLines =0;
            title.font =[UIFont fontWithName:@"Arial" size:15];
            
            [cell addSubview:img];
            [cell addSubview:title];
        }else if (indexPath.row==1){
            UIView *iii =[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 1)];
            iii.backgroundColor =[UIColor redColor];
            [cell addSubview:iii];
            UILabel *owns =[[UILabel alloc]initWithFrame:CGRectMake(25, 15,70, 20)];
            owns.text =@"我的回答:";
            owns.font =[UIFont systemFontOfSize:15];
            
            ownans.numberOfLines =0;
            ownans.font =[UIFont fontWithName:@"Arial" size:15];
            
            UIImageView *imgs =[[UIImageView alloc]initWithFrame:CGRectMake(width-50, 15,25,25)];
            imgs.image =[UIImage imageNamed:@"teacher.png"];
            
            [cell addSubview:owns];
            [cell addSubview:ownans];
            [cell addSubview:imgs];
        }else{
            UILabel *owns =[[UILabel alloc]initWithFrame:CGRectMake(25, 15,70, 20)];
            owns.text =@"正确答案:";
            owns.font =[UIFont systemFontOfSize:15];
    
            answer.numberOfLines =0;
            answer.font =[UIFont fontWithName:@"Arial" size:15];
    
            [cell addSubview:owns];
            [cell addSubview:answer];
        
        }
    
    
    }
   
    
    
    cell.layer.cornerRadius =5;
    
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
