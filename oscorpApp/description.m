//
//  description.m
//  oscorpApp
//
//  Created by Antonio Torres on 03/02/18.
//  Copyright © 2018 Antonio Torres. All rights reserved.
//

#import "description.h"
#define kDefaultPageHeight 1024
#define kDefaultPageWidth  768
#define kMargin 5

@interface description ()

@end

@implementation description
@synthesize date, backgroundBlack, tempDrawImage, mainImage, drName, treatment, arrayPicker, namePatient, labelName, scrollView, nameDoc;

- (void)viewDidLoad {
    
    date.delegate = self;
    drName.delegate = self;
    treatment.delegate = self;
    
    
    _writed = FALSE;
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    [super viewDidLoad];
    [backgroundBlack setHidden:YES];
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self                                                selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"es"]];
    [dateFormatter setDateFormat:@"dd LLLL yyyy"];
    self.date.text = [dateFormatter stringFromDate:[NSDate date]];
    
    
    pickerDate = [[UIDatePicker alloc] init];
    [pickerDate setLocale: [NSLocale localeWithLocaleIdentifier:@"es"]];
    [pickerDate setDatePickerMode:UIDatePickerModeDate];
    [pickerDate addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.date.inputView = pickerDate;
    
    

    
    [drName addTarget:self action:@selector(selectDoctor:) forControlEvents:UIControlEventEditingDidBegin];
    [treatment addTarget:self action:@selector(selectTreatment:) forControlEvents:UIControlEventEditingDidBegin];
    [namePatient addTarget:self action:@selector(selectPatient:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Listo" style:UIBarButtonItemStyleDone target:self action:@selector(hideSpiner)];
    [toolbar setItems:[NSArray arrayWithObject:doneBtn]];
    
    UIToolbar *toolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneBtn2 = [[UIBarButtonItem alloc] initWithTitle:@"Listo" style:UIBarButtonItemStyleDone target:self action:@selector(hideDataDoctor)];
    [toolbar2 setItems:[NSArray arrayWithObject:doneBtn2]];
    
    UIToolbar *toolbar3 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneBtn3 = [[UIBarButtonItem alloc] initWithTitle:@"Listo" style:UIBarButtonItemStyleDone target:self action:@selector(hideDataTreatment)];
    [toolbar3 setItems:[NSArray arrayWithObject:doneBtn3]];
    
    UIToolbar *toolbar4 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneBtn4 = [[UIBarButtonItem alloc] initWithTitle:@"Listo" style:UIBarButtonItemStyleDone target:self action:@selector(hideDataPatient)];
    [toolbar4 setItems:[NSArray arrayWithObject:doneBtn4]];
    
    
    
    [self.date setInputAccessoryView:toolbar];
    [self.drName setInputAccessoryView:toolbar2];
    [self.treatment setInputAccessoryView:toolbar3];
    [self.namePatient setInputAccessoryView:toolbar4];
}

- (void)selectDoctor:(UITextField *)doctor{
    pickerData = [UIPickerView new];
    pickerData.delegate = self;
    pickerData.dataSource = self;
    pickerData.showsSelectionIndicator = YES;
    _selected = self.drName;
    self.arrayPicker = @[@"Selecciona una opción",@"Oscar Nuñez Espronceda",@"Benito Juarez Faz",@"Orlando Gonzalez Alejo"];
    self.drName.inputView = pickerData;
    
}

- (void)selectTreatment:(UITextField * )treatment{
    pickerData = [UIPickerView new];
    pickerData.delegate = self;
    pickerData.dataSource = self;
    pickerData.showsSelectionIndicator = YES;
    _selected = self.treatment;
    _writed = false;
    self.arrayPicker = @[@"Selecciona una opción",@"Control de peso",@"Medicina General",@"Otro (especificar)"];
    if(self.opSelected != 3){
        self.treatment.inputView = pickerData;
    }
    
    
}

- (void)selectPatient:(UITextField * )patient{
    _selected = self.namePatient;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 4;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return arrayPicker[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _opSelected = row;
}

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"es"]];
    [dateFormatter setDateFormat:@"dd LLLL yyyy"];
    self.date.text = [dateFormatter stringFromDate:datePicker.date];
}

- (void)hideSpiner{
    [self.date resignFirstResponder];
}

- (void)hideDataDoctor{
    _selected.text = arrayPicker[_opSelected];
    [self.drName resignFirstResponder];
}

