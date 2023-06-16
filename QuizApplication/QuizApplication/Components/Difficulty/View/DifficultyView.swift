//
//  DifficultyView.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

import SwiftUI

struct DifficultyView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            BubbleView()
            VStack{
                 HStack{
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .padding(5)
                    }
                    Spacer()
                }
                
                Spacer()
                
                VStack{
                    VStack{
                        HStack{
                            Spacer()
                            Text("Easy")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Spacer()
                        }.background(.blue)
                        
                        HStack{
                            Spacer()
                            Button{
                                
                            }label: {
                                Text("Start Quiz!")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                            }
                            Spacer()
                            
                        }.background(.green)
                        
                    }.cornerRadius(20)
                        .padding(.horizontal , 20)
                    
                    Spacer()
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text("Normal")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Spacer()
                        }.background(.blue)
                        
                        HStack{
                            Spacer()
                            Button{
                                
                            }label: {
                                Text("Start Quiz!")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                            }
                            Spacer()
                            
                        }.background(.green)
                        
                    }.cornerRadius(20)
                        .padding(.horizontal , 20)

                    Spacer()
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text("Hard")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Spacer()
                        }.background(.blue)
                        
                        HStack{
                            Spacer()
                            Button{
                                
                            }label: {
                                Text("Start Quiz!")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                            }
                            Spacer()
                            
                        }.background(.green)
                        
                    }.cornerRadius(20)
                        .padding(.horizontal , 20)
                    
                    
                    
                    
                    

                }
                 Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyView()
    }
}
