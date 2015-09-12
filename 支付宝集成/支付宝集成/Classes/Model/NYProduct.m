//
//  NYProduct.m
//  支付宝集成
//
//  Created by Apple on 15/9/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYProduct.h"

@implementation NYProduct
- (instancetype)initWithName:(NSString *)name price:(double)price detail:(NSString *)detail{
    if (self = [super init]) {
        self.name = name;
        self.price = price;
        self.detail = detail;
    }
    return self;

}
+ (instancetype)ProductWithName:(NSString *)name price:(double)price detail:(NSString *)detail
{
    return [[self alloc]initWithName:name price:price detail:detail];
}

@end
