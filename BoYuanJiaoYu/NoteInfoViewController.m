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
    UILabel *titt;
    NSDictionary*arr;
}
@end

@implementation NoteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    [self wangluo];
    [self comeback];
    self.title =@"通知详情";
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)wangluo{
    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
    //通知的状态还不知道有几个
    NSString *fangshi =@"/userInfo/pushInfo";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_pushId,@"pushId",@"1",@"state", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
          
            arr =[responseObject objectForKey:@"data"];
            [_table reloadData];
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
        [WarningBox warningBoxModeText:@"网络连接错误" andView:self.view];
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
    return 4;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 40;
    }else if (indexPath.row==1){
        NSString* s=[[NSString alloc] init];
        if(nil==[arr objectForKey:@"title"]){
            s =@"";
        }else{
            s =[NSString stringWithFormat:@"%@",[arr objectForKey:@"title"]];
        }
        titt=[[UILabel alloc] init];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        titt.textAlignment =NSTextAlignmentCenter;
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]initWithString:s attributes:@{NSFontAttributeName: font}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-40, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        
        
        titt.text=s;
        [titt setFrame:CGRectMake(20,10,width-40, rect.size.height)];
        return titt.frame.size.height+15>40? titt.frame.size.height+15:40;

    }
    else if (indexPath.row==2){
            NSString* ss=[[NSString alloc] init];
            if(nil==[arr objectForKey:@"context"]){
                ss =@"";
            }else{
                ss =[NSString stringWithFormat:@"%@",[arr objectForKey:@"context"]];
            }
        
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
   
    if(indexPath.section==0){
        if(indexPath.row==0){
            UIView *sdid = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 30)];
            sdid.backgroundColor = [UIColor colorWithHexString:@"EFEFEF"];
            UIImageView *images = [[UIImageView alloc]init];
            images.frame = CGRectMake(width/2-20,10,40,40);
            images.image =[UIImage imageNamed:@"通知详情.png"];
            [cell.contentView addSubview:sdid];
            [cell.contentView addSubview:images];
            
        }
        else if (indexPath.row==1){
            titt.numberOfLines=0;
            
            titt.font=[UIFont fontWithName:@"Arial" size:20];
            titt.textColor=[UIColor colorWithHexString:@"323232"];
            [cell.contentView addSubview:titt];
        }
        else if (indexPath.row==2){
            messa.numberOfLines=0;
            messa.font= [UIFont systemFontOfSize:14];
            messa.textColor=[UIColor colorWithHexString:@"323232"];
            [cell.contentView addSubview:messa];
            
        }
        else{
            UILabel *time= [[UILabel alloc]initWithFrame:CGRectMake(width-250, 10,230, 20)];

            time.textColor =[UIColor colorWithHexString:@"fd8f30"];
           
            time.font= [UIFont systemFontOfSize:14];
          
            time.textAlignment = NSTextAlignmentRight;
         
            if(nil==[arr objectForKey:@"pushTime"]){
                time.text =@"";
            }else{
                NSString *ss =[NSString stringWithFormat:@"时间:%@",[arr objectForKey:@"pushTime"]];
                //NSString *sss = [ss substringToIndex:10];
                time.text =ss;
            }
            [cell.contentView addSubview:time];
            
        }
        
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
