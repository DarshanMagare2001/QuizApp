import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var counter: Int = 0
    var countTo: Int = 30
    var quiz: [Quiz]
    @State var currentQuestionIndex = 0 // Track the current question index
    @State var selectedOption: Int?
    @State var isAnsweredCorrectly: Bool?

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
                        ForEach(1...4, id: \.self) { optionIndex in
                            Button(action: {
                                selectedOption = optionIndex // Set selected option
                                isAnsweredCorrectly = quiz[currentQuestionIndex].getOption(for: optionIndex) == quiz[currentQuestionIndex].correctAns // Compare selected option with correct answer
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    // After 2 seconds, move to the next question
                                    selectedOption = nil // Reset selected option
                                    isAnsweredCorrectly = nil // Reset answered correctly flag
                                    if currentQuestionIndex < quiz.count - 1 {
                                        currentQuestionIndex += 1
                                    }
                                }
                            }) {
                                Text(quiz[currentQuestionIndex].getOption(for: optionIndex))
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(getButtonColor(optionIndex: optionIndex))
                                    )
                            }
                            .disabled(selectedOption != nil) // Disable buttons once an option is selected
                        }
                    }
                }
            }
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
    
    private func getButtonColor(optionIndex: Int) -> Color {
        if let selectedOption = selectedOption, let isAnsweredCorrectly = isAnsweredCorrectly {
            if optionIndex == selectedOption {
                return isAnsweredCorrectly ? Color.green : Color.red
            }
        }
        return Color.clear
    }
}

extension Quiz {
    func getOption(for index: Int) -> String {
        switch index {
        case 1:
            return option1
        case 2:
            return option2
        case 3:
            return option3
        case 4:
            return option4
        default:
            return ""
        }
    }
}

