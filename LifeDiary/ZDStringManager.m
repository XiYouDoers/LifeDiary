
//
//  ZDStringManager.m
//  LifeDiary
//
//  Created by Jack on 2018/9/8.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDStringManager.h"

@implementation ZDStringManager
/**
 字符串转换成只含数字的字符串
 

 */
+ (NSString *)switchToNumberString:(NSString *)sourceString{
    NSMutableArray *characters = [NSMutableArray array];
    NSMutableString *mutStr = [NSMutableString string];
    
    
    // 分离出字符串中的所有字符，并存储到数组characters中
    for (int i = 0; i < sourceString.length; i ++) {
        NSString *subString = [sourceString substringToIndex:i + 1];
        
        subString = [subString substringFromIndex:i];
        
        [characters addObject:subString];
    }
    
    // 利用正则表达式，匹配数组中的每个元素，判断是否是数字，将数字拼接在可变字符串mutStr中
    for (NSString *b in characters) {
        NSString *regex = @"^[0-9]*$";
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];// 谓词
        BOOL isShu = [pre evaluateWithObject:b];// 对b进行谓词运算
        if (isShu) {
            [mutStr appendString:b];
        }
    }
    return mutStr;
}
/**
 字符串分离出信息
 
 
 */
+ (NSString *)separateInfo:(NSString *)sourceString{
    NSMutableArray *characters = [NSMutableArray array];
    NSMutableString *mutStr = [NSMutableString string];
    
    
    // 分离出字符串中的所有字符，并存储到数组characters中
    for (int i = 0; i < sourceString.length; i ++) {
        NSString *subString = [sourceString substringToIndex:i + 1];
        
        subString = [subString substringFromIndex:i];
        
        [characters addObject:subString];
    }
    
    //数组删除前缀标签
    for (int i = 0;i<characters.count;i++) {
        
        NSString *b = [characters objectAtIndex:i];
        if ([b isEqualToString:@":"]||[b isEqualToString:@"："]) {
            do{
                [characters removeObjectAtIndex:0];
            }while (i--);
            break;
        }
        
    }
    
    //数组转string
    for (int i = 0;i<characters.count ; i++) {
        NSString *b = [characters objectAtIndex:i];
        [mutStr appendString:b];
    }
    
    return mutStr;
}

/**
 字符串删除空格


 */
+ (NSString *)deleteSpace:(NSString *)sourceString{
    
    NSMutableArray *characters = [NSMutableArray array];
    NSMutableString *mutStr = [NSMutableString string];
    
    
    // 分离出字符串中的所有字符，并存储到数组characters中
    for (int i = 0; i < sourceString.length; i ++) {
        NSString *subString = [sourceString substringToIndex:i + 1];
        
        subString = [subString substringFromIndex:i];
        
        [characters addObject:subString];
    }
    
    
    
    //数组删除空格
    for (int i = 0;i< characters.count ;i++) {
        
        NSString *b = [characters objectAtIndex:i];
        if ([b isEqualToString:@" "]) {
            [characters removeObjectAtIndex:i];
        }
    }
    
    
    
    //数组转string
    for (int i = 0;i< characters.count ; i++) {
        NSString *b = [characters objectAtIndex:i];
        [mutStr appendString:b];
    }
    
    return mutStr;
}
+ (NSString *)addGangToDateString:(NSString *)sourceString{
    
    NSMutableArray *characters = [NSMutableArray array];
    NSMutableString *mutStr = [NSMutableString string];
    
    
    // 分离出字符串中的所有字符，并存储到数组characters中
    for (int i = 0; i < sourceString.length; i ++) {
        NSString *subString = [sourceString substringToIndex:i + 1];
        
        subString = [subString substringFromIndex:i];
        
        [characters addObject:subString];
    }
    
    //add '-'
    if (characters.count>4) {
        [characters insertObject:@"-" atIndex:4];
    }
    if (characters.count>7) {
        [characters insertObject:@"-" atIndex:7];
    }
    

    
    //数组转string
    for (int i = 0;i< characters.count ; i++) {
        NSString *b = [characters objectAtIndex:i];
        [mutStr appendString:b];
    }
    
    return mutStr;
    
    
    
}

