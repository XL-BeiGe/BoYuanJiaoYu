//
//  ClassCenterViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/15.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "ClassCenterViewController.h"
#import "Color+Hex.h"
#import "ClassInfoViewController.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
#import "HongDingYi.h"
#import "MyCollectionViewCell.h"
@interface ClassCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    float width;
    float heigh;
    NSMutableArray *arr;
    int touchNumber;//点击次数
    UIView *VVV;//筛选
    UICollectionView *mainCollectionView;
    NSString *leave;
    NSString *clastyp;
    NSString *teacheid;
    
    NSMutableArray*leavearr;
    NSMutableArray*typearr;
    NSMutableArray*teacharr;
    
}
@end

@implementation ClassCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    leave =@"0";
    clastyp =@"0";
    teacheid =@"0";
    [self kechengclassleave:leave classtype:clastyp teacherid:teacheid];
    [self shaixuan];
    [self navagat];
    [self collectiondelegate];
    self.title =@"课程中心";
    touchNumber=1;
    _table.hidden=YES;

    // Do any additional setup after loading the view.
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--筛选完成按钮
-(void)animallllll{
    _table.userInteractionEnabled =YES;
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.5];
    //设置代理
    [UIView setAnimationDelegate:self];
    VVV.frame=CGRectMake(width,0,width-80,heigh);
    [UIView commitAnimations];
    touchNumber=1;
    [self kechengclassleave:leave classtype:clastyp teacherid:teacheid];
    [mainCollectionView reloadData];
    leave =@"0";
    clastyp =@"0";
    teacheid =@"0";
    
}

#pragma mark---筛选按钮+方法
-(void)navagat{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(animals)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)animals{
    
    if(touchNumber==1){
        [mainCollectionView reloadData];
        [UIView beginAnimations:nil context:nil];
        //执行动画
        //设置动画执行时间
        [UIView setAnimationDuration:0.5];
        //设置代理
        [UIView setAnimationDelegate:self];
        //设置动画执行完毕调用的事件
        //[UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
        VVV.frame=CGRectMake(80, 0,width-80, heigh);
        [UIView commitAnimations];
        touchNumber=0;
        _table.userInteractionEnabled =NO;
    }else{
         [mainCollectionView reloadData];
        [UIView beginAnimations:nil context:nil];
        //执行动画
        //设置动画执行时间
        [UIView setAnimationDuration:0.5];
        //设置代理
        [UIView setAnimationDelegate:self];
        //设置动画执行完毕调用的事件
        //[UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
        VVV.frame=CGRectMake(width,0,width-80,heigh);
        [UIView commitAnimations];
        touchNumber=1;
        _table.userInteractionEnabled =YES;
    }
    
    
    
}


#pragma mark--接口
-(void)kechengclassleave:(NSString*)classle classtype:(NSString*)type teacherid:(NSString*)teachid{
    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/curriculumCenter/classInfoList";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",classle,@"classLevel",type,@"classType",teachid,@"teacherId",[def objectForKey:@"officeId"],@"officeId", nil];

    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"课程中心成功\n%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            arr = [NSMutableArray array];
            arr=[[responseObject objectForKey:@"data"] objectForKey:@"classInfoList"];
           
            if(arr.count==0){
                _BackImg.hidden=NO;
                _table.hidden=YES;
                
            }else{
                _BackImg.hidden=YES;
                _table.hidden=NO;
                [_table reloadData];
            }
            
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接错误" andView:self.view];
        NSLog(@"失败\n %@",error);
    }];
    


}
//筛选接口
-(void)shaixuan{
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/curriculumCenter/classConditionList";
   NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"officeId"],@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"筛选成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            leavearr =[NSMutableArray array];
            typearr =[NSMutableArray array];
            teacharr =[NSMutableArray array];
           leavearr = [[responseObject objectForKey:@"data"] objectForKey:@"classLevelList"];
           typearr = [[responseObject objectForKey:@"data"] objectForKey:@"classTypeList"];
           teacharr = [[responseObject objectForKey:@"data"] objectForKey:@"teacherList"];
            [mainCollectionView reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];
    

}



