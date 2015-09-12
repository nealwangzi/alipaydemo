//
//  NYProduct.h
//  支付宝集成
//
//  Created by Apple on 15/9/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYProduct : NSObject

@property (nonatomic, assign) CGFloat price;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detail;

- (instancetype)initWithName:(NSString *)name price:(double)price detail:(NSString *)detail;
+ (instancetype)ProductWithName:(NSString *)name price:(double)price detail:(NSString *)detail;


@end
