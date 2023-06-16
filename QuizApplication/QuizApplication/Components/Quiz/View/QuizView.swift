//
//  QuizView.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        VStack{
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 25, height: 25)
                        .padding(5)
                }
                Spacer()
            }
            
            
            
            
            Spacer()
                .navigationBarHidden(true)
        }
        
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(QuizModelClass())
    }
}
