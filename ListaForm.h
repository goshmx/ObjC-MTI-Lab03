//
//  EliminaForm.h
//  Agenda
//
//  Created by TRON on 28/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface ListaForm : UIViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

- (IBAction)AccionBtnRegresar:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblElimina;

@end
