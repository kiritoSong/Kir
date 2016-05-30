//
//  FilterViewController.h
//  YiBaiSong
//
//  Created by kirito_song on 16/5/11.
//  Copyright © 2016年 yibaisong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BSFilterModel.h"
//@class BSFilterModel;

@protocol FilterDelegate <NSObject>
/**
 *  高级筛选确定回调给上级搜索
 *
 *  @param model 搜索参数model
 */
- (void)filterWithModel:(BSFilterModel *)model;

@end

@interface FilterViewController : UIViewController

@property (weak , nonatomic) id<FilterDelegate> delegate;
/* 入口参数model、如需保留上级结果则需要传入参数model */
@property (strong , nonatomic) BSFilterModel *filterModel;

@end
