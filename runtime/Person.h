//
//  Person.h
//  runtime
//
//  Created by Zeke on 2018/4/12.
//  Copyright © 2018年 Zeke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

-(void)eat;

+(void)Play;

/**
 获取属性列表
 */
-(void)PropertyNum;
/**
 获取方法列表
 */
-(void)MethodListNum;
/**
 获取成员变量列表
 */
-(void)IVarListNum;
@end
