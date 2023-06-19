//
//  DifficultyView.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

//This is difficulty show view
import SwiftUI
struct DifficultyView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: QuizModelClass
    @State private var isSpinning = false
    
    var body: some View {
        ZStack {
            BubbleView()
            VStack {
                Spacer()
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .padding(5)
                    }
                    Spacer()
                }
                
                VStack {
                    VStack {
                        VStack{
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Easy")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }.background(.green)
                        
                        HStack {
                            Spacer()
                            if let data = viewModel.quizModelArray {
                                NavigationLink(destination: QuizView(quiz: data[0].quiz)) {
                                    Text("Start Quiz!")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .bold()
                                        .padding(5)
                                }
                            }
                            Spacer()
                        }
                        .background(.purple)
                    }
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .shadow(color: .black, radius: 10)
                    
                    Spacer()
                    
                    VStack {
                        VStack{
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Normal")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }.background(.yellow)
                        
                        HStack {
                            Spacer()
                            if let data = viewModel.quizModelArray {
                                NavigationLink(destination: QuizView(quiz: data[1].quiz)) {
                                    Text("Start Quiz!")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .bold()
                                        .padding(5)
                                }
                            }
                            Spacer()
                        }
                        .background(.purple)
                    }
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .shadow(color: .black, radius: 10)
                    
                    Spacer()
                    
                    VStack {
                        VStack{
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Hard")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            
                            Spacer()
                        } .background(.red)
                        
                        HStack {
                            Spacer()
                            if let data = viewModel.quizModelArray {
                                NavigationLink(destination: QuizView(quiz: data[2].quiz)) {
                                    Text("Start Quiz!")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .bold()
                                        .padding(5)
                                }
                            }
                            Spacer()
                        }
                        .background(.purple)
                    }
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .shadow(color: .black, radius: 10)
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




