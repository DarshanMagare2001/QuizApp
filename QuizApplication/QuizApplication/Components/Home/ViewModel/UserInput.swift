//
//  UserInput.swift
//  QuizApplication
//
//  Created by IPS-161 on 20/06/23.
//

import SwiftUI

struct Userinput: View {
    @Binding var isShowing: Bool
    @State private var username: String = ""
    
    @Binding var isDifficultyViewShow: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Custom Popup")
                    .font(.title)
                    .bold()
                    .padding()
                
                // Add your custom popup content here
                TextField("Enter username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    UserDefaults.standard.set(username, forKey: "Username")
                    isShowing = false
                    isDifficultyViewShow.toggle() // Toggle the state here
                }) {
                    Text("Save")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
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


