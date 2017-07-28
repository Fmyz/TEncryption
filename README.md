# TEncryption
MD5,DES,AES,GTMBase64,Encrypt

pod 'TEncryption'

/*TEncryption*/
NSString *str = @"FmyzL";
NSLog(@"tMD5:%@", str.tMD5);

NSString *desEncryptStr = str.desEncrypt;
NSLog(@"desEncryptStr:%@", desEncryptStr);
NSLog(@"desDecrypt:%@", desEncryptStr.desDecrypt);

NSString *aesEncryptStr = str.aesEncrypt;
NSLog(@"aesEncryptStr:%@", aesEncryptStr);
NSLog(@"aesDecrypt:%@", aesEncryptStr.aesDecrypt);

NSString *GTMBase64EncryptStr = str.GTMBase64Encrypt;
NSLog(@"GTMBase64EncryptStr:%@", GTMBase64EncryptStr);
NSLog(@"GTMBase64Decrypt:%@", GTMBase64EncryptStr.GTMBase64Decrypt);

