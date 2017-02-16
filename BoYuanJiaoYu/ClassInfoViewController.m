//
//  ClassInfoViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/15.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "ClassInfoViewController.h"

@interface ClassInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float width;
    UILabel*messa;
}
@end

@implementation ClassInfoViewController

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
    width =[UIScreen mainScreen].bounds.size.width;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==1){
        return 4;
    }else{
     return 1;
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 85;
    }else{
        if(indexPath.row==2){
            return 80;
        }
       if (indexPath.row==1){
            NSString* ss=[[NSString alloc] init];
//            if(nil==[pushTemplate objectForKey:@"title"]){
//                ss =@"";
//            }else{
//                ss =[NSString stringWithFormat:@"%@",[pushTemplate objectForKey:@"context"]];
//            }
           ss =@"因为iPhone平庸了几代，也因为今年是iPhone诞生十周年，人们对iPhone 8的期望格外高一些。关于即将到来的iPhone 8，坊间曾盛传其将取消实体Home键，支持屏幕指纹识别功能。如果说这之前是人们一厢情愿的期望，那么现在还真已经有了一些切实依据。据了解，苹果曾收购过一家叫做LuxVue的公司，而该公司在micro-LED方面颇有研究。通过收购，苹果已经获得了包括一种超薄柔性屏生产方法在内的一系列知识产权。现如今，苹果又获得了一项专利，详细描述了一种通过红外发射器、传感器和高分辨率触摸来读取指纹的屏幕。";
            messa=[[UILabel alloc] init];
            UIFont *font = [UIFont fontWithName:@"Arial" size:15];
            NSAttributedString *attributedText =
            [[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-40, CGFLOAT_MAX}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
            
            messa.text=ss;
            [messa setFrame:CGRectMake(20,4, rect.size.width, rect.size.height)];
            
            return messa.frame.size.height+15>40? messa.frame.size.height+5:40;
        }
      else{
            return 40;
        }
   
    }
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 5;
    }else
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
    if(indexPath.section==0){
       UILabel *banj =[[UILabel alloc]initWithFrame:CGRectMake(20,10,100, 20)];
       UILabel *xuek =[[UILabel alloc]initWithFrame:CGRectMake(width-90,10,70, 20)];
       UILabel *laos =[[UILabel alloc]initWithFrame:CGRectMake(20,30,100, 20)];
       UILabel *niaj =[[UILabel alloc]initWithFrame:CGRectMake(width-100,30,80, 20)];
       UILabel *shij =[[UILabel alloc]initWithFrame:CGRectMake(20,55,150, 20)];
       //kemu.backgroundColor =[UIColor blueColor];
       xuek.textAlignment =NSTextAlignmentRight;
       niaj.textAlignment =NSTextAlignmentRight;
       banj.font =[UIFont systemFontOfSize:15];
       laos.font =[UIFont systemFontOfSize:15];
       shij.font =[UIFont systemFontOfSize:15];
       xuek.font =[UIFont systemFontOfSize:15];
       niaj.font =[UIFont systemFontOfSize:15];
        
       banj.text =@"初一数学A2班";
       laos.text =@"张老师";
       shij.text =@"周六9:00-11:00";
       xuek.text =@"数学";
       niaj.text =@"初中一年级";
        
        [cell addSubview:banj];
        [cell addSubview:laos];
        [cell addSubview:shij];
        [cell addSubview:xuek];
        [cell addSubview:niaj];
        
    }
    else{
        if(indexPath.row==0){
            UIView *imgv= [[UIView alloc]initWithFrame:CGRectMake(10,10, 5, 20)];
            imgv.backgroundColor =[UIColor orangeColor];
            UILabel *jjj =[[UILabel alloc]initWithFrame:CGRectMake(25,10, 200, 20)];
            jjj.font =[UIFont systemFontOfSize:15];
            jjj.text =@"课程简介";
            [cell addSubview:imgv];
            [cell addSubview:jjj];
        }
        else if (indexPath.row==1){
        
        messa.numberOfLines =0;
        messa.font =[UIFont fontWithName:@"Arial" size:15];
        
        [cell addSubview:messa];
        }
        else if (indexPath.row==2){
         UIView *leftview= [[UIView alloc]initWithFrame:CGRectMake(30,30, 120,40)];
         UIView *rightview= [[UIView alloc]initWithFrame:CGRectMake(width/2+30,30,120,40)];
         UILabel *left1 =[[UILabel alloc]initWithFrame:CGRectMake(15,10,70, 20)];
         UILabel *left2 =[[UILabel alloc]initWithFrame:CGRectMake(80,10,30, 20)];
         UILabel *righ1 =[[UILabel alloc]initWithFrame:CGRectMake(15,10,70, 20)];
         UILabel *righ2 =[[UILabel alloc]initWithFrame:CGRectMake(80,10,30, 20)];
           left1.text =@"当前课次";
           righ1.text =@"剩余课次";
           left2.text =@"20";
           righ2.text =@"20";
            left1.font =[UIFont systemFontOfSize:14];
            righ1.font =[UIFont systemFontOfSize:14];
            left2.font =[UIFont systemFontOfSize:15];
            righ2.font =[UIFont systemFontOfSize:15];
            left2.textColor =[UIColor orangeColor];
            righ2.textColor =[UIColor orangeColor];
            leftview.layer.borderWidth =1;
            rightview.layer.borderWidth =1;
            [leftview addSubview:left1];
            [leftview addSubview:left2];
            [rightview addSubview:righ1];
            [rightview addSubview:righ2];
            [cell addSubview:leftview];
            [cell addSubview:rightview];
            
        }
        else{
            UILabel *ll=[[UILabel alloc]initWithFrame:CGRectMake(20,10, 300, 20)];
            ll.font =[UIFont systemFontOfSize:15];
            ll.textColor =[UIColor orangeColor];
            ll.text =@"本门课程余额不足,请尽快缴费";
            [cell addSubview:ll];
        }
    
    }
    
    
    
  
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
