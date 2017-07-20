//
//  NSString+TEncryption.h
//  TCodeStudy
//
//  Created by Fmyz on 2017/7/19.
//  Copyright © 2017年 Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TEncryption)

/*MD5*/
- (NSString *)tMD5;

/*DES*/
/// DES加密方法
- (NSString *)desEncrypt;
/// DES解密方法
- (NSString *)desDecrypt;

/*AES*/
/// AES加密方法
- (NSString *)aesEncrypt;
/// AES解密方法
- (NSString *)aesDecrypt;

/*GTMBase64*/
/// GTMBase64加密方法
- (NSString *)GTMBase64Encrypt;
/// GTMBase64解密方法
- (NSString *)GTMBase64Decrypt;
@end
