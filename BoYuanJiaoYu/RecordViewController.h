//
//  RecordViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/17.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)Segments:(UISegmentedControl *)sender;


@end