#pragma mark--tableviewDataSource代理
-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor =[UIColor clearColor];
    //self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    width =[UIScreen mainScreen].bounds.size.width;
    heigh =[UIScreen mainScreen].bounds.size.height;
    _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
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
    
    UIImageView*imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,width, 155)];
    UIImageView*lsimg=[[UIImageView alloc] initWithFrame:CGRectMake(width/2-100,70,20, 20)];
    UIImageView*njimg=[[UIImageView alloc] initWithFrame:CGRectMake(width/2+20,70,20, 20)];
    UIImageView*bmimg=[[UIImageView alloc] initWithFrame:CGRectMake(width/2-100,110,20, 20)];
    UIImageView*xqimg=[[UIImageView alloc] initWithFrame:CGRectMake(width/2+20,110,20, 20)];
    UILabel *banji = [[UILabel alloc]initWithFrame:CGRectMake(30,30, 130, 20)];
    UILabel *jiaos = [[UILabel alloc]initWithFrame:CGRectMake(width/2-75,70,100, 20)];
    UILabel *nianj = [[UILabel alloc]initWithFrame:CGRectMake(width/2+45,70,100, 20)];
    UILabel *baomi = [[UILabel alloc]initWithFrame:CGRectMake(width/2-75,110,100, 20)];
    UILabel *xiang = [[UILabel alloc]initWithFrame:CGRectMake(width/2+45,110,100, 20)];
    
    UIButton *kemu =[[UIButton alloc]initWithFrame:CGRectMake(width-90,30,70, 20)];
   
    [kemu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    kemu.layer.cornerRadius =5;
   // kemu.textAlignment =NSTextAlignmentCenter;
     imageview.image =[UIImage imageNamed:@"课程-背景.png"];
    nianj.font =[UIFont systemFontOfSize:15];
    kemu.titleLabel.font =[UIFont systemFontOfSize:15];
    jiaos.font =[UIFont systemFontOfSize:15];
    banji.font =[UIFont systemFontOfSize:15];
    baomi.font =[UIFont systemFontOfSize:15];
    xiang.font =[UIFont systemFontOfSize:15];
   
    
    //kemu.text =@"政治教育";
   // banji.text =@"初一数学A2班";
   //jiaos.text =@"张老师";
   // nianj.text =@"初中一年级";
   // baomi.text =@"已报名";
   // xiang.text =@"查看详情";
    if(nil==[arr[indexPath.row]objectForKey:@"className"]){
        
        banji.text =@"";
    }else{
        banji.text =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"className"]];
        banji.adjustsFontSizeToFitWidth =YES;
    }
    
    if(nil==[arr[indexPath.row]objectForKey:@"classType"]){
        kemu.titleLabel.text =@"";
    }else{
        //kemu.titleLabel.text =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"classType"]];
        [kemu setTitle:[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"classType"]] forState:UIControlStateNormal];
        kemu.titleLabel.adjustsFontSizeToFitWidth=YES;
    }
    
    
    if(nil==[arr[indexPath.row]objectForKey:@"teacherName"]){
       
        jiaos.text =@"";
    }else{
        NSString *dss =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"teacherName"]];
        dss =[dss substringToIndex:1];
        
        jiaos.text =[NSString stringWithFormat:@"%@老师",dss];
        
    }
    
    if(nil==[arr[indexPath.row]objectForKey:@"classLevel"]){
        

        nianj.text =@"";
    }else{
        nianj.text =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"classLevel"]];
        
    }
 
    
