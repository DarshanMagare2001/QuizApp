//
//  UserInput.swift
//  QuizApplication
//
//  Created by IPS-161 on 20/06/23.
//

import SwiftUI
struct Userinput: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Custom Popup")
                    .font(.title)
                    .bold()
                    .padding()
                
                // Add your custom popup content here
                
                Button(action: {
                    isShowing = false
                }) {
                    Text("Close")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(20)
                        .opacity(0.7)
                        .shadow(color: .white, radius: 10)
                }
                .padding(.top, 20)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .opacity(0.9)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
