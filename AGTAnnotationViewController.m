//
//  AGTAnnotationViewController.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 17/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTAnnotationViewController.h"
#import "AGTPhotoViewController.h"
#import "AGTAnnotation.h"

@interface AGTAnnotationViewController ()



@end

@implementation AGTAnnotationViewController

#pragma mark - Init

-(id)initWithAnnotation:(AGTAnnotation *)annotation {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _annotation = annotation;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Asignamos delegados
    self.nameView.delegate = self;
    
    // Dar de alta notificación teclado
    [self setupKeyboardNotification];
    
    // Sincronizar el modelo con la vista
    // Fechas
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterShortStyle;
    
    // Nombre
    self.nameView.text = self.annotation.name;
    
    // Texto
    self.textView.text = self.annotation.text;
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // Sincronizo vistas -> modelo
    self.annotation.text = self.textView.text;
    self.annotation.name = self.nameView.text;
    
    // Baja notificaciones
    
    [self tearDownKeyboardNotifications];
}

#pragma mark - Actions

- (IBAction)displayPhoto:(id)sender {
    
    AGTPhotoViewController *pVC = [[AGTPhotoViewController alloc] initWithPhoto:self.annotation.photo];
    
    [self.navigationController pushViewController:pVC animated:YES];
}

-(IBAction)hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // Buen momento para validar el texto
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    // Buen momento para guardar el texto
    
}

#pragma mark - Notifications

-(void) setupKeyboardNotification {
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboradWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillDisappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
}

-(void) tearDownKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) notifyThatKeyboradWillAppear: (NSNotification *) notificaction {
    
    // Sacar el temaño del teclado del userInfo
    NSValue *wrappedFrame = [[notificaction userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    double duration = [[[notificaction userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect kbdFrame = [wrappedFrame CGRectValue];
    
    CGRect currentFrame = self.textView.frame;
    
    // Hacerlo con una animación que coincida con la del teclado
    [UIView animateWithDuration:duration
                     animations:^{
                         CGRect newRect = CGRectMake(currentFrame.origin.x,
                                                     currentFrame.origin.y,
                                                     currentFrame.size.width,
                                                     currentFrame.size.height - kbdFrame.size.height + self.bottomBar.frame.size.height);
                         
                         // Calcular los nuevos bounds del self.textView
                         self.textView.frame = newRect;
                     }];
}

-(void) notifyThatKeyboardWillDisappear: (NSNotification *) notification {
    
    
    double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // Devolver a self.textView su bounds original mediante una animación que coincide con la del teclado
    
    [UIView animateWithDuration:duration
                     animations:^{
                         self.textView.frame = CGRectMake(8, 191, 359, 426);
                     }];
    
}

@end