+ (NSString *)caculateDate:(NSString *)str{
    
    NSString *year = @"0";
    NSString *month = @"0";
    NSString *day = @"0";
    if ([str rangeOfString:@"月" options:NSCaseInsensitiveSearch].length >0) {
        NSString *sumOfMonth = [self switchToNumberString:str];
        int months = [sumOfMonth intValue];
        
        if(months > 12) {
            year  = [NSString stringWithFormat:@"%d",months/12];
            months = months%12;
        }else{
            year = @"0";
        }
        month = [NSString stringWithFormat:@"%d",months];
        day = @"0";
    }else if ([str rangeOfString:@"年" options:NSCaseInsensitiveSearch].length >0){
        NSString *sumOfYears = [ZDStringManager switchToNumberString:str];
        int years = [sumOfYears intValue];
        year = [NSString stringWithFormat:@"%d",years];
        month = @"0";
        day = @"0";
    }else if ([str rangeOfString:@"日" options:NSCaseInsensitiveSearch].length >0){
        NSString *sumOfDays = [ZDStringManager switchToNumberString:str];
        int days = [sumOfDays intValue];
        year = @"0";
        if (days > 30) {
            month = [NSString stringWithFormat:@"%d",days/30];
            days = days/30;
        }
        day = [NSString stringWithFormat:@"%d",days];
    }
    
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    
    return date;
    
    
}

+ (NSString *)addDate:(NSString *)date str:(NSString *)str{
    

    NSMutableArray *charactersForStr = [NSMutableArray array];

    
    int yearForDate=0,monthForDate=0,dayForDate=0;

    // 分离出字符串中的所有数字，并存储到数组charactersForDate中
    if (date.length >=4) {
        NSString *subString0 = [date substringToIndex:4];
        subString0 = [subString0 substringFromIndex:0];
        yearForDate = [subString0 intValue];
    }
    if (date.length >=8) {
        NSString *subString1 = [date substringToIndex:7];
        NSLog(@"substring1ToIndex 8 %@",subString1);
        subString1 = [subString1 substringFromIndex:5];
        NSLog(@"substring1ToIndex 6 %@",subString1);
        monthForDate = [subString1 intValue];
    }
    
    if (date.length >=10) {
        NSString *subString2 = [date substringToIndex:10];
        subString2 = [subString2 substringFromIndex:8];
        dayForDate = [subString2 intValue];
    }

    
    
    // 分离出字符串中的所有数字，并存储到数组charactersForStr中
    
    int yearForStr=0,monthForStr=0,dayForStr=0;
    for (int i = 0; i < str.length; i ++) {
        NSString *subString = [str substringToIndex:i + 1];
        
        subString = [subString substringFromIndex:i];
        
        [charactersForStr addObject:subString];
    }
    //截取str的年份
    NSMutableString *mustrForYear = [NSMutableString string];
    int j=0;
    for (int i = 0; i < charactersForStr.count; i ++) {
        NSString *str = [charactersForStr objectAtIndex:i];
        if ([str isEqualToString:@"-"]) {
            j=i+1;
            break;
        }
        [mustrForYear appendString:str];
        
    }
    yearForStr = [mustrForYear intValue];
    //截取str的月份
    NSMutableString *mustrForMonth = [NSMutableString string];
    int k=0;
    for (; j < charactersForStr.count; j ++) {
        NSString *str = [charactersForStr objectAtIndex:j];
        if ([str isEqualToString:@"-"]) {
            k=j+1;
            break;
        }
        [mustrForMonth appendString:str];
    }
    monthForStr = [mustrForMonth intValue];
    //截取str的日份
    NSMutableString *mustrForDay= [NSMutableString string];
    for (; k < charactersForStr.count; k ++) {
        NSString *str = [charactersForStr objectAtIndex:j];
        if ([str isEqualToString:@"-"]) {
            break;
        }
        [mustrForDay appendString:str];
    }
    //模拟日期加减
    dayForStr = [mustrForDay intValue];
    int yearInt =0,monthInt = 0,dayInt = 0;
    dayInt = dayForDate+dayForStr;
    if (dayInt>60) {
        monthInt++;
        dayInt = dayInt-30;
    }
    monthInt = monthInt+ monthForDate +monthForStr;
    if (monthInt>12) {
        yearInt++;
        monthInt = monthInt-12;
    }
    yearInt = yearInt + yearForDate + yearForStr;
    NSString *strForMonth;
    NSString *strForDay;
    //格式化
    if (monthInt<10) {
        strForMonth = [NSString stringWithFormat:@"0%d",monthInt];
    }else{
        strForMonth = [NSString stringWithFormat:@"%d",monthInt];
    }
    if (dayInt<10) {
        strForDay = [NSString stringWithFormat:@"0%d",dayInt];
    }else{
        strForDay = [NSString stringWithFormat:@"%d",dayInt];
    }
    

    NSString *finalDate = [NSString stringWithFormat:@"%d-%@-%@",yearInt,strForMonth,strForDay];
    
    return finalDate;
    
}





@end
