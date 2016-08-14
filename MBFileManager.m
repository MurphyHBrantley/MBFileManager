//
//  MBFileManager.m
//
//  Created by Murphy Brantley on 8/14/16.
//  Copyright © 2016 Murphy Brantley. All rights reserved.
//

#import "MBFileManager.h"

@implementation MBFileManager


+ (BOOL)checkFileExists:(NSString *)fileName
{
    BOOL fileExists;
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:fileName];
    fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    
    return fileExists;
}


+ (void)listAllLocalFiles
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    // This function will return all of the files' Name as an array of NSString.
    NSArray *files = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    // Log the Path of document directory.
    NSLog(@"Directory: %@", documentsDirectory);
    // For each file, log the name of it.
    for (NSString *file in files) {
        NSLog(@"File at: %@", file);
    }
}



+ (void)createFileWithName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSLog(@"filePath: %@",filePath);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    // 1st, This funcion could allow you to create a file with initial contents.
    // 2nd, You could specify the attributes of values for the owner, group, and permissions.
    // Here we use nil, which means we use default values for these attibutes.
    // 3rd, it will return YES if NSFileManager create it successfully or it exists already.
    if ([manager createFileAtPath:filePath contents:nil attributes:nil]) {
        NSLog(@"Created the File Successfully.");
    } else {
        NSLog(@"Failed to Create the File");
    }
}

+ (void)deleteFileWithName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    // Need to check if the to be deleted file exists.
    if ([manager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        // This function also returnsYES if the item was removed successfully or if path was nil.
        // Returns NO if an error occurred.
        [manager removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        NSLog(@"File %@ doesn't exists", fileName);
    }
}


+ (void)renameFileWithName:(NSString *)srcName toName:(NSString *)dstName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePathSrc = [documentsDirectory stringByAppendingPathComponent:srcName];
    NSString *filePathDst = [documentsDirectory stringByAppendingPathComponent:dstName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePathSrc]) {
        NSError *error = nil;
        [manager moveItemAtPath:filePathSrc toPath:filePathDst error:&error];
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        NSLog(@"File %@ doesn't exists", srcName);
    }
}


+ (void)readFileWithName:(NSString *)fileName
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        // Start to Read.
        NSError *error = nil;
        NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSStringEncodingConversionAllowLossy error:&error];
        NSLog(@"File Content: %@", content);
        
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        NSLog(@"File %@ doesn't exists", fileName);
    }
}

#pragma mark Array

+ (void)writeArray:(NSArray *)content toFile:(NSString *)fileName
{
	// Fetch directory path of document for local application.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	// Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
	
	// NSFileManager is the manager organize all the files on device.
	NSFileManager *manager = [NSFileManager defaultManager];
	// Check if the file named fileName exists.
	if ([manager fileExistsAtPath:filePath]) {
		NSError *error = nil;
		// Since [writeToFile: atomically: encoding: error:] will overwrite all the existing contents in the file, you could keep the content temperatorily, then append content to it, and assign it back to content.
		// To use it, simply uncomment it.
		//        NSString *tmp = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:NSStringEncodingConversionAllowLossy error:nil];
		//        if (tmp) {
		//            content = [tmp stringByAppendingString:content];
		//        }
		// Write NSString content to the file.
		//NSLog(@"saving this array: %@",content);
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:content];
		[data writeToFile:filePath atomically:YES];
		// If error happens, log it.
		if (error) {
			NSLog(@"There is an Error: %@", error);
		}
	} else {
		// If the file doesn't exists, log it.
		NSLog(@"File %@ doesn't exists", fileName);
	}
	
}

+ (NSArray *)readArrayFromFileWithName:(NSString *)fileName
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        // Start to Read.
        NSError *error = nil;
        NSData *content = [NSData dataWithContentsOfFile:filePath];
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:content];
        //NSLog(@"File Content: %@", array);
        
        if (error) {
            NSLog(@"There is an Error: %@", error);
            return nil;
        } else {
            return array;
        }
    } else {
        NSLog(@"File %@ doesn't exists", fileName);
        return nil;
    }
}

#pragma mark STRING

+ (void)writeString:(NSString *)content toFile:(NSString *)fileName
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    // Check if the file named fileName exists.
    if ([manager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        // Since [writeToFile: atomically: encoding: error:] will overwrite all the existing contents in the file, you could keep the content temperatorily, then append content to it, and assign it back to content.
        // To use it, simply uncomment it.
        //        NSString *tmp = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:NSStringEncodingConversionAllowLossy error:nil];
        //        if (tmp) {
        //            content = [tmp stringByAppendingString:content];
        //        }
        // Write NSString content to the file.
        [content writeToFile:filePath atomically:YES encoding:NSNonLossyASCIIStringEncoding error:&error];
        // If error happens, log it.
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        // If the file doesn't exists, log it.
        NSLog(@"File %@ doesn't exists", fileName);
    }
    
}

+ (NSString *) readStringFromFileWithName:(NSString *)fileName {
	
	// Fetch directory path of document for local application.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	// Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
	
	// NSFileManager is the manager organize all the files on device.
	NSFileManager *manager = [NSFileManager defaultManager];
	if ([manager fileExistsAtPath:filePath]) {
		// Start to Read.
		NSError *error = nil;
		NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSNonLossyASCIIStringEncoding error:&error];
		NSLog(@"File Content: %@", content);
		
		if (error) {
			NSLog(@"There is an Error: %@", error);
		} else {
			return content;
		}
	} else {
		NSLog(@"File %@ doesn't exists", fileName);
	}
	return nil;
}


#pragma mark IMAGE

+ (void)writeImage:(UIImage *)content toFile:(NSString *)fileName
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    // Check if the file named fileName exists.
    if ([manager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        // Since [writeToFile: atomically: encoding: error:] will overwrite all the existing contents in the file, you could keep the content temperatorily, then append content to it, and assign it back to content.
        // To use it, simply uncomment it.
        //        NSString *tmp = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:NSStringEncodingConversionAllowLossy error:nil];
        //        if (tmp) {
        //            content = [tmp stringByAppendingString:content];
        //        }
        // Write NSString content to the file.
        //NSLog(@"saving this array: %@",content);
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:content];
        [data writeToFile:filePath atomically:YES];
        // If error happens, log it.
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        // If the file doesn't exists, log it.
        NSLog(@"File %@ doesn't exists", fileName);
    }
    
}

+ (UIImage *)readImageFromFileWithName:(NSString *)fileName
{
	// Fetch directory path of document for local application.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	// Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
	
	// NSFileManager is the manager organize all the files on device.
	NSFileManager *manager = [NSFileManager defaultManager];
	if ([manager fileExistsAtPath:filePath]) {
		// Start to Read.
		NSError *error = nil;
		NSData *content = [NSData dataWithContentsOfFile:filePath];
		UIImage *img = [NSKeyedUnarchiver unarchiveObjectWithData:content];
		//NSLog(@"File Content: %@", array);
		
		if (error) {
			NSLog(@"There is an Error: %@", error);
			return nil;
		} else {
			return img;
		}
	} else {
		NSLog(@"File %@ doesn't exists", fileName);
		return nil;
	}
}






@end
