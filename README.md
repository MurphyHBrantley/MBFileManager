# MBFileManager
MBFileManager is an Objective-C iOS File Manager class is built on top of the NSFileManager class to simplify file management.  It provides several methods for reading, writing, and managing files in the Documents Directory with just a few lines of code.

## Requirements
- iOS >= 5.0
- ARC enabled

## Installation

Manual Installation
- copy `MBFileManager.h` and `MBFileManager.m` into your project

## Features

- **Create** files in the Documents Directory
- **Delete** files from the Documents Directory
- **Rename** files in the Documents Directory
- **List** all files in the Documents Directory
- **Read** files in the Documents Directory
- **Check** if files exist in the Documents Directory
- **Write** several different data types to files in the Documents Directory, including Strings, Arrays, and Images

## Usage

Add `#import "MBFileManager.h"` to your class to access the `MBFileManager` methods

*Note:* You must create a file before reading/writing to that file.  Use the `checkFileExists:` method to make sure the file exists before using the file.  You will get an error message in the console if you try to access a file that does not exist.

### Code Examples

**Create File:**

    [MBFileManager createFileWithName:@"MyTestFile"];

**Delete File:**

    [MBFileManager deleteFileWithName:@"MyTestFile"];

**Rename File:**

    [MBFileManager renameFileWithName:@"MyTestFile" toName:@"MyNewNameFile"];

**List All Files:**

    [MBFileManager listAllLocalFiles];

**Read File:**

    [MBFileManager readFileWithName:@"MyTestFile"];

**Check File Exists:**

    [MBFileManager checkFileExists:@"MyTestFile"];

**Write Data Types:**

*String*

    [MBFileManager writeString:@"Test String" toFile:@"MyTestFile"];

*Array*

    NSArray *array = [[NSArray alloc] initWithObjects:@"One",@"Two",@"Three", nil];
    [MBFileManager writeArray:array toFile:@"MyTestFile"];

*Image*

    [MBFileManager writeImage:[UIImage imageNamed:@"myImage.png"] toFile:@"MyTestFile"];

**Read Data Types:**

*String*

    NSString *myString = [MBFileManager readStringFromFileWithName:@"MyTestFile"];

*Array*

    NSArray *myArray = [MBFileManager readArrayFromFileWithName:@"MyTestFile"];

*Image*

    UIImage *myImage = [MBFileManager readImageFromFileWithName:@"MyTestFile"];
