//
//  RecordViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/17.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordInfoViewController.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
#import "Color+Hex.h"
#import "HongDingYi.h"
#import "MyCollectionViewCell.h"
@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int touchNumber;//点击次数
    UIView *VVV;//筛选
    UICollectionView *mainCollectionView;
    NSString *leave;
    NSString *clastyp;

    float width;
    float heigh;
    NSMutableArray*leavearr;
    NSMutableArray*typearr;
    NSMutableArray*arr;

}
@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    self.title =@"错题记录";
    //_segment.selectedSegmentIndex = 0;
    [self navagat];
    touchNumber=1;
    
    [self cuotishaixuan];
    [self collectiondelegate];
    [self comeback];
    leave =@"";
    clastyp =@"";
   [self cuotijilu:@"1" leave:leave type:clastyp];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}



//错题筛选
-(void)cuotishaixuan{

    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/errorScreen";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"officeId"],@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"筛选成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            leavearr =[NSMutableArray array];
            typearr =[NSMutableArray array];
            leavearr = [[responseObject objectForKey:@"data"] objectForKey:@"grades"];
            typearr = [[responseObject objectForKey:@"data"] objectForKey:@"classes"];
            [mainCollectionView reloadData];
   
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];
}
//错题记录
-(void)cuotijilu:(NSString*)isCorrect leave:(NSString*)leaves type:(NSString*)clastype{
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/errorList";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",leaves,@"classLevel",clastype,@"classType", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"错题成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            arr =[NSMutableArray array];
           arr =[[responseObject objectForKey:@"data"] objectForKey:@"errorList"];
            if(arr.count==0){
                NSLog(@"没有");
            }else{
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
    _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr.count;
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
   // UILabel *zhang =(UILabel*)[cell viewWithTag:203];
    UILabel *numbe =(UILabel*)[cell viewWithTag:204];
    //UILabel *laiyu =(UILabel*)[cell viewWithTag:205];
    UILabel *fancu =(UILabel*)[cell viewWithTag:206];
    UILabel *fcnum =(UILabel*)[cell viewWithTag:207];
    UILabel *gwron =(UILabel*)[cell viewWithTag:208];
    UILabel *wrnum =(UILabel*)[cell viewWithTag:209];
    
    backview.backgroundColor =[UIColor whiteColor];
    backview.layer.cornerRadius =10;
    leftview.layer.borderWidth =0;
    fengview.layer.borderWidth =0;
    class.layer.cornerRadius =5;
    //题目
    if(nil==[arr[indexPath.section]objectForKey:@"quesionName"]){
    title.text =@"";
    }else{
    title.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"quesionName"]];
    }
    //学科
    if(nil==[arr[indexPath.section]objectForKey:@"xkName"]){
     [class setTitle:@"" forState:UIControlStateNormal];
    }else{
      [class setTitle:[arr[indexPath.section]objectForKey:@"xkName"] forState:UIControlStateNormal];
    }
    //年级
    if(nil==[arr[indexPath.section]objectForKey:@"className"]){
     groud.text =@"";
    }else{
      groud.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"className"]];
    }
//    if(nil==[arr[indexPath.section]objectForKey:@""]){
//       zhang.text=@"第三册第五章";
//    }else{
//       zhang.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@""]];
//    }
    //试题编号
    if(nil==[arr[indexPath.section]objectForKey:@"quesionId"]){
        numbe.text =@"试题编号:";
    }else{
      numbe.text=[NSString stringWithFormat:@"试题编号:%@",[arr[indexPath.section]objectForKey:@"quesionId"]];
    }
    
  
    fancu.text =@"犯错次数:";
    gwron.text =@"个人犯错:";
    //犯错总次数
    if(nil==[arr[indexPath.section]objectForKey:@"errorCount"]){
       fcnum.text =@"";
    }else{
       fcnum.text=[NSString stringWithFormat:@"%@次",[arr[indexPath.section]objectForKey:@"errorCount"]];
    }
    //个人犯错
    if(nil==[arr[indexPath.section]objectForKey:@"errorSelfCount"]){
        wrnum.text =@""; 
    }else{
      wrnum.text=[NSString stringWithFormat:@"%@次",[arr[indexPath.section]objectForKey:@"errorSelfCount"]];
    }
    
    
   
    
   
    
    
   
    
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordInfoViewController *rec = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"recordinfo"];
    rec.questionId =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"quesionId"]];
    [self.navigationController pushViewController:rec animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)Segments:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex==0){
        [self cuotijilu:@"1" leave:leave type:clastyp];
    }else{
     [self cuotijilu:@"2" leave:leave type:clastyp];
    }
    
}
#pragma mark-----筛选
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
    
    [self cuotijilu:@"1" leave:leave type:clastyp];
//    leave =@"";
//    clastyp =@"";
  
    
}

#pragma mark---筛选按钮+方法
-(void)navagat{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(animals)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)animals{
    
    if(touchNumber==1){
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

#pragma mark--collectionview DataSourec代理
-(void)collectiondelegate{
    width =[UIScreen mainScreen].bounds.size.width;
    heigh =[UIScreen mainScreen].bounds.size.height;
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
    layout.itemSize =CGSizeMake(110, 150);
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10,64,width-100, VVV.frame.size.height-113) collectionViewLayout:layout];
    
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    
    [mainCollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    
    //4.设置代理
    
    //    mainCollectionView.allowsSelection = YES;
    mainCollectionView.allowsMultipleSelection = YES;//允许多选
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    mainCollectionView.bounces = NO;
    
    [VVV addSubview:mainCollectionView];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section  {
    if(section==0){
        return leavearr.count;
    }else{
        return typearr.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    
    if(indexPath.section==0){
        if(nil==[leavearr[indexPath.row] objectForKey:@"name"]){
            cell.blabel.text =@"";
        }else{
            cell.blabel.text =[NSString stringWithFormat:@"%@",[leavearr[indexPath.row] objectForKey:@"name"]];
        }
    }else {
        if(nil==[typearr[indexPath.row] objectForKey:@"name"]){
            cell.blabel.text =@"";
        }else{
            cell.blabel.text =[NSString stringWithFormat:@"%@",[typearr[indexPath.row] objectForKey:@"name"]];
        }
    }
    
    // cell.backgroundColor = [UIColor yellowColor];
    
    
    
    cell.layer.cornerRadius =5;
    return cell;
    
    
}

//按照这个尺寸设置宽和高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    CGSize cc = CGSizeMake(70, 30);
    
    return cc;
}
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
    return UIEdgeInsetsMake(10,10,20,10);
    
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
    }else {
        label.text = @"科目";
    }
    
    
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment =NSTextAlignmentCenter;
    [headerView addSubview:label];
    return headerView;
}

//didselect方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell =  [mainCollectionView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
    //    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *msg = cell.blabel.text;
    //    NSLog(@"%@",msg);
    //    NSLog(@"-----%ld----%ld",(long)indexPath.section,(long)indexPath.row);
    if(indexPath.section==0){
        leave =[NSString stringWithFormat:@"%@",[leavearr[indexPath.row] objectForKey:@"id"]];
    }else{
        clastyp =[NSString stringWithFormat:@"%@",[typearr[indexPath.row] objectForKey:@"id"]];
    }
    
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell =  [mainCollectionView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    
}


@end
