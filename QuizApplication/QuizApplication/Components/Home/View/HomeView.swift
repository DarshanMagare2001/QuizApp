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
                    .padding(10)
                Spacer()
                
                HStack{
                    Spacer()
                    Text("Lets Play!")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .italic()
                        .font(.largeTitle)
                        .bold()
                        .shadow(color: .red, radius: 20)
                    Spacer()
                }
                
                VStack{
                    Button{
                        
                    }label: {
                        
                        HStack{
                            Spacer()
                            Text("Play Now")
                                .foregroundColor(.white)
                                .font(.title)
                            Spacer()
                        }.padding()
                            .background(.blue)
                            .cornerRadius(20)
                        
                        
                        
                    }
                    
                    
                    Button{
                        
                    }label: {
                        HStack{
                            Spacer()
                            Text("Rules")
                                .foregroundColor(.white)
                                .font(.title)
                            Spacer()
                        }.padding()
                            .background(.blue)
                            .cornerRadius(20)
                    }
                }.padding(.horizontal,10)
                    .padding(.vertical , 5)
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
