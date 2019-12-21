//
//  DetallesView.swift
//  P5_SwiftUI
//
//  Created by G903 on 19/12/2019.
//  Copyright © 2019 UPM. All rights reserved.
//

import SwiftUI

struct DetallesView: View{
    
    var quizItem: QuizItem
    
    @EnvironmentObject var descargaimagen: DescargaImagen
    @EnvironmentObject var quizModel : Quiz_model
    
    
    @State var answer : String = ""
    
    @State private var showingAlert: Bool = false
    
    var body: some View{
        GeometryReader{ geometry in
            VStack{
                Text(self.quizItem.question)
                    .font(.largeTitle)
                
                Text(self.quizItem.author?.username ?? "Anónimo")
                    .padding()
                    .font(.body)
                VStack(alignment: .leading){
                    Text("Respuesta: ")
                        .font(.headline)
                    
                    
                    TextField("Escriba la respuesta: ",
                              text: self.$answer,
                              onEditingChanged: {b in },
                              onCommit: {
                                self.showingAlert = true
                                if self.quizItem.answer == self.answer{
                                    
                                }
                                
                                
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.body)
                        .alert(isPresented: self.$showingAlert){
                            Alert(title: Text("Resultado"),
                                  message: Text(self.quizItem.answer == self.answer ?  "Respuesta correcta": "Respuesta incorrecta"),
                                  dismissButton: .default(Text("Volver")))
                    }
                }
                .padding()
                
                ZStack(alignment: .bottomTrailing){
                    
                    Image(uiImage: self.descargaimagen.image(url: self.quizItem.attachment?.url))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame( width: geometry.size.width, height: 300)
                        .clipped()
                        .padding(.bottom)
                        .saturation(self.showingAlert ? 0.2 : 1)
                        .animation(.easeOut)
                    
                    Spacer()
                    
                    Button(action: {
                        self.quizModel.hacerFavoritos(self.quizItem)
                        
                    }) {
                        Image(self.quizItem.favourite ? "star_yellow" : "grey_star")
                            
                            .resizable()
                            .frame( width: 25, height: 25 )
                            .scaledToFill()
                            .offset(x: -25, y: -28)
                        
                    }
                        
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    
                    
                }
                
                
            }
            
        }
        
    }
}
