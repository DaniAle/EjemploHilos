//
//  ViewController.m
//  EjemploHilos
//
//  Created by Daniela Velasquez on 26/06/13.
//  Copyright (c) 2013 Daniela Velasquez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


-(void)initThreads;

@property  (nonatomic,retain) NSInvocationOperation *hilo1;
@property  (nonatomic,retain) NSInvocationOperation *hilo2;
@end

@implementation ViewController

@synthesize labelHilo1;
@synthesize labelHilo2;
@synthesize hilo1;
@synthesize hilo2;
@synthesize activityIndicator;
@synthesize cancelButton;



- (void)viewDidLoad {
    
    [super viewDidLoad];
	
    [self initThreads];
    
}


/**
 Inicia los hilos
 */
-(void)initThreads{

    // Se crea un NSOperationQueue
    operationQueue = [NSOperationQueue new];
    
    // Crea un nuevo NSInvocationOperation.
    // Le indicamos la funcion que se ejecutara mientras el hilo corre
    hilo1 = [[NSInvocationOperation alloc] initWithTarget:self
                                                 selector:@selector(contadorHilo1)
                                                 object:nil];
    // Agregamos la operacion a la cola.
    [operationQueue addOperation:hilo1];
    
    
    // Crea un nuevo NSInvocationOperation con otro metodo de ejecucion
    hilo2 = [[NSInvocationOperation alloc] initWithTarget:self
                                           selector:@selector(contadorHilo2)
                                           object:nil];
    [operationQueue addOperation:hilo2];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/**
 Funcion que cambia el fondo de la pantalla a color naranja
 */
- (IBAction)fondoColor1{
    [self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0]];
}

/**
 Funcion que cambia el fondo de la pantalla a blanco
 */
- (IBAction)fondoColorBlanco {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

/**
 Funcion que cancela los hilos
 */
- (IBAction)cancelarHilos:(id)sender {
    
    cancelButton.hidden = YES;
    
    [operationQueue cancelAllOperations];
    
}

/**
 Metodo ejecutado con el primer hilo
 */
-(void)contadorHilo1{
    
    // Hacemos un gran ciclo y cada 10 repeticiones actualizamos el labelHilo1 con el valor del contador.
    for (int i=0; i<50 && ![hilo1 isCancelled] ; i++) {
        if (i % 10 == 0) {
           // Cambiamos el texto del labelHilo1 cada 10 vueltas
            [labelHilo1 performSelectorOnMainThread:@selector(setText:)
                                     withObject:[NSString stringWithFormat:@"%d", i]
                                  waitUntilDone:YES];
        }
        
        //Se duerme el hilo un momento para que pueda visualizar el cambio
        [NSThread sleepForTimeInterval:0.2];

        
    }
    
    
    if([hilo1 isCancelled]){
        // Cuando el ciclo se cancela se muestra el mensaje
        [labelHilo1 performSelectorOnMainThread:@selector(setText:) withObject:@"Hilo #1 cancelado." waitUntilDone:NO];
    }
    // Cuando el ciclo termina se muestra el mensaje
    else
        [labelHilo1 performSelectorOnMainThread:@selector(setText:) withObject:@"Hilo #1 termino." waitUntilDone:NO];
}

/**
 Metodo ejecutado con el segundo hilo
 */
- (void)contadorHilo2{
    
    
    [activityIndicator startAnimating];
    
    // Run a loop with 500 repeats.
    for (int i=0; i<50 && ![hilo2 isCancelled]; i++) {
        
        // Cambiamos el texto del labelHilo2        
        [labelHilo2 performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%d", i] waitUntilDone:YES];
        
        //Se duerme el hilo un momento para que pueda visualizar el cambio
        [NSThread sleepForTimeInterval:0.2];
        
    }
    
   
    [activityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
    
    [cancelButton performSelectorOnMainThread:@selector(setHidden:) withObject:@"YES" waitUntilDone:NO];
    
           
    if([hilo2 isCancelled]){
         // Cuando el ciclo se cancela se muestra el mensaje
        [labelHilo2 performSelectorOnMainThread:@selector(setText:) withObject:@"Hilo #2 cancelado." waitUntilDone:NO];
    }
    //Mostramos mensaje de que el ciclo finalizo
    else
        [labelHilo2 performSelectorOnMainThread:@selector(setText:) withObject:@"Hilo #2 termino." waitUntilDone:NO];
    
    
  }


@end
