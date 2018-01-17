//
//  KeyboardViewController.h
//  Keyboard
//
//  Created by Hitesh Dholakiya on 12/28/15.
//  Copyright © 2015 Hitesh Dholakiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardViewController : UIInputViewController

@property (nonatomic, assign) BOOL    isAlwaysCaps;
@property (weak, nonatomic) IBOutlet UIButton *btnCaps;
@property (weak, nonatomic) IBOutlet UIButton *btnBackWard;
@property (weak, nonatomic) IBOutlet UIButton *btnNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnSwitchKeyboard;
@property (weak, nonatomic) IBOutlet UIButton *btnGo;
@property (weak, nonatomic) IBOutlet UIButton *btnSpace;
@property (weak, nonatomic) IBOutlet UIView *alphabetView;
@property (weak, nonatomic) IBOutlet UIView *numericView;

@end
