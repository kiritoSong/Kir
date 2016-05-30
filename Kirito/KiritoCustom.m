//
//  KiritoCustom.m
//  YiBaiSong
//
//  Created by Kirito on 16/4/7.
//  Copyright © 2016年 yibaisong. All rights reserved.
//

#import "KiritoCustom.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@implementation KiritoCustom

//简易画线方法
+(void)creatLineForView:(UIView *)view MoveToPoint:(CGPoint )point1 AddlineToPoint:(CGPoint )point2 andAlphaComponent:(CGFloat) n {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    shapeLayer.path=path.CGPath;
    shapeLayer.strokeColor= [[UIColor blackColor] colorWithAlphaComponent:n].CGColor;
    shapeLayer.lineWidth =1;
    [view.layer addSublayer:shapeLayer];
}


+(void)creatLineForView:(UIView *)view MoveToPoint:(CGPoint )point1 AddlineToPoint:(CGPoint )point2 strokeColor:(UIColor *)color andAlphaComponent:(CGFloat) n {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    shapeLayer.path=path.CGPath;
    if (!color) {
        color =[UIColor blackColor];
    }
    shapeLayer.strokeColor= [color colorWithAlphaComponent:n].CGColor;
    shapeLayer.lineWidth =1;
    [view.layer addSublayer:shapeLayer];
}





+(void)AddCornerForView:(UIView *)view {
    CGFloat bounds =view.frame.size.width;
    if (bounds > view.frame.size.height) {
        bounds = view.frame.size.height;
    }
    view.layer.cornerRadius = bounds/2;
    view.clipsToBounds = YES;
}


+(NSString *)creatTimeByStr:(NSString *)timeStr andDataFormat:(NSString *)dataFormat{
    // 返回值一般有毫秒,忽略掉毫秒
    if (dataFormat == nil) {
        dataFormat = @"MM/dd HH:mm";
    }
    timeStr = [timeStr substringToIndex:10];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dataFormat];
    // 转换后的时间字符串
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;

}

//模拟倒计时
+ (void)creatTimefromTimeStr:(NSString *)startTimeStr toTimeStr:(NSString *)endTimeStr forTimeFormat:(TimeFormat ) timeFormat TimeBlock:(Timeblock) block
{
    NSDate*  yendTime  = [[NSDate alloc] init];
    NSDate*  ystartTime  = [[NSDate alloc] init];
    
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar ];
    //传入值为nil、则采用当前系统时间
    if (endTimeStr != nil) {
        NSDate*  Time = [NSDate dateWithTimeIntervalSince1970:[endTimeStr doubleValue]];
        yendTime = Time;
    }
    if (startTimeStr != nil) {
        NSDate*  Time = [NSDate dateWithTimeIntervalSince1970:[startTimeStr doubleValue]];
        ystartTime = Time;
    }
    
    NSUInteger unitFlags =
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:ystartTime  toDate:yendTime  options:0];
    NSInteger diffDay = [cps day];
    NSInteger diffHour = [cps hour];
    NSInteger diffMin   = [cps minute];
    NSInteger diffSec   = [cps second];
    NSString *day = [NSString stringWithFormat:@"%ld",(long)diffDay];
    NSString *hour = [NSString stringWithFormat:@"%ld",(long)diffHour];
    NSString *min = [NSString stringWithFormat:@"%ld",(long)diffMin];
    NSString *second = [NSString stringWithFormat:@"%ld",(long)diffSec];

    
    switch (timeFormat) {
        case TimeFormatByDay:
    
            break;
        case TimeFormatByHour:
            day = @"Null";
            hour = [NSString stringWithFormat:@"%ld",(long)diffHour+diffDay*24];
            min = [NSString stringWithFormat:@"%ld",(long)diffMin];
            second = [NSString stringWithFormat:@"%ld",(long)diffSec];
            break;
        case TimeFormatByMin:
            day = @"Null";
            hour = @"Null";
            min = [NSString stringWithFormat:@"%ld",(long)diffMin+diffDay*24*60+diffHour*60];
            second = [NSString stringWithFormat:@"%ld",(long)diffSec];
            break;
        case TimeFormatBySecond:
            day = @"Null";
            hour = @"Null";
            min = @"Null";
            second = [NSString stringWithFormat:@"%ld",(long)diffSec+diffDay*24*60*60+diffHour*60*60];
            break;
        default:
            break;
            
    }
    //十位用0补齐
    if (day.length == 1) {
        day = [NSString stringWithFormat:@"0%@",day];
    }
    
    if (hour.length == 1) {
        
        hour = [NSString stringWithFormat:@"0%@",hour];
    }
    if (min.length == 1) {
        min = [NSString stringWithFormat:@"0%@",min];
    }
    if (second.length == 1) {
        second = [NSString stringWithFormat:@"0%@",second];
    }
    block(day,hour,min,second);
    
}



+ (void)buttonAnimation:(UIButton*)button{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.duration = 0.2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [button.layer addAnimation:animation forKey:nil];
}

+(BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (object==nil){
        return YES;
    }
    return NO;
}
// 转换空串
+(NSString*)convertNull:(id)object{
    
    // 转换空串
    if ([object isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if (object==nil){
        return @"";
    }
    return object;
}

+ (CGSize)heightOfString:(NSString *)string withFont:(UIFont *)font withWidth:(CGFloat)width
{
    
    CGSize textBlockMinSize = CGSizeMake(width, 10000);
    CGSize size = CGSizeZero;
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1];//调整行间距
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
    size = [string boundingRectWithSize:textBlockMinSize
                                options:options
                             attributes:attributes
                                context:nil].size;
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
    
}


+ (NSUInteger)LengthOfString:(NSString *)text
{
    
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
    
}

+ (UIColor *)colorWithRGBValue:(uint)value
{
    uint r = (value & 0x00FF0000) >> 16;
    uint g = (value & 0x0000FF00) >> 8;
    uint b = (value & 0x000000FF);
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+ (NSMutableAttributedString *)lineSpacingWihtText:(NSString *)string LineSpacing:(int)num{
    
    //
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:num];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    return attributedString;
};

+ (NSString *)stringByTrimming:(NSString *)string{
    
    NSString *cleanString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return cleanString;
    
}

+ (NSString *)stringByCutting:(NSMutableString *)string{
    
    NSLog(@"%@",string);
    if (![string isEqualToString:@""]) {
        NSString *finalString = [string substringToIndex:[string length] - 1];
        return finalString;
        
    }else{
        
        return string;
    }
    
    
}
+ (NSMutableAttributedString *)stringOfLine:(NSString *)string{
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    
    return content;
}

+ (NSMutableAttributedString *)stringOfCorlor:(NSString *)string range:(NSRange)range{
    
    
    NSString *contentStr = string;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    //设置：在0-3个单位长度内的内容显示成红色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    return str;
}

+ (UIView *)createKeyBoardBackViewWithTarget:(nonnull id)target action:(nonnull SEL)action{
    //给键盘添加回收按钮
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 31)];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-60, 0, 60, 31);
    [button setImage:[UIImage imageNamed:@"feedback_keyBack.png"] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    return backView;
}

@end
