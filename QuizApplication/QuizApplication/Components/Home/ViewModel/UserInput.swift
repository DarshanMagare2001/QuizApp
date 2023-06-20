//
//  UserInput.swift
//  QuizApplication
//
//  Created by IPS-161 on 20/06/23.
//

//This is Userinput popup
import SwiftUI

struct Userinput: View {
    @Binding var isShowing: Bool
    @State private var username: String = ""
    
    @Binding var isDifficultyViewShow: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            VStack {
               
                Text("Enter name")
                    .font(.title)
                    .bold()
                    .padding()
                
                // Add your custom popup content here
                TextField("Enter username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                VStack {
                    Button(action: {
                        isShowing = false // Cancel button action
                    }) {
                        HStack{
                            Spacer()
                            Text("Cancel")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                
                            Spacer()
                        }.background(Color.red)
                            .cornerRadius(20)
                            .opacity(0.7)
                            .shadow(color: .white, radius: 10)
                    }
                      
                    Button(action: {
                        UserDefaults.standard.set(username, forKey: "Username")
                        isShowing = false
                        isDifficultyViewShow.toggle() // Toggle the state here
                    }) {
                        HStack{
                            Spacer()
                            Text("Save")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                
                            Spacer()
                        }.background(Color.green)
                            .cornerRadius(20)
                            .opacity(username.isEmpty ? 0.5 : 0.7) // Adjust the opacity based on the condition
                            .shadow(color: .white, radius: 10)
                    }
                    .disabled(username.isEmpty) // Disable the button if the username is empty
                   
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




