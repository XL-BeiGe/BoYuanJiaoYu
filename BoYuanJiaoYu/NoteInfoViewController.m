//
//  NoteInfoViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/24.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "NoteInfoViewController.h"
#import "Color+Hex.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
@interface NoteInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float width;
    float height;
    UILabel *messa;
}
@end

@implementation NoteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    [self wangluo];
    self.title =@"通知详情";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)wangluo{
    //通知的状态还不知道有几个
    NSString *fangshi =@"/userInfo/pushInfo";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_pushId,@"pushId",@"2",@"State", nil];
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
    height =[UIScreen mainScreen].bounds.size.height;
    _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 40;
    }else{
        if (indexPath.row==1){
            NSString* ss=[[NSString alloc] init];
            //            if(nil==[pushTemplate objectForKey:@"title"]){
            //                ss =@"";
            //            }else{
            //                ss =[NSString stringWithFormat:@"%@",[pushTemplate objectForKey:@"context"]];
            //            }
            ss =@"因为iPhone平庸了几代";
            messa=[[UILabel alloc] init];
            UIFont *font = [UIFont fontWithName:@"Arial" size:15];
            NSAttributedString *attributedText =
            [[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-40, CGFLOAT_MAX}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
            
            messa.text=ss;
            [messa setFrame:CGRectMake(20,10, rect.size.width, rect.size.height)];
            
            return messa.frame.size.height+15>40? messa.frame.size.height+55:40;
        }
        else{
            return 40;
        }
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
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
   
        if(indexPath.row==0){
            UIView *imgv= [[UIView alloc]initWithFrame:CGRectMake(10,20, 5, 20)];
            imgv.backgroundColor =[UIColor colorWithHexString:@"FFDB00"];
            UILabel *jjj =[[UILabel alloc]initWithFrame:CGRectMake(20,20, 150, 20)];
            UILabel *jjjj =[[UILabel alloc]initWithFrame:CGRectMake(width-120,20, 100, 20)];
            jjj.font =[UIFont systemFontOfSize:15];
            jjj.text =@"通知标题";
            jjjj.font =[UIFont systemFontOfSize:15];
            jjjj.textAlignment =NSTextAlignmentRight;
            jjjj.text =@"2017.10.4";
            [cell addSubview:imgv];
            [cell addSubview:jjj];
            [cell addSubview:jjjj];
        }
        else if (indexPath.row==1){
            
            messa.numberOfLines =0;
            messa.font =[UIFont fontWithName:@"Arial" size:15];
            
            [cell addSubview:messa];
        }
     
    
    
    
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
