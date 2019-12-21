//
//  ContentView.swift
//  P5_SwiftUI
//
//  Created by vicgb on 19/12/2019.
//  Copyright © 2019 UPM. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var quizModel: Quiz_model
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(quizModel.quizzes, id: \.id){ quizItem in
                    NavigationLink(destination:
                    DetallesView(quizItem: quizItem)){
                        RowView(quizItem: quizItem)
                        
                    }
                }
            }
            .navigationBarTitle(Text("P5Quiz. G903"))
            .navigationBarItems(trailing: Button(action: {self.quizModel.descargaJSON()}, label: {
                Image(systemName: "arrow.clockwise")}))
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
