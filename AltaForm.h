//
//  AltaForm.h
//  Agenda
//
//  Created by TRON on 28/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface AltaForm : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

//Button
- (IBAction)AccionBtnRegresar:(id)sender;

//Inputs
@property (strong, nonatomic) IBOutlet UITextField *inputNombre;
@property (strong, nonatomic) IBOutlet UITextField *inputYoutube;
@property (strong, nonatomic) IBOutlet UITextField *inputEstado;

//ImageView
@property (strong, nonatomic) IBOutlet UIImageView *Imagen;

//TableView

//eventos
- (IBAction)actionFoto:(id)sender;
- (IBAction)guardarInfo:(id)sender;


@end
