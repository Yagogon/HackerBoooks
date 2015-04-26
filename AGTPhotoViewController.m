//
//  AGTPhotoViewController.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 17/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//


#import "AGTPhotoViewController.h"
#import "AGTPhoto.h"

@interface AGTPhotoViewController ()

@end

@implementation AGTPhotoViewController

-(id) initWithPhoto:(AGTPhoto *)photo {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _photo = photo;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - View Life Cycle

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Me aseguro que la vista no ocupa toda la pantalla, sino lo que queda disponible dentro del navigation
    
    
    // Sincronizo modelo -> vista
    self.photoView.image = [UIImage imageWithData:self.photo.photoData];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // Sincronizo vista -> modelo
    self.photo.photoData = UIImageJPEGRepresentation(self.photoView.image, 0.9);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender {
    
    // Creamos un UIImagePickerController
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // Lo configuro
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // Uso la camara
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        // Tiro del carrete
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    // Lo muestro de forma modal
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         // Esto se va a ejecutar cuando termine la animación que muestra al Picker.
                     }];

}

- (IBAction)deletePhoto:(id)sender {
    
    // La eliminamos del modelo
    self.photo.photoData = nil;
    
    CGRect oldRect = self.photoView.bounds;
    [UIView animateWithDuration:0.7
                     animations:^{
                         self.photoView.alpha = 0;
                         self.photoView.bounds = CGRectZero;
                         self.photoView.transform = CGAffineTransformMakeRotation(M_PI_2);
                         self.photoView.transform = CGAffineTransformMakeTranslation(self.trashButton.customView.center.x,                          self.trashButton.customView.center.y);
                         
                     } completion:^(BOOL finished) {
                         self.photoView.alpha = 1;
                         self.photoView.bounds = oldRect;
                         self.photoView.image = [UIImage imageWithData:self.photo.photoData];
                         self.photoView.transform = CGAffineTransformIdentity;
                     }];
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // La guardo en el modelo
    self.photo.photoData = UIImageJPEGRepresentation(img, 0.9);
    
    // Quito de encima el controlador que estamos presentando
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 // Se ejecutará cuando se haya ocultado del todo
                             }];
}

@end
