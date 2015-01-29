//
//  AltaForm.h
//  Agenda
//
//  Created by TRON on 28/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AltaForm : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//Button
- (IBAction)AccionBtnRegresar:(id)sender;

//Inputs
@property (strong, nonatomic) IBOutlet UITextField *inputNombre;
@property (strong, nonatomic) IBOutlet UITextField *inputYoutube;
@property (strong, nonatomic) IBOutlet UITextField *inputEstado;

//ImageView
@property (strong, nonatomic) IBOutlet UIImageView *Imagen;

//eventos
- (IBAction)actionFoto:(id)sender;


@end
