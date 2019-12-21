//
//  RowView.swift
//  P5_SwiftUI
//
//  Created by vicgb on 19/12/2019.
//  Copyright © 2019 UPM. All rights reserved.
//

import SwiftUI

struct RowView: View{
    
    var quizItem: QuizItem
    
    @EnvironmentObject var descargaimagen: DescargaImagen
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View{
        
        HStack{
            if horizontalSizeClass != .compact{
                VStack(alignment: .leading){
                    Image(uiImage: self.descargaimagen.image(url: quizItem.attachment?.url))
                        .resizable()
                        .frame( width: 100, height: 100)
                        .scaledToFill()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .shadow(radius: 10)
                        .padding(.trailing)
                    
                    HStack(alignment: .top){
                        Image(quizItem.favourite ? "star_yellow" : "grey_star")
                            .resizable()
                            .frame( width: 40, height: 40)
                            .padding(.trailing)
                    }
                }
                
                Text(quizItem.question)
                    .padding()
                
                
            }else{
                HStack{
                    VStack{
                        Image(uiImage: self.descargaimagen.image(url: quizItem.attachment?.url))
                            .resizable()
                            .frame( width: 100, height: 100)
                            .scaledToFill()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            .shadow(radius: 10)
                            .padding(.trailing)
                        
                        
                        Image(quizItem.favourite ? "star_yellow" : "grey_star")
                            .resizable()
                            .frame( width: 40, height: 40)
                            .padding(.trailing)
                    }
                    
                    Text(quizItem.question)
                        .padding()
                }
                
                
                
                
            }
            
        }
        
    }
}

