//
//  ViewController.m
//  CustomKeyboard
//
//  Created by Hitesh Dholakiya on 12/28/15.
//  Copyright © 2015 Hitesh Dholakiya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    UIImage *image = [UIImage imageNamed:@"earth.png"];
    
    NSLog(@"Image --> %@",image);
    
    NSData *imgData = UIImagePNGRepresentation(image);
    
    NSLog(@"Image Data --> %@",imgData);
    
    [pasteboard setData:imgData forPasteboardType:@"public.png"];
    
    NSLog(@"%@",UIPasteboardTypeListImage);

    NSLog(@"%@",[UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]);
    
    pasteboard.image = image;
    
    NSLog(@"Image String --> %@",pasteboard.image);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
