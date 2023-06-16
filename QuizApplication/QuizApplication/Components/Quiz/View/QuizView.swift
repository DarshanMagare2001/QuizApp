import SwiftUI
import Combine

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var counter: Int = 0
    var countTo: Int = 30
    var quiz: [Quiz]
    @State var currentQuestionIndex = 0 // Track the current question index
    @State var selectedOption: Int?
    @State var isAnsweredCorrectly: Bool?
    @State var score = 0 // Track the score count
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Timer to track the counter
    
    var body: some View {
        VStack(spacing: 15) {
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
                
                Text("Score: \(score)") // Display the score
                
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
            
            VStack(alignment:.leading){
                HStack {
                    Text("Q. \(quiz[currentQuestionIndex].questionTitle ?? "")") // Show the current question
                    Spacer()
                }
        
                VStack(alignment: .leading) {
                    ForEach(0..<2) { rowIndex in
                        HStack(spacing: 15) {
                            ForEach(0..<2) { columnIndex in
                                let optionIndex = (rowIndex * 2) + columnIndex + 1
                                Button(action: {
                                    selectedOption = optionIndex // Set the selected option
                                    isAnsweredCorrectly = quiz[currentQuestionIndex].getOption(for: optionIndex) == quiz[currentQuestionIndex].correctAns
                                    
                                    if isAnsweredCorrectly == true {
                                        score += 1 // Increment the score if answered correctly
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        // After 1 second, move to the next question
                                        selectedOption = nil // Reset the selected option
                                        isAnsweredCorrectly = nil // Reset the answered correctly flag
                                        if currentQuestionIndex < quiz.count - 1 {
                                            currentQuestionIndex += 1
                                            counter = 0 // Reset the timer when the question changes
                                        }
                                    }
                                }) {
                                    HStack{
                                        Text("\(optionIndex))")
                                            .foregroundColor(.black)
                                        Text(quiz[currentQuestionIndex].getOption(for: optionIndex))
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding(5)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(getButtonColor(optionIndex: optionIndex))
                                                    .opacity(getButtonOpacity(optionIndex: optionIndex))
                                            )
                                            .modifier(ConditionalBackgroundColorModifier(color: getButtonColor(optionIndex: optionIndex)))
                                        Spacer()
                                    }
                                }
                                .disabled(selectedOption != nil)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                    }
                }
            }
            .padding(.horizontal, 10)
            
            Spacer().navigationBarHidden(true)
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
        if let isAnsweredCorrectly = isAnsweredCorrectly {
            if optionIndex == selectedOption {
                if isAnsweredCorrectly {
                    return Color.green
                } else {
                    return Color.red
                }
            }
        }
        
        return Color.clear
    }

  
    private func getButtonOpacity(optionIndex: Int) -> Double {
        if selectedOption != nil && optionIndex != selectedOption {
            return 0.4
        }
        return 1.0
    }
}


extension Quiz {
    func getOption(for index: Int) -> String {
        switch index {
        case 1:
            return option1?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        case 2:
            return option2?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        case 3:
            return option3?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        case 4:
            return option4?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        default:
            return ""
        }
    }

    
    func getCorrectOptionIndex() -> Int? {
        if let correctAnswer = correctAns {
            switch correctAnswer {
            case option1:
                return 1
            case option2:
                return 2
            case option3:
                return 3
            case option4:
                return 4
            default:
                return nil
            }
        }
        return nil
    }
}

struct ConditionalBackgroundColorModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color.opacity(color == Color.clear ? 0 : 1))
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let quizData = [
            Quiz(questionTitle: "Question 1", option1: "Option 1", option2: "Option 2", option3: "Option 3", option4: "Option 4", correctAns: "Option 1"),
            Quiz(questionTitle: "Question 2", option1: "Option 1", option2: "Option 2", option3: "Option 3", option4: "Option 4", correctAns: "Option 3"),
            Quiz(questionTitle: "Question 3", option1: "Option 1", option2: "Option 2", option3: "Option 3", option4: "Option 4", correctAns: "Option 4")
        ]
        
        return QuizView(quiz: quizData)
    }
}

