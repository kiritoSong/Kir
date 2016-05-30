//
//  BSFilterModel.m
//  YiBaiSong
//
//  Created by kirito_song on 16/5/11.
//  Copyright © 2016年 yibaisong. All rights reserved.
//

#import "BSFilterModel.h"

@implementation BSFilterModel

-(instancetype)init {
    self = [super init];
    if (self) {
        self.entryType    = 0;
        self.expressType  = 0;
        self.priceMin     = @"";
        self.priceMax     = @"";
        self.keyWord      = @"0";
        self.sendModeType = 1;

    }
    return self;
}

-(void)configureModelWithSegment:(UISegmentedControl *)sender {
    if (sender.tag == 100) {
        if (sender.selectedSegmentIndex == 1) {
            //随机
            self.sendModeType = 0;
        }else if(sender.selectedSegmentIndex == 2){
            //自主
            self.sendModeType = 0;
        }else if(sender.selectedSegmentIndex == 3){
            //竞拍
            self.sendModeType = 0;
        }else{
            //不限  没有修改枚举。整个项目只有这一个地方用得到
            self.sendModeType = 1;
        }
    }
    if (sender.tag == 200) {
        if (sender.selectedSegmentIndex == 1) {
            //官方
            self.entryType = 10;
        }else if(sender.selectedSegmentIndex == 2){
            //商家
            self.entryType = 11;
            
        }else if(sender.selectedSegmentIndex == 3){
            //个人
            self.entryType = 9;
            
        }else{
            //不限
            self.entryType = 0;
        }
    }
    
    if (sender.tag == 300) {
        if (sender.selectedSegmentIndex == 1) {
            //包邮
            self.expressType = 0;
        }else if(sender.selectedSegmentIndex == 2){
            //不包邮
            self.expressType = 0;
        }else{
            //不限
            self.expressType = 0;
        }
        
    }


}


@end