-(void)hideDataTreatment{
    if(_opSelected == 3){
        if (_writed == FALSE) {
            NSLog(@"aqui");
            [self.treatment resignFirstResponder];
            self.treatment.inputView = nil;
            self.treatment.text =  nil;
            [self.treatment becomeFirstResponder];
            _writed = true;
        }else{
            NSLog(@"aaca");
             [self.treatment resignFirstResponder];
            self.treatment.inputView = pickerData;
        }
    }else{
        NSLog(@"mm");
        _selected.text = arrayPicker[_opSelected];
         [self.treatment resignFirstResponder];
    }
    
   
}

-(void)hideDataPatient{
    [self.namePatient resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.tempDrawImage];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.tempDrawImage];
    
    UIGraphicsBeginImageContext(self.tempDrawImage.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width , self.tempDrawImage.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.tempDrawImage.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)deletAll:(UIButton *)sender {
    [self clearDocument];
}

- (IBAction)DoneButton:(UIButton *)sender {
    UIGraphicsBeginImageContextWithOptions(mainImage.bounds.size, NO,0.0);
    [mainImage.image drawInRect:CGRectMake(0, 0, mainImage.frame.size.width, mainImage.frame.size.height)];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.signatureView.image = SaveImage;
    
    labelName.text = [namePatient text];
    [_btnAddSignature setHidden:YES];
    [backgroundBlack setHidden:YES];
}

- (IBAction)addSignature:(UIButton *)sender {
    [backgroundBlack setHidden:NO];
}

- (IBAction)savePDF:(UIButton *)sender {
    NSString *doctor = [drName text];
    NSString *treat = [treatment text];
    if ([doctor  isEqual:@""] || [treat  isEqual: @""] || [labelName.text  isEqual: @""]) {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Error" message:@"Falta completar algunos campos" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *doneButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            
        }];
        [alert addAction:doneButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        NSString *nameP = [namePatient text];
        NSString *newName  = [nameP stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        
        NSDateFormatter *dateFormer = [[NSDateFormatter alloc] init];
        [dateFormer setDateFormat:@"ddMMyyyy'T'HHmmss"];
        NSString *datee = [dateFormer stringFromDate:[NSDate date]];
        
        nameDoc =[newName stringByAppendingString:datee];
    }
    
    
    
    [self createPDFfromUIView:self.view saveToDocumentsWithFileName:nameDoc];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:nameDoc];
  
    NSLog(@"path: %@",path);
    
    NSData *myData = [[NSData alloc] initWithContentsOfFile: path];
    NSString *urlString = @"http://192.168.15.10/script.php";
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"userfile" fileName:[NSString stringWithFormat:@"%@.pdf",nameDoc] mimeType:@"application/pdf" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", string);
        NSLog(@"%@", response);
        NSLog(@"%@", error);
        
        if (error) {
            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle:@"Error" message:@"Ocurrio un error al intentar guardar el documento" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *doneButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                
            }];
            [alert addAction:doneButton];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle:@"Listo" message:@"Se guardo correctamente el archivo" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *doneButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self clearDocument];
            }];
            [alert addAction:doneButton];
            [self presentViewController:alert animated:YES completion:nil];
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    [uploadTask resume];
    
  
   
    
}

-(void) clearDocument {
    drName.text = @"";
    treatment.text = @"";
    self.signatureView.image = nil;
    labelName.text = @"";
    mainImage.image = nil;
    tempDrawImage.image = nil;
    namePatient.text = @"";
    [_btnAddSignature setHidden:NO];
}

-(void)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename

{
    NSMutableData *pdfData = [NSMutableData data];
    
    UIGraphicsBeginPDFContextToData(pdfData, (CGRect){0,0, scrollView.contentSize}, nil);
    
    CGRect origSize = scrollView.frame;
    CGRect newSize = origSize;
    newSize.size = scrollView.contentSize;
    [scrollView setFrame:newSize];
    
  
    
    
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    
    [aView.layer renderInContext:pdfContext];
    UIGraphicsEndPDFContext();
    [scrollView setFrame:origSize];
    
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    NSString *file = [documentDirectory stringByAppendingPathComponent:@"yourPDF.pdf"];
    NSURL *urlPdf = [NSURL fileURLWithPath: file];
    
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    
    
}



- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if (_selected.frame.origin.y + _selected.frame.size.height > [UIScreen mainScreen].bounds.size.height - keyboardSize.height) {
        // textfield is covered by keyboard
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -keyboardSize.height;
            self.view.frame = f;
        }];
    }
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}
@end
