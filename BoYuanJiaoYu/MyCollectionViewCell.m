//
//  MyCollectionViewCell.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/8.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "MyCollectionViewCell.h"
#define itemHeight 30
@implementation MyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //self.contentView.backgroundColor =[UIColor redColor];
      _blabel =[[UILabel alloc]initWithFrame:CGRectMake(0,0,frame.size.width, 30)];
        //_blabel.backgroundColor =[UIColor blueColor];
        _blabel.font =[UIFont systemFontOfSize:15];
        _blabel.textAlignment =NSTextAlignmentCenter;
        _blabel.adjustsFontSizeToFitWidth =YES;
        _blabel.layer.cornerRadius =5;
        _blabel.layer.borderWidth=1;
        [self.contentView addSubview:_blabel];
    }
    
    return self;
}
#pragma mark — 实现自适应文字宽度的关键步骤:item的layoutAttributes
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    // 如果你cell上的子控件不是用约束来创建的,那么这边必须也要去修改cell上控件的frame才行
    self.blabel.frame = CGRectMake(0, 0, attributes.frame.size.width, 30);
    CGRect frame = [self.blabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.blabel.frame.size.height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.blabel.font,NSFontAttributeName, nil] context:nil];
//
    frame.size.height = itemHeight;
    attributes.frame = frame;
    
   
    
    return attributes;
}



@end
