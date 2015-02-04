//
//  AltaForm.m
//  Agenda
//
//  Created by TRON on 28/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import "AltaForm.h"
#import <QuartzCore/QuartzCore.h>

UIAlertView *alert;
NSString *idTemp;

@interface AltaForm ()

@end

@implementation AltaForm

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer * l = [self.Imagen layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:85.0];
    
    self.inputNombre.delegate = self;
    self.inputEstado.delegate = self;
    self.inputYoutube.delegate = self;
    // Do any additional setup after loading the view.
    
    if(idTemp != nil){
        NSLog(idTemp);
        self.labelTitulo.text = @"Editar Registro";
        self.btnGuardar.hidden = YES;
        self.btnActualizar.hidden = NO;
        self.btnRegresarLista.hidden = NO;
        self.btnRegresarHome.hidden = YES;
        
        NSMutableArray *dato;
        dato = [[DBManager getSharedInstance]consultaDB:[NSString stringWithFormat: @"select agendaid, nombre, estado, youtube, foto FROM agenda WHERE agendaid=%@;", idSelect]];
        self.inputNombre.text = [dato objectAtIndex:1];
        self.inputEstado.text = [dato objectAtIndex:2];
        self.inputYoutube.text = [dato objectAtIndex:3];
        self.Imagen.image = [UIImage imageWithData:[dato objectAtIndex:4]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)AccionBtnRegresar:(id)sender {
    [self performSegueWithIdentifier:@"SagaAltaHome" sender:self];
}

- (IBAction)AccionBtnLista:(id)sender {
    [self performSegueWithIdentifier:@"sagaAltaLista" sender:self];
}
- (IBAction)actionFoto:(id)sender {
    alert = [[UIAlertView alloc] initWithTitle:@"Fotografia"
                                       message:@"Que desea hacer?"
                                      delegate:self
                             cancelButtonTitle:@"Cancelar"
                             otherButtonTitles:@"Camara", @"Carrete", nil];
    [alert show];
}

- (IBAction)guardarInfo:(id)sender {
    NSString *nombre = self.inputNombre.text;
    NSString *estado = self.inputEstado.text;
    NSString *youtube = self.inputYoutube.text;
    UIImage* image = [self.Imagen image];
    NSData *imageData=UIImagePNGRepresentation(image);
    NSLog(@"Las variables son: %@, %@, %@", nombre, estado, youtube);
    
    if([[DBManager getSharedInstance]insertaDB:nombre estado:estado youtube:youtube foto:imageData]){
    [self performSegueWithIdentifier:@"sagaAltaLista" sender:self];
    }
}

- (IBAction)actualizarInfo:(id)sender {
    NSString *nombre = self.inputNombre.text;
    NSString *estado = self.inputEstado.text;
    NSString *youtube = self.inputYoutube.text;
    UIImage* image = [self.Imagen image];
    NSData *imageData=UIImagePNGRepresentation(image);
    NSLog(@"Las variables son: %@, %@, %@", nombre, estado, youtube);
    
    if([[DBManager getSharedInstance]actualizaDB:nombre estado:estado youtube:youtube foto:imageData idagenda:idTemp]){
    [self performSegueWithIdentifier:@"sagaAltaLista" sender:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert buttons pressed");
    
    if(buttonIndex == 0)
    {
        NSLog(@"Cancelar");
    }
    else if(buttonIndex == 1)
    {
        NSLog(@"Camara");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else if(buttonIndex == 2)
    {
        NSLog(@"Carrete");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.Imagen.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int animatedDistance;
    int moveUpValue = textField.frame.origin.y+ textField.frame.size.height;
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        animatedDistance = 216-(460-moveUpValue-5);
    }
    else
    {
        animatedDistance = 162-(320-moveUpValue-5);
    }
    
    if(animatedDistance>0)
    {
        const int movementDistance = animatedDistance;
        const float movementDuration = 0.3f;
        int movement = (up ? -movementDistance : movementDistance);
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


@end
