//
//  KiritoCustom.h
//  YiBaiSong
//
//  Created by Kirito on 16/4/7.
//  Copyright © 2016年 yibaisong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//适配
#define iphone6p 414.0f
#define iphone4s 320.0f
#define iphone5s 320.0f

//缩放比例(以iphone6p为参考)
#define SCREEN_SCALE (SCREEN_WIDTH / iphone5s)


typedef void(^Timeblock)(NSString * day,NSString * hour,NSString * min,NSString * second);

typedef enum{
//    TimeFormatByDefault,
    TimeFormatByDay,  //返回最大值为日
    TimeFormatByHour,  //返回最大值为小时
    TimeFormatByMin,  //返回最大值为分钟
    TimeFormatBySecond  //返回最大值为秒
}TimeFormat;
@interface KiritoCustom : NSObject


/**
 *  简易画线方法1
 *
 *  @param view   画布view
 *  @param point1 起始点
 *  @param point2 终点
 *  @param n      透明度 
 */
+(void)creatLineForView:(UIView *)view MoveToPoint:(CGPoint )point1 AddlineToPoint:(CGPoint )point2 andAlphaComponent:(CGFloat) n ;

/**
 *  简易画线方法2
 *
 *  @param view   画布view
 *  @param point1 起始点
 *  @param point2 终点
 *  @param n      透明度
 *  @strokeColor  底色
 */
+(void)creatLineForView:(UIView *)view MoveToPoint:(CGPoint )point1 AddlineToPoint:(CGPoint )point2 strokeColor:(UIColor *)color andAlphaComponent:(CGFloat) n;


/**
 *  圆形切割
 *
 *  @param view 切割view
 */
+(void)AddCornerForView:(UIView *)view ;



/**
 *  单一时间戳转化时间
 *
 *  @param timeStr    时间戳
 *  @param dataFormat 转化格式  默认 @"MM/dd HH:mm"
 *
 *  @return 时间
 */
+(NSString *)creatTimeByStr:(NSString *)timeStr andDataFormat:(NSString *)dataFormat;


/**
 *  时间距离计算
 *
 *  @param startTimeStr 开始时间戳
 *  @param endTimeStr   结束时间戳
 *  startTimeStr&&endTimeStr传入nil、则填补为当前系统时间
 *  @param timeFormat 返回值模式、详见枚举
 *  @param Timeblock  返回值为day、hour、min、second均为NSString类型。需自定义处理
 */
+ (void)creatTimefromTimeStr:(NSString *)startTimeStr toTimeStr:(NSString *)endTimeStr forTimeFormat:(TimeFormat )timeFormat TimeBlock:(Timeblock) block;

/**
 *  view先缩小，然后放大动画（收藏和点赞）
 *
 *  @param  如果无法在NSObject里写UIButton，缺少<UIKit/>库
 *
 */
+ (void)buttonAnimation:(UIButton*)button;

/**
 * param:判断一个字符串是否为null或者nil
 */

+(BOOL)isNull:(id)object;


/**
 * param:将null和nil转化为@""
 */
+(NSString*)convertNull:(id)object;

/**
 * 计算字符串的高度
 */
+ (CGSize)heightOfString:(NSString *)string withFont:(UIFont *)font withWidth:(CGFloat)width;


/**
 * 计算一个字符串相当于多少个字   2个字符==1个字
 */
+ (NSUInteger)LengthOfString:(NSString *)text;


/**
 *  设置字体间的行间距
 */

+ (NSMutableAttributedString *)lineSpacingWihtText:(NSString *)String LineSpacing:(int)num;



/**
 *  去除字符串前后的空格，判断输入的内容不是空格
 *
 *  @param string 传入需要设置的字符串
 *
 *  @return 去除空格后的字符串
 */
+ (NSString *)stringByTrimming:(NSString *)string;


/**
 *  切割  业务线/完成/ ---> 业务线/完成
 *
 */
+ (NSString *)stringByCutting:(NSString *)string;

/**
 *  字符串加下划线
 *
 */
+ (NSMutableAttributedString *)stringOfLine:(NSString *)string;

/**
 *  字符串改颜色
 *
 */
+ (NSMutableAttributedString *)stringOfCorlor:(NSString *)string range:(NSRange)range;
/**
 *  键盘添加回收按钮
 *
 *  @param target   响应
 *  @param action   方法
 *
 *  @return 按钮View
 */
+ (UIView *)createKeyBoardBackViewWithTarget:(id)target action:(SEL)action;

@end
