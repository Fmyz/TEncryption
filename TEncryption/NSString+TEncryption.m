//
//  NSString+TEncryption.m
//  TCodeStudy
//
//  Created by Fmyz on 2017/7/19.
//  Copyright © 2017年 Tan. All rights reserved.
//

#import "NSString+TEncryption.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "AESCrypt.h"

//密钥
#define tkey @"fmyz@despass@1234"
//偏移量
#define tIv @"0123456789"

@implementation NSString (TEncryption)

//md5 32位 加密
- (NSString *)tMD5
{
    NSString *input = self;
    if (!input) {
        return nil;
    }
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str,(CC_LONG) strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

#pragma mark- DES加密方法
- (NSString*)desEncrypt
{
    NSString *inputText = self;
    if (!inputText) {
        return nil;
    }
    NSData* data = [inputText dataUsingEncoding:NSUTF8StringEncoding];
    size_t inputTextBufferSize = [data length];
    const void *vinputText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (inputTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [tkey UTF8String];
    const void *vinitVec = (const void *) [tIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vinputText,
                       inputTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    return result;
}

#pragma mark- DES解密方法
- (NSString*)desDecrypt
{
    NSString *inputText = self;
    if (!inputText) {
        return nil;
    }
    NSData *decryptData = [GTMBase64 decodeString:inputText];
    size_t inputTextBufferSize = [decryptData length];
    const void *vinputText = [decryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (inputTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [tkey UTF8String];
    const void *vinitVec = (const void *) [tIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vinputText,
                       inputTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    return result;
}

#pragma mark- AES加密方法
- (NSString*)aesEncrypt
{
    NSString *inputText = self;
    if (!inputText) {
        return nil;
    }
    
    NSString *result = [AESCrypt encrypt:inputText password:tkey];
    
    return result;
}

#pragma mark- AES解密方法
- (NSString*)aesDecrypt
{
    NSString *inputText = self;
    if (!inputText) {
        return nil;
    }
   
    NSString *result = [AESCrypt decrypt:inputText password:tkey];
    
    return result;
}

#pragma mark- GTMBase64加密方法
- (NSString*)GTMBase64Encrypt
{
    NSString *inputText = self;
    if (!inputText) {
        return nil;
    }
    
    NSData *encryptData = [inputText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = [GTMBase64 stringByEncodingData:encryptData];
    
    return result;
}

#pragma mark- GTMBase64解密方法
- (NSString*)GTMBase64Decrypt
{
    NSString *inputText = self;
    if (!inputText) {
        return nil;
    }
    
    NSData *decryptData = [GTMBase64 decodeString:inputText];
    NSString *result = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    return result;
}

@end
