import SwiftUI
import Combine


struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: QuizModelClass
    @State var counter: Int = 0
    var countTo: Int = 30
    var quiz: [Quiz]
    @State var currentQuestionIndex = 0 // Track the current question index
    @State var selectedOption: Int?
    @State var isAnsweredCorrectly: Bool?
    @State var score = 0 // Track the score count
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Timer to track the counter
    @State var showFeedbackSheet = false
    @State var shuffledQuiz: [Quiz] // Shuffled array to store randomized questions

    init(quiz: [Quiz]) {
        self.quiz = quiz
        self._shuffledQuiz = State(initialValue: quiz.shuffled()) // Shuffle the quiz array
    }
  
    var body: some View {
        VStack {
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
                
                HStack{
                    
                    Spacer()
                    
                    VStack{
                        if let isAnsweredCorrectly = isAnsweredCorrectly, let selectedOption = selectedOption {
                            if isAnsweredCorrectly {
                                Text("Correct ans")
                                    .font(.caption)
                                    .padding(10)
                                    .background(.green)
                                    .cornerRadius(20)
                            } else {
                                Text("Wrong ans")
                                    .font(.caption)
                                    .padding(10)
                                    .background(.red)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    
                    Text("Score: \(score)")
                        .font(.title)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                    
                }.padding(5)
            }
            
            VStack(spacing: 5) {
                VStack(spacing: 15) {
                    HStack {
                        Spacer()
                        Circle()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 20)
                            .overlay {
                                ProgressTrackForCircularProgressbarForQuiz()
                                ProgressBarForCircularProgressbarForQuiz(counter: counter, countTo: countTo)
                                ClockForCircularProgressbarForQuiz(counter: counter, countTo: countTo)
                            }
                        
                        Spacer()
                    }
                    .frame(height: 80)
                    
                    HStack {
                        Spacer()
                        HorizontalProgressBar(currentQuestionIndex: currentQuestionIndex, totalQuestions: quiz.count)
                            .frame(height: 10)
                        Spacer()
                    }
                }
                
                HStack {
                    Text("Q. \(shuffledQuiz[currentQuestionIndex].questionTitle ?? "")")
                        .font(.headline)
                        .bold()
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                ForEach(0..<2) { rowIndex in
                    HStack(spacing: 15) {
                        ForEach(0..<2) { columnIndex in
                            let optionIndex = (rowIndex * 2) + columnIndex + 1
                            Button(action: {
                                selectedOption = optionIndex // Set the selected option
                                isAnsweredCorrectly = shuffledQuiz[currentQuestionIndex].getOption(for: optionIndex) == shuffledQuiz[currentQuestionIndex].correctAns
                                
                                if isAnsweredCorrectly == true {
                                    score += 1 // Increment the score if answered correctly
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    // After 1 second, move to the next question or show feedback sheet
                                    selectedOption = nil // Reset the selected option
                                    isAnsweredCorrectly = nil // Reset the answered correctly flag
                                    if currentQuestionIndex < shuffledQuiz.count - 1 {
                                        currentQuestionIndex += 1
                                        counter = 0 // Reset the timer when the question changes
                                    } else {
                                        // All questions finished, show feedback sheet
                                        showFeedbackSheet = true
                                        timer.upstream.connect().cancel() // Stop the timer
                                    }
                                }
                            }) {
                                HStack {
                                    Text("\(optionIndex))")
                                        .foregroundColor(.black)
                                    Text(shuffledQuiz[currentQuestionIndex].getOption(for: optionIndex))
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.black)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(5)
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
                }
            }
            .padding(.bottom, 5)
            .padding(.horizontal, 10)
            
            Spacer()
                .padding(.horizontal, 10)
                .navigationBarHidden(true)
        }
        .onChange(of: viewModel.dismiss, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
        .fullScreenCover(isPresented: $showFeedbackSheet) {
            FeedbackSheet(score: score, totalQuestions: shuffledQuiz.count)
        }
        .onReceive(timer) { time in
            if counter < countTo {
                counter += 1
            } else {
                // Timer finished for the current question
                if currentQuestionIndex < shuffledQuiz.count - 1 {
                    currentQuestionIndex += 1 // Move to the next question
                    counter = 0 // Reset the timer
                } else {
                    // All questions finished, show feedback sheet
                    showFeedbackSheet = true
                    timer.upstream.connect().cancel() // Stop the timer
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
            } else if optionIndex == shuffledQuiz[currentQuestionIndex].getCorrectOptionIndex() {
                return Color.green.opacity(0.4)
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
    
    func getCorrectOptionIndex() -> Int {
        if let correctAns = correctAns {
            switch correctAns {
            case option1:
                return 1
            case option2:
                return 2
            case option3:
                return 3
            case option4:
                return 4
            default:
                return 0
            }
        }
        return 0
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





