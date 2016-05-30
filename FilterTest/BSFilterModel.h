//
//  BSFilterModel.h
//  YiBaiSong
//
//  Created by kirito_song on 16/5/11.
//  Copyright © 2016年 yibaisong. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BSFilterModel : NSObject

/* 入口 */
@property (assign , nonatomic) int entryType;
/* 配送方式 */
@property (assign , nonatomic) int expressType;
/* 最大值 */
@property (strong , nonatomic) NSString *priceMin;
/* 最小值 */
@property (strong , nonatomic) NSString *priceMax;
/* 关键字 */
@property (strong , nonatomic) NSString *keyWord;
/* 模式 */
@property (assign , nonatomic) int  sendModeType;
/**
 *  初始化
 *
 *  @return 带有初始值对象
 */
-(instancetype)init ;
/**
 *  根据控件tag进行参数分配
 *
 *  @param sender  SegmentedControl
 */
-(void)configureModelWithSegment:(UISegmentedControl *)sender;

@end