//    if(nil==[arr[indexPath.row]objectForKey:@"isEnrol"]){
//        
//        baomi.text =@"";
//    }else{
        if([[arr[indexPath.row]objectForKey:@"isEnrol"]intValue]==0){
            kemu.backgroundColor =[UIColor colorWithHexString:@"fc619d"];
           
            lsimg.image =[UIImage imageNamed:@"课程-老师2.png"];
            njimg.image =[UIImage imageNamed:@"课程-年级2.png"];
            bmimg.image =[UIImage imageNamed:@"课程-已报名2.png"];
            xqimg.image =[UIImage imageNamed:@"课程-查看详情2.png"];
            baomi.text=@"未报名";
        }else{
            kemu.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
          
            lsimg.image =[UIImage imageNamed:@"课程-老师.png"];
            njimg.image =[UIImage imageNamed:@"课程-年级.png"];
            bmimg.image =[UIImage imageNamed:@"课程-已报名.png"];
            xqimg.image =[UIImage imageNamed:@"课程-查看详情.png"];
            baomi.text=@"已报名";
        }
   // }
    xiang.text =@"查看详情";
 
    [cell addSubview:imageview];
    [cell addSubview:lsimg];
    [cell addSubview:njimg];
    [cell addSubview:bmimg];
    [cell addSubview:xqimg];
    
    [cell addSubview:kemu];
    [cell addSubview:nianj];
    [cell addSubview:jiaos];
    [cell addSubview:banji];
    [cell addSubview:baomi];
    [cell addSubview:xiang];
    
    //[cell addSubview:backview];
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassInfoViewController *class = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"classinfo"];
    class.claassID =[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"classId"]];
    [self.navigationController pushViewController:class animated:YES];

}
#pragma mark--collectionview DataSourec代理
-(void)collectiondelegate{
    
    VVV =[[UIView alloc]initWithFrame:CGRectMake(width,0,width-80,heigh-49)];
    VVV.backgroundColor =[UIColor colorWithHexString:@"EFEFEF"];
    [self.view addSubview:VVV];
    
    UIButton *bth =[[UIButton alloc]initWithFrame:CGRectMake(20,VVV.frame.size.height-40,VVV.frame.size.width-40, 30)];
    [bth setTitle:@"完成" forState:UIControlStateNormal];
    [bth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bth.backgroundColor =[UIColor yellowColor];
    
    [bth  addTarget:self action:@selector(animallllll) forControlEvents:UIControlEventTouchUpInside];
    [VVV addSubview:bth];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
    //该方法也可以设置itemSize
   // layout.itemSize =CGSizeMake(110, 150);
    // layout约束这边必须要用estimatedItemSize才能实现自适应,使用itemSzie无效
    layout.estimatedItemSize = CGSizeMake(80, 30);
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10,64,width-100, VVV.frame.size.height-113) collectionViewLayout:layout];
    
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    
    [mainCollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    
    //4.设置代理
    
      //  mainCollectionView.allowsSelection = YES;
    mainCollectionView.allowsMultipleSelection = YES;
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    mainCollectionView.bounces = NO;

    [VVV addSubview:mainCollectionView];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section  {
    if(section==0){
        return leavearr.count;
    }else if (section==1){
        return typearr.count;
    }else {
        return teacharr.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    
     MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    //MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
 
    if(indexPath.section==0){
        
        if(nil==[leavearr[indexPath.row] objectForKey:@"classLevel"]){
        cell.blabel.text =@"";
        }else{
      cell.blabel.text =[NSString stringWithFormat:@"%@",[leavearr[indexPath.row] objectForKey:@"classLevel"]];
        }
        cell.tag=indexPath.row+100;
    }else if (indexPath.section==1){
        if(nil==[typearr[indexPath.row] objectForKey:@"classType"]){
            cell.blabel.text =@"";
        }else{
      cell.blabel.text =[NSString stringWithFormat:@"%@",[typearr[indexPath.row] objectForKey:@"classType"]];
        }
         cell.tag=indexPath.row+200;
    }else{
        
        if(nil==[teacharr[indexPath.row] objectForKey:@"teacherName"]){
            cell.blabel.text =@"";
        }else{
            NSString *dss =[NSString stringWithFormat:@"%@",[teacharr[indexPath.row] objectForKey:@"teacherName"]];
            dss =[dss substringToIndex:1];
            cell.blabel.text=[NSString stringWithFormat:@"%@老师",dss];
        
        }
       cell.tag=indexPath.row+300;
    }
    
    // cell.backgroundColor = [UIColor yellowColor];
    cell.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
    
    
    cell.layer.cornerRadius =5;
    return cell;
    
    
}

//按照这个尺寸设置宽和高
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath  {
//    
//    CGSize cc = CGSizeMake(80, 30);
//    
//    return cc;
//}
//cell间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
//行与行间最小距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//手动设置边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section  {
    // 顺序上左下右
    return UIEdgeInsetsMake(10,5,20,5);
    
}
////标题
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
   // headerView.backgroundColor =[UIColor grayColor];
    
    for (UIView *vv in headerView.subviews) {
        [vv removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
   
    if(indexPath.section==0){
    label.text = @"年级";
    }else if (indexPath.section==1){
    label.text = @"科目";
    }else if (indexPath.section==2){
    label.text = @"授课教师";
    }
    
    
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment =NSTextAlignmentCenter;
    [headerView addSubview:label];
    return headerView;
}


//didselect方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    //UICollectionViewCell *cell =  [mainCollectionView cellForItemAtIndexPath:indexPath];
    
   // cell.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
//    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    NSString *msg = cell.blabel.text;
//    NSLog(@"%@",msg);
//    NSLog(@"-----%ld----%ld",(long)indexPath.section,(long)indexPath.row);
    if(indexPath.section==0){
        for(UICollectionViewCell *celll in mainCollectionView.visibleCells){
            
            if(celll.tag==100+indexPath.row){
         
            celll.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
            }else{
                if(celll.tag>99&&celll.tag<200){
              
                celll.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
                }
            }
        }
        
       //  cell.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
      leave =[NSString stringWithFormat:@"%@",[leavearr[indexPath.row] objectForKey:@"classLevelId"]];
    }
    else if(indexPath.section==1){
        for(UICollectionViewCell *celll in mainCollectionView.visibleCells){
            
            if(celll.tag==200+indexPath.row){
           
                celll.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
            }else{
                if(celll.tag>199&&celll.tag<300){
                 
                    celll.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
                }
            }
        }
     clastyp =[NSString stringWithFormat:@"%@",[typearr[indexPath.row] objectForKey:@"classTypeId"]];
    }
    else if (indexPath.section==2){
        for(UICollectionViewCell *celll in mainCollectionView.visibleCells){
            
            if(celll.tag==300+indexPath.row){
              
                celll.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
            }else{
                if(celll.tag>299&&celll.tag<400){
                 
                    celll.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
                }
            }
        }
   teacheid =[NSString stringWithFormat:@"%@",[teacharr[indexPath.row] objectForKey:@"teacherId"]];
    }
  
   
    
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

    //UICollectionViewCell *cell =  [mainCollectionView cellForItemAtIndexPath:indexPath];
    
    // cell.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
    //    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *msg = cell.blabel.text;
    //    NSLog(@"%@",msg);
    //    NSLog(@"-----%ld----%ld",(long)indexPath.section,(long)indexPath.row);
    if(indexPath.section==0){
        for(UICollectionViewCell *celll in mainCollectionView.visibleCells){
            
            if(celll.tag==100+indexPath.row){
                
                celll.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
            }else{
                if(celll.tag>99&&celll.tag<200){
                
                    celll.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
                }
            }
        }
        leave =[NSString stringWithFormat:@"%@",[leavearr[indexPath.row] objectForKey:@"classLevelId"]];
    }
    else if(indexPath.section==1){
        for(UICollectionViewCell *celll in mainCollectionView.visibleCells){
            
            if(celll.tag==200+indexPath.row){
                
                celll.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
            }else{
                if(celll.tag>199&&celll.tag<300){
                    
                    celll.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
                }
            }
        }
        clastyp =[NSString stringWithFormat:@"%@",[typearr[indexPath.row] objectForKey:@"classTypeId"]];
    }
    else if (indexPath.section==2){
        for(UICollectionViewCell *celll in mainCollectionView.visibleCells){
            
            if(celll.tag==300+indexPath.row){
                
                celll.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
            }else{
                if(celll.tag>299&&celll.tag<400){
                    
                    celll.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
                }
            }
        }
        teacheid =[NSString stringWithFormat:@"%@",[teacharr[indexPath.row] objectForKey:@"teacherId"]];
    }
    
    
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
