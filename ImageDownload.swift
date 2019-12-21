//
//  ImagenControl.swift
//  p4_Quiz903
//
//  Created by G903 on 14/12/2019.
//  Copyright © 2019 UPM. All rights reserved.

import SwiftUI

class DescargaImagen: ObservableObject{
    
    
    @Published var imagenCache = [URL: UIImage]()
    
    let defaultImage = UIImage(named: "none")!
    // La funcion para descargar la foto de la url.
    
    
    func image(url: URL?) -> UIImage {
        
        guard let url = url else{
            return defaultImage
        }
        
        if let  img = imagenCache[url]{
            return img
            
        }
        self.imagenCache[url] = defaultImage
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
                let img = UIImage(data: data){
                // Importante para probar las veces que mandamos la peticion.
                print(url)
                // Para ejecutar un código dentro de una thread global, hay que meter el main.async
                DispatchQueue.main.async{
                    self.imagenCache[url] = img
                }
                
            }
        }
        // Como es asíncrono, en cuanto se ejecute (1) sacamos esto, hasta que se ejecute.
        return defaultImage
        
    }
    
}
