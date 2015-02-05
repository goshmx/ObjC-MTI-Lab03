//
//  MostrarForm.m
//  Agenda
//
//  Created by TRON on 03/02/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import "MostrarForm.h"
#import <QuartzCore/QuartzCore.h>

NSString *idSelect;
NSMutableArray *dato;

@interface MostrarForm ()

@end

@implementation MostrarForm

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initController];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initController{
    
    dato = [[DBManager getSharedInstance]consultaDB:[NSString stringWithFormat: @"select agendaid, nombre, estado, youtube, foto FROM agenda WHERE agendaid=%@;", idSelect]];
    self.nombre.text = [dato objectAtIndex:1];
    self.estado.text = [dato objectAtIndex:2];
    self.foto.image = [UIImage imageWithData:[dato objectAtIndex:4]];
    CALayer * l = [self.foto layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:50.0];
    [l setBorderWidth:2.0];
    [l setBorderColor:[[UIColor redColor] CGColor]];
    NSURL *url = [NSURL URLWithString:[dato objectAtIndex:3]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnRegresar:(id)sender {
    [self performSegueWithIdentifier:@"sagaMostrarLista" sender:self];
}
@end
