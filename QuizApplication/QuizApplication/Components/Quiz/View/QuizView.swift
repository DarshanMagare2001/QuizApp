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
    var quiz: [Quiz]
    @State var currentQuestionIndex = 0 // Track the current question index

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 25, height: 25)
                        .padding(5)
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Circle()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .overlay {
                        ProgressTrack()
                        ProgressBar(counter: counter, countTo: countTo)
                        Clock(counter: counter, countTo: countTo)
                    }
                Spacer()
            }.frame(height: 80)
            
            VStack {
                HStack {
                    Spacer()
                }
                ScrollView {
                    VStack {
                        Text("Q. \(quiz[currentQuestionIndex].questionTitle)") // Show the current question
                        // Show the options for the current question
                        Button(action: {
                            // Handle option 1 selection
                        }) {
                            Text(quiz[currentQuestionIndex].option1)
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(5)
                        }
                        
                        Button(action: {
                            // Handle option 2 selection
                        }) {
                            Text(quiz[currentQuestionIndex].option2)
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(5)
                        }
                        
                        Button(action: {
                            // Handle option 3 selection
                        }) {
                            Text(quiz[currentQuestionIndex].option3)
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(5)
                        }
                        
                        Button(action: {
                            // Handle option 4 selection
                        }) {
                            Text(quiz[currentQuestionIndex].option4)
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(5)
                        }
                    }
                }
            }.background(.red)
            .cornerRadius(20)
            .padding(.horizontal, 10)
            
            Spacer()
                .navigationBarHidden(true)
        }
        .onAppear {
            print(quiz)
        }
        .onReceive(timer) { time in
            if self.counter < self.countTo {
                self.counter += 1
            } else {
                // Timer finished for the current question
                if self.currentQuestionIndex < self.quiz.count - 1 {
                    self.currentQuestionIndex += 1 // Move to the next question
                    self.counter = 0 // Reset the timer
                } else {
                    // Quiz finished
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}


//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizView( quiz: [Quiz(questionTitle: <#T##String#>, option4: <#T##String#>)])
//            .environmentObject(QuizModelClass())
//    }
//}
