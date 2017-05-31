//
//  FeedHistoryViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/5/25.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedHistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIImageView *backimg;


@property (strong, nonatomic) NSString *classID;
@end
