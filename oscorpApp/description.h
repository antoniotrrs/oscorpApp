//
//  description.h
//  oscorpApp
//
//  Created by Antonio Torres on 03/02/18.
//  Copyright © 2018 Antonio Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"

@interface description : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate, UIPrintInteractionControllerDelegate >{
    UIPrintInteractionController *printController;
    UIDatePicker *pickerDate;
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
    UIPickerView *pickerData;
}
@property (strong, nonatomic) IBOutlet UITextField *date;
@property (strong, nonatomic) IBOutlet UIView *backgroundBlack;
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UIImageView *tempDrawImage;
@property (strong, nonatomic) IBOutlet UITextField *drName;
@property (strong, nonatomic) IBOutlet UITextField *treatment;

@property (strong, nonatomic) IBOutlet UITextField *selected;
@property (nonatomic) NSInteger opSelected;
@property (nonatomic) BOOL writed;
@property (nonatomic) NSString *nameDoc;
@property (strong, nonatomic) IBOutlet UIButton *btnAddSignature;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *arrayPicker;
@property (strong, nonatomic) IBOutlet UIImageView *signatureView;

@property (strong, nonatomic) IBOutlet UITextField *namePatient;
@property (strong, nonatomic) IBOutlet UIView *superView;
@property (strong, nonatomic) IBOutlet UILabel *labelName;

- (IBAction)deletAll:(UIButton *)sender;

- (IBAction)DoneButton:(UIButton *)sender;
- (IBAction)addSignature:(UIButton *)sender;
- (IBAction)savePDF:(UIButton *)sender;


@end
