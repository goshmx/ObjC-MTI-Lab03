//
//  MostrarForm.h
//  Agenda
//
//  Created by TRON on 03/02/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface MostrarForm : UIViewController
//Buttons
- (IBAction)btnRegresar:(id)sender;

//Propiedades
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIImageView *foto;
@property (strong, nonatomic) IBOutlet UILabel *nombre;
@property (strong, nonatomic) IBOutlet UILabel *estado;

@end
