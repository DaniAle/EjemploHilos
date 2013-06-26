//
//  ViewController.h
//  EjemploHilos
//
//  Created by Daniela Velasquez on 26/06/13.
//  Copyright (c) 2013 Daniela Velasquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    NSOperationQueue *operationQueue;
    
}

#pragma -mark Elementos de la interfaz 
@property (retain, nonatomic) IBOutlet UILabel *labelHilo1;
@property (retain, nonatomic) IBOutlet UILabel *labelHilo2;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

#pragma -mark Acciones
- (IBAction)fondoColor1;
- (IBAction)fondoColorBlanco;
- (IBAction)cancelarHilos:(id)sender;

#pragma -mark Metodos
-(void)contadorHilo1;
-(void)contadorHilo2;


@end
