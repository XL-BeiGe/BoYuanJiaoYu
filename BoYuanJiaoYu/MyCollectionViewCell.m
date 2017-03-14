//
//  MyCollectionViewCell.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/8.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _blabel =[[UILabel alloc]initWithFrame:CGRectMake(0,0,70, 30)];
        
        _blabel.font =[UIFont systemFontOfSize:15];
        _blabel.textAlignment =NSTextAlignmentCenter; 
        _blabel.layer.cornerRadius =5;
        _blabel.layer.borderWidth=1;
        [self.contentView addSubview:_blabel];
    }
    
    return self;
}
@end
