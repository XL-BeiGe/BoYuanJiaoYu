//
//  RecordInfoViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/13.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSString *questionId;
@end
