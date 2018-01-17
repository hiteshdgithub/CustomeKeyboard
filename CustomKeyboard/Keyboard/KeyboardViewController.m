//
//  KeyboardViewController.m
//  Keyboard
//
//  Created by Hitesh Dholakiya on 12/28/15.
//  Copyright © 2015 Hitesh Dholakiya. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()

@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.btnCaps setImage:[UIImage imageNamed:@"offCaps"] forState:UIControlStateNormal];
    
    [self.btnSwitchKeyboard addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    self.inputView =  self.view;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }

}

-(IBAction)onPressCapsOnAndOff :(UIButton *)btn
{
    
    if (!self.alphabetView.hidden)
    {
        if ([self.btnCaps.imageView.image isEqual:[UIImage imageNamed:@"offCaps"]])
        {
            [self capitalAlphabets];
        }
        else
        {
            [self lowerCaseAlphabets];
        }
    }
    else
    {
        if ([[self.btnCaps currentTitle] isEqualToString:@"123"])
        {
            [self.btnCaps setTitle:@"#+=" forState:UIControlStateNormal];
            [self setNumericAndSymbols];
        }
        else
        {
            [self.btnCaps setTitle:@"123" forState:UIControlStateNormal];
            [self setSymbols];
        }
    }
        
}

-(void)lowerCaseAlphabets
{
    
    for (NSUInteger i=1; i<27; i++)
    {
        UIButton *btn = (UIButton *)[self.alphabetView viewWithTag:i];
        [btn setTitle:[[btn currentTitle] lowercaseString] forState:UIControlStateNormal];
    }
    
    [self.btnCaps setTitle:@"" forState:UIControlStateNormal];
    
    [self.btnCaps setImage:[UIImage imageNamed:@"offCaps"] forState:UIControlStateNormal];
    
    [self.btnCaps setBackgroundColor:[UIColor colorWithRed:155.0f/255.0f green:164.0f/255.0f blue:174.0f/255.0f alpha:1.0f]];
    
}

-(void)capitalAlphabets
{
    
    for (NSUInteger i=1; i<27; i++)
    {
        UIButton *btn = (UIButton *)[self.alphabetView viewWithTag:i];
        [btn setTitle:[[btn currentTitle] uppercaseString] forState:UIControlStateNormal];
    }
    
    [self.btnCaps setImage:[UIImage imageNamed:@"oneTimeOnCaps"] forState:UIControlStateNormal];
    
    [self.btnCaps setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)setNumericAndSymbols
{
    
    NSMutableArray *numericAndSymbols = [self symbolAndNumerics];
    
    for (NSUInteger i=0; i<[numericAndSymbols count]; i++)
    {
        UIButton *btn = (UIButton *)[self.numericView viewWithTag:i+1];
        
        [btn setTitle:[numericAndSymbols objectAtIndex:i] forState:UIControlStateNormal];
    }
    
}

-(void)setSymbols
{
    
    NSMutableArray *numericAndSymbols = [self symbols];
    
    for (NSUInteger i=0; i<[numericAndSymbols count]; i++)
    {
        UIButton *btn = (UIButton *)[self.numericView viewWithTag:i+1];
        
        [btn setTitle:[numericAndSymbols objectAtIndex:i] forState:UIControlStateNormal];
    }
    
}

-(IBAction)onPressBackWard :(UIButton *)btn
{
    
    [self.textDocumentProxy deleteBackward];

}

-(IBAction)onPressGo :(UIButton *)btn
{
    [self.textDocumentProxy insertText:@"\n"];
}

-(IBAction)onPressSpace :(UIButton *)btn
{
    [self.textDocumentProxy insertText:@" "];
}

-(IBAction)onPressKeys :(UIButton *)btn
{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    UIImage *image = [UIImage imageNamed:@"earth.png"];
    
    NSLog(@"Image --> %@",image);
    
    NSData *imgData = UIImagePNGRepresentation(image);
    
    NSLog(@"Image Data --> %@",imgData);
    
    NSLog(@"%@",UIPasteboardTypeListImage);
    
    [pasteboard setData:imgData forPasteboardType:UIPasteboardTypeListImage[0]];

    NSLog(@"Image String --> %@",pasteboard.string);
    
    [self.textDocumentProxy insertText:pasteboard.string];
    
   // [self.textDocumentProxy insertText:[btn currentTitle]];

}

-(IBAction)onPressNumeric :(UIButton *)btn
{
    
    [UIView animateWithDuration:0.2f animations:^{
        
        if ([[btn currentTitle] isEqualToString:@"123"])
        {
            
            [self.btnNumber setTitle:@"ABC" forState:UIControlStateNormal];
            self.btnNumber.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [self.btnCaps setImage:Nil forState:UIControlStateNormal];
            [self.btnCaps setTitle:@"#+=" forState:UIControlStateNormal];
            self.alphabetView.hidden = YES;
            self.numericView.hidden = NO;
            [self setNumericAndSymbols];
            
        }
        else
        {
            [self.btnNumber setTitle:@"123" forState:UIControlStateNormal];
            self.btnNumber.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [self.btnCaps setTitle:@"" forState:UIControlStateNormal];
            [self.btnCaps setImage:[UIImage imageNamed:@"offCaps"] forState:UIControlStateNormal];
            [self.btnCaps setBackgroundColor:[UIColor colorWithRed:155.0f/255.0f green:164.0f/255.0f blue:174.0f/255.0f alpha:1.0f]];
            self.numericView.hidden = YES;
            self.alphabetView.hidden = NO;
            [self lowerCaseAlphabets];
        }
        
    }];
    
}

-(IBAction)onPressGoTouchDownEvent:(UIButton *)sender
{
    [self.btnGo setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.btnGo setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.btnGo setBackgroundColor:[UIColor whiteColor]];
}

-(NSMutableArray *)alphabates
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"q",
                             @"w",
                             @"e",
                             @"r",
                             @"t",
                             @"y",
                             @"u",
                             @"i",
                             @"o",
                             @"p",
                             @"a",
                             @"s",
                             @"d",
                             @"f",
                             @"g",
                             @"h",
                             @"j",
                             @"k",
                             @"l",
                             @"z",
                             @"x",
                             @"c",
                             @"v",
                             @"b",
                             @"n",
                             @"m",
                             nil];
    return array;
}

-(NSMutableArray *)symbolAndNumerics
{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"1",
                             @"2",
                             @"3",
                             @"4",
                             @"5",
                             @"6",
                             @"7",
                             @"8",
                             @"9",
                             @"0",
                             @"-",
                             @"/",
                             @":",
                             @";",
                             @"(",
                             @")",
                             @"$",
                             @"&",
                             @"@",
                             @"\"",
                             nil];
    return array;
    
}

-(NSMutableArray *)symbols
{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"[",
                             @"]",
                             @"{",
                             @"}",
                             @"#",
                             @"%",
                             @"^",
                             @"*",
                             @"+",
                             @"=",
                             @"_",
                             @"\\",
                             @"|",
                             @"~",
                             @"<",
                             @">",
                             @"€",
                             @"£",
                             @"¥",
                             @".",
                             nil];
    return array;
    
}

@end
