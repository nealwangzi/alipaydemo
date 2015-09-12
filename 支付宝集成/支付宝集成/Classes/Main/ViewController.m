//
//  ViewController.m
//  支付宝集成
//
//  Created by Apple on 15/9/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "NYProduct.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface ViewController ()
/* 产品 */
@property(nonatomic , strong) NSArray *products;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"product";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NYProduct *p = self.products[indexPath.row];
    
    cell.textLabel.text =p.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %.2f",p.price];
    
    return cell;
}
#pragma mark - tableview 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NYProduct *product = self.products[indexPath.row];
    
    [self buyProduct:product];
}
- (void)buyProduct:(NYProduct *)product
{
    /**
     *  1.签约后获取商户ID/账号ID/私钥
     */
    NSString *partner = @"";
    NSString *seller = @"";
    NSString *privateKey = @"";
    /**
     2.创建订单
     */
    Order *order = [[Order alloc]init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = @"";//商户自己决定
    order.productName = product.name;
    order.productDescription = product.detail;
    order.amount = [NSString stringWithFormat:@"%.2f",product.price];
    order.notifyURL = @"";//回调地址
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    /**
     *  应用注册scheme, 在info.plist定义
     */
    NSString *appScheme = @"zhifubaojicheng";
    
    NSString *orderSpec = [order description];
    /**
     获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
     */
    id<DataSigner>singer = CreateRSADataSigner(privateKey);
    NSString *signedString = [singer signString:orderSpec];
    // 格式化订单,严格按照格式
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderSpec, signedString, @"RSA"];
    // 开始支付(网页/打开支付宝客户端)
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        // 只有是通过网页支付的时候才会回调该位置
        NSLog(@"reslut = %@",resultDic);

    }];
}
#pragma mark - lazy
- (NSArray *)products
{
    if (_products == nil) {
        NYProduct *p1 = [NYProduct ProductWithName:@"iphone4" price:99 detail:@"经典"];
        NYProduct *p2 = [NYProduct ProductWithName:@"iphone4s" price:199 detail:@"经典"];
        NYProduct *p3 = [NYProduct ProductWithName:@"iphone5" price:299 detail:@"经典"];
        NYProduct *p4 = [NYProduct ProductWithName:@"iphone5s" price:399 detail:@"经典"];
        NYProduct *p5 = [NYProduct ProductWithName:@"iphone6" price:499 detail:@"经典"];
        NYProduct *p6 = [NYProduct ProductWithName:@"iphone6s" price:599 detail:@"经典"];

        _products = @[
                      p1,p2,p3,p4,p5,p6
                      ];
    }
    return _products;
}

@end
