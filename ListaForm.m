//
//  EliminaForm.m
//  Agenda
//
//  Created by TRON on 28/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import "ListaForm.h"
#import "PersonaList.h"
#import <QuartzCore/QuartzCore.h>

NSMutableArray *datos;
NSString *idTemp;
NSString *idSelect;
int indice;

@interface ListaForm ()

@end

@implementation ListaForm

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initController{
    
    datos = [[DBManager getSharedInstance]listDB:@"select agendaid, nombre, estado, youtube, foto from agenda"];
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
    [self performSegueWithIdentifier:@"SagaEliminarHome" sender:self];
}








/**********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datos count];
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
//-------------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PersonaList";
    PersonaList *cell = (PersonaList *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[PersonaList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray *dato = datos[indexPath.row];
    cell.nombre.text = [dato objectAtIndex:1];
    cell.estado.text = [dato objectAtIndex:2];
    cell.foto.image = [UIImage imageWithData:[dato objectAtIndex:4]];
    CALayer * l = [cell.foto layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:30.0];
    return cell;
}


//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *dato = datos[indexPath.row];
    indice = indexPath.row;
    
    NSString *nombreTemp;
    
    idSelect = [dato objectAtIndex:0];
    idTemp = [dato objectAtIndex:0];
    nombreTemp = [[dato objectAtIndex:1] stringByAppendingString: @" fué seleccionado"];
    
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Seleccione accion"
                                                        message:nombreTemp
                                                       delegate:self
                                              cancelButtonTitle:@"Cancelar"
                                              otherButtonTitles:@"Eliminar",@"Editar",@"Compartir",@"Ver mas", nil];
        [alert show];
    
    
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
        NSLog(@"Borrar");
        NSString *query = [NSString stringWithFormat: @"DELETE FROM agenda WHERE agendaid=%@;", idTemp];
        NSLog(query);
        if([[DBManager getSharedInstance]saveDB:query]){
            [self initController];
            self.tblElimina.reloadData;
        }
    }
    else if(buttonIndex == 2){
        [self performSegueWithIdentifier:@"sagaListaAlta" sender:self];
    }
    else if(buttonIndex == 3){
        NSMutableArray *dato = datos[indice];
        
        NSString                    *strMsg;
        NSArray                     *activityItems;
        UIImage                     *imgShare;
        UIActivityViewController    *actVC;
        
        imgShare =  [UIImage imageWithData:[dato objectAtIndex:4]];
        strMsg = [NSString stringWithFormat: @"Comparti un contacto, se llama %@ y su estado es: %@", [dato objectAtIndex:1], [dato objectAtIndex:2]];
        
        activityItems = @[imgShare, strMsg];
        
        //Init activity view controller
        actVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        actVC.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeAirDrop, nil];
        
        [self presentViewController:actVC animated:YES completion:nil];
    }
    else if(buttonIndex == 4){
        [self performSegueWithIdentifier:@"sagaListaMostrar" sender:self];
    }
   
}






@end
