//
//  EliminaForm.m
//  Agenda
//
//  Created by TRON on 28/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import "ListaForm.h"
#import "PersonaList.h"

NSMutableArray *datos;
NSString *idTemp;
NSString *idSelect;

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
    return cell;
}


//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *dato = datos[indexPath.row];
    
    NSString *nombreTemp;
    
    idSelect = [dato objectAtIndex:0];
    NSLog(idSelect);
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
        if([[DBManager getSharedInstance]saveDB:query]){
            [self initController];
            self.tblElimina.reloadData;
        }
    }
    else if(buttonIndex == 4){
        [self performSegueWithIdentifier:@"sagaListaMostrar" sender:self];
    }
   
}






@end
