//
//  HomeView.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            BubbleView()
            VStack{
              
                HStack{
                    Spacer()
                    Text("Quiz")
                        .italic()
                        .font(.largeTitle)
                       .bold()
                       .padding(5)
                     Spacer()
                }.background(.white)
                    .cornerRadius(20)
                    .opacity(0.7)
                    .shadow(color: .white, radius: 10)
                    .padding(5)
                
                
              Spacer()
               
                 
            }
        }
     }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
