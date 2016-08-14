//
//  MBFileManager.h
//
//  Created by Murphy Brantley on 8/14/16.
//  Copyright © 2016 Murphy Brantley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBFileManager : NSObject


+ (void)createFileWithName:(NSString *)fileName;
+ (void)deleteFileWithName:(NSString *)fileName;
+ (void)listAllLocalFiles;
+ (void)renameFileWithName:(NSString *)srcName toName:(NSString *)dstName;
+ (void)readFileWithName:(NSString *)fileName;
+ (void)writeString:(NSString *)content toFile:(NSString *)fileName;
+ (BOOL)checkFileExists:(NSString *)fileName;

+ (NSArray *)readArrayFromFileWithName:(NSString *)fileName;
+ (void)writeArray:(NSArray *)content toFile:(NSString *)fileName;

+ (void)writeImage:(UIImage *)content toFile:(NSString *)fileName;
+ (UIImage *)readImageFromFileWithName:(NSString *)fileName;

+ (NSString *) readStringFromFileWithName:(NSString *)fileName;

@end
