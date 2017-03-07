//
//  ClassInfoViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/15.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "ClassInfoViewController.h"
#import "Color+Hex.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
@interface ClassInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float width;
    UILabel*messa;
    NSMutableDictionary *arr;
}
@end

@implementation ClassInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    [self kechengxiangqing];
    self.title =@"课程详情";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)kechengxiangqing{
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/curriculumCenter/classInfo";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",_claassID,@"classId", nil];
    
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            arr = [NSMutableDictionary dictionary];
            arr=[responseObject objectForKey:@"data"];
            
            if(arr.count==0){
                
                _table.hidden=YES;
                
            }else{
             
                _table.hidden=NO;
                [_table reloadData];
            }
   
            
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
        return 90;
    }else{
        if(indexPath.row==2){
            return 80;
        }
       if (indexPath.row==1){
            NSString* ss=[[NSString alloc] init];
            if(nil==[arr objectForKey:@"info"]){
                ss =@"";
            }else{
                ss =[NSString stringWithFormat:@"%@",[arr objectForKey:@"info"]];
            }
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
       UILabel *banj =[[UILabel alloc]initWithFrame:CGRectMake(20,10,130, 20)];
       UIButton *xuek =[[UIButton alloc]initWithFrame:CGRectMake(width-90,10,70, 20)];
       UILabel *laos =[[UILabel alloc]initWithFrame:CGRectMake(20,40,100, 20)];
       UILabel *niaj =[[UILabel alloc]initWithFrame:CGRectMake(width-100,40,80, 20)];
       UILabel *shij =[[UILabel alloc]initWithFrame:CGRectMake(20,65,150, 20)];
      
       xuek.titleLabel.textAlignment =NSTextAlignmentCenter;
       niaj.textAlignment =NSTextAlignmentRight;
       banj.font =[UIFont systemFontOfSize:15];
       laos.font =[UIFont systemFontOfSize:15];
       shij.font =[UIFont systemFontOfSize:15];
       xuek.titleLabel.font =[UIFont systemFontOfSize:15];
       niaj.font =[UIFont systemFontOfSize:15];
        
       //banj.text =@"初一数学A2班";
       //laos.text =@"张老师";
       //shij.text =@"周六9:00-11:00";
       // niaj.text =@"初中一年级";
        
        if(nil==[arr objectForKey:@"className"]){
            banj.text =@"";
        }else{
            banj.text =[NSString stringWithFormat:@"%@",[arr objectForKey:@"className"]];
        }
       
        
        if(nil==[arr objectForKey:@"teacherName"]){
            laos.text =@"";
        }else{
            NSString *dss =[NSString stringWithFormat:@"%@",[arr objectForKey:@"teacherName"]];
            dss =[dss substringToIndex:1];
            
            laos.text =[NSString stringWithFormat:@"%@老师",dss];
        }
        
        if(nil==[arr objectForKey:@"classLevel"]){
                niaj.text =@"";
        }else{
                niaj.text =[NSString stringWithFormat:@"%@",[arr  objectForKey:@"classLevel"]];
        }
        
        
        NSString *xueke;
        if(nil==[arr objectForKey:@"classType"]){
            xueke =@"";
        }else{
            xueke =[NSString stringWithFormat:@"%@",[arr objectForKey:@"classType"]];
        }
        [xuek setTitle:xueke forState:UIControlStateNormal];
        [xuek setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        xuek.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
        xuek.layer.cornerRadius =3;
        
        
        [cell addSubview:banj];
        [cell addSubview:laos];
        [cell addSubview:shij];
        [cell addSubview:xuek];
        [cell addSubview:niaj];
        
    }
    else{
        if(indexPath.row==0){
            UIView *imgv= [[UIView alloc]initWithFrame:CGRectMake(10,10, 5, 20)];
            imgv.backgroundColor =[UIColor colorWithHexString:@"FFDB00"];
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
            if(nil==[arr objectForKey:@"periodsCurrent"]){
                left2.text =@"";
            }else{
                left2.text =[NSString stringWithFormat:@"%@",[arr objectForKey:@"periodsCurrent"]];
            }
            if(nil==[arr objectForKey:@"periodsSurplus"]){
                righ2.text =@"";
            }else{
                righ2.text =[NSString stringWithFormat:@"%@",[arr objectForKey:@"periodsSurplus"]];
            }
            
           
            
            left1.font =[UIFont systemFontOfSize:14];
            righ1.font =[UIFont systemFontOfSize:14];
            left2.font =[UIFont systemFontOfSize:15];
            righ2.font =[UIFont systemFontOfSize:15];
            left2.textColor =[UIColor orangeColor];
            righ2.textColor =[UIColor orangeColor];
            leftview.layer.borderWidth =1;
            rightview.layer.borderWidth =1;
            leftview.layer.cornerRadius =20;
            rightview.layer.cornerRadius =20;
            leftview.layer.borderColor =[[UIColor colorWithHexString:@"EFEFEF"]CGColor];
            rightview.layer.borderColor =[[UIColor colorWithHexString:@"EFEFEF"]CGColor];
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
            //[cell addSubview:ll];
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
