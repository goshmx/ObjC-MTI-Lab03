//
//  ViewController.m
//  Agenda
//
//  Created by TRON on 28/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import "Home.h"

NSString *idTemp;

@interface Home ()

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    idTemp = nil;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AccionBtnAlta:(id)sender {
    [self performSegueWithIdentifier:@"SagaHomeAlta" sender:self];
}

- (IBAction)AccionBtnBaja:(id)sender {
    [self performSegueWithIdentifier:@"SagaHomeEliminar" sender:self];
}

- (IBAction)AccionBtnEditar:(id)sender {
    [self performSegueWithIdentifier:@"SagaHomeEditar" sender:self];
}

- (IBAction)AccionBtnListado:(id)sender {
    [self performSegueWithIdentifier:@"SagaHomeListado" sender:self];
}
@end
