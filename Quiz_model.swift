//
//  Quiz_model.swift
//  P5_SwiftUI
//
//  Created by vicgb on 19/12/2019.
//  Copyright © 2019 UPM. All rights reserved.
//

import SwiftUI

let session = URLSession.shared

struct QuizItem: Codable, Identifiable{
    var id: Int
    let question: String
    let answer: String
    let author: Author?
    let attachment: Attachment?
    var favourite: Bool
    let tips: [String]
    
    struct Author: Codable{
        let isAdmin: Bool?
        let username: String
        let photo: Attachment?
        
        
    }
    
    struct Attachment: Codable{
        let filename: String
        let mime: String
        let url: URL?
    }
}

class Quiz_model: ObservableObject{
    
    static let TOKEN = "021f2a6435874ececfbd"
    
    @Published var quizzes =  [QuizItem]()
    
    func descargaJSON(){
        
        let stringurl = "https://quiz.dit.upm.es/api/quizzes/random10wa?token=021f2a6435874ececfbd"
        
        guard let url = URL(string: stringurl) else {
            print ("Hay un error en la URL")
            return
        }
        print("Iniciando descarga")
        
        //Para descargar de manera asíncrona
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                let quizzes = try decoder.decode([QuizItem].self, from: data)
                
                DispatchQueue.main.async {
                    self.quizzes = quizzes
                    print("Se ha descargado con éxito")
                }
                
            }catch{
                DispatchQueue.main.async{
                    print("Algo ha fallado en la descarga.")
                }
            }
        }
    }
    
    func hacerFavoritos(_ quizItem: QuizItem){
        
        guard let index = quizzes.firstIndex(where: {$0.id == quizItem.id}) else{
            print("Algo no ha ido bien. No existe quiz con ese id")
            return
        }
        
        let stringurl = "https://quiz.dit.upm.es/api/users/tokenOwner/favourites/\(quizItem.id)?token=021f2a6435874ececfbd"
        
        guard let url = URL(string: stringurl) else{
            print("URL Incorrecto")
            return
        }
        
        //Lanzamos peticion HTTP
        var request = URLRequest(url:url)
        request.httpMethod = quizItem.favourite ? "DELETE" : "PUT"
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        //La tarea para (des)activar el favorito
        let task = session.uploadTask(with: request, from: Data()){
            (data : Data?, res: URLResponse?, error: Error?) in
            
            if error != nil{
                print("Error en el proceso")
                return
            }
            
            let code = (res as! HTTPURLResponse).statusCode
            if code != 200 {
                print("Error 4")
                HTTPURLResponse.localizedString(forStatusCode: code)
                return
            }
            print("Se ha actualizado el favorito")
            DispatchQueue.main.async{
                self.quizzes[index].favourite.toggle()
            }
            
            
        }
        //Reanudar la tarea
        task.resume()
    }
}
