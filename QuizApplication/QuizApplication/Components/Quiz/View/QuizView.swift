//
//  QuizView.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var counter: Int = 0
    var countTo: Int = 30
    var body: some View {
        
        VStack(spacing:20){
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
            
            HStack{
                Spacer()
                Circle()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .overlay{
                        ProgressTrack()
                        ProgressBar(counter: counter, countTo: countTo)
                        Clock(counter: counter, countTo: countTo)
                    }
                
                Spacer()
            }.frame(height:80)
            
            VStack{
                HStack{
                    Spacer()
                }
                ScrollView{
                    Text("Darshan")
                }
            }.background(.red)
                .cornerRadius(20)
                .padding(.horizontal , 10)
            
            
            Spacer()
                .navigationBarHidden(true)
        }.onReceive(timer) { time in
            if (self.counter < self.countTo) {
                self.counter += 1
            }
        }
        
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(QuizModelClass())
    }
}
