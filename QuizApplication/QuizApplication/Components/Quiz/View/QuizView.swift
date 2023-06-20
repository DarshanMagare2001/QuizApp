import SwiftUI
import Combine
import AVFoundation

// This is quiz view
struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: QuizModelClass
    @State var counter: Int = 0
    var countTo: Int = 20
    var quiz: [Quiz]
    @State var currentQuestionIndex = 0 // Track the current question index
    @State var selectedOption: Int?
    @State var isAnsweredCorrectly: Bool?
    @State var score = 0 // Track the score count
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Timer to track the counter
    @State var showFeedbackSheet = false
    @State var shuffledQuiz: [Quiz] // Shuffled array to store randomized questions
    
    // AVAudioPlayer to play the beep sound
    @State private var audioPlayer: AVAudioPlayer?
    
    init(quiz: [Quiz]) {
        self.quiz = quiz
        self._shuffledQuiz = State(initialValue: quiz.shuffled()) // Shuffle the quiz array
    }
    
    var body: some View {
        VStack{
            Spacer()
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 25, height: 25)
                    
                }
                
                Spacer()
                
            }
            
            VStack{
                HStack {
                    Spacer()
                    Circle()
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 20)
                        .overlay {
                            ProgressTrackForCircularProgressbarForQuiz()
                            ProgressBarForCircularProgressbarForQuiz(counter: counter, countTo: countTo)
                            ClockForCircularProgressbarForQuiz(counter: counter, countTo: countTo)
                        }
                    
                    Spacer()
                }
                .frame(minHeight:40 ,maxHeight:100)
                
                HStack {
                    Spacer()
                    Text("Score: \(score)")
                        .font(.headline)
                        .bold()
                    VStack{
                        
                        if let isAnsweredCorrectly = isAnsweredCorrectly, let selectedOption = selectedOption {
                            if isAnsweredCorrectly {
                                HStack{
                                    Text("Correct ans")
                                        .font(.headline)
                                        .foregroundColor(.green)
                                }
                                
                            } else {
                                HStack{
                                    Text("Wrong ans")
                                        .font(.headline)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    HorizontalProgressBar(currentQuestionIndex: currentQuestionIndex, totalQuestions: quiz.count)
                        .frame(maxHeight:5)
                        .cornerRadius(10)
                    Spacer()
                }
                
                HStack {
                    Text("Q. \(shuffledQuiz[currentQuestionIndex].questionTitle ?? "")")
                        .font(.title3)
                        .bold()
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                
            }
            Spacer()
            VStack{
                ForEach(1...4, id: \.self) { optionIndex in
                    Button(action: {
                        checkAnswer(optionIndex: optionIndex)
                    }) {
                        VStack{
                            Spacer()
                            HStack {
                                Spacer()
                                Text(shuffledQuiz[currentQuestionIndex].getOption(for: optionIndex))
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .bold()
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                            Spacer()
                        }.background(getButtonColor(optionIndex: optionIndex))
                            .opacity(getButtonOpacity(optionIndex: optionIndex))
                            .background(Color(.systemGray5))
                            .cornerRadius(20)
                            .shadow(color: .black, radius: 20)
                    }
                    .disabled(selectedOption != nil) // Disable the button if an option is already selected
                    Spacer()
                }
            }
            
            .navigationBarHidden(true)
            
        }.onChange(of: isAnsweredCorrectly) { _ in
            if isAnsweredCorrectly == false {
                playBeepSound() // Play beep sound for wrong answer
            }
        }
        .padding(.horizontal , 10)
        .padding(.top,5)
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
                    selectedOption = nil // Reset the selected option
                    isAnsweredCorrectly = nil // Reset the correctness indicator
                } else {
                    // All questions finished, show feedback sheet
                    showFeedbackSheet = true
                    timer.upstream.connect().cancel() // Stop the timer
                }
            }
        }
    }
    // Function to beep sound
    
    private func playBeepSound() {
        guard let soundURL = Bundle.main.url(forResource: "beep", withExtension: "mp3") else {
            print("Failed to locate beep sound file")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Failed to play beep sound: \(error.localizedDescription)")
        }
    }
    
    // Function to check the selected answer
    // Function to check the selected answer
    private func checkAnswer(optionIndex: Int) {
        selectedOption = optionIndex
        let correctOptionIndex = shuffledQuiz[currentQuestionIndex].getCorrectOptionIndex()
        isAnsweredCorrectly = (optionIndex == correctOptionIndex)
        if isAnsweredCorrectly == true {
            score += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if currentQuestionIndex < shuffledQuiz.count - 1 {
                currentQuestionIndex += 1 // Move to the next question
                counter = 0 // Reset the timer
                selectedOption = nil // Reset the selected option
                isAnsweredCorrectly = nil // Reset the correctness indicator
            } else {
                // All questions finished, show feedback sheet
                showFeedbackSheet = true
                timer.upstream.connect().cancel() // Stop the timer
            }
        }
    }
    
    
    // This function gets the button color based on the selected option and correctness
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
    
    // This function gets the button opacity based on the selected option
    private func getButtonOpacity(optionIndex: Int) -> Double {
        if selectedOption != nil && optionIndex != selectedOption {
            return 0.8
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
        ZStack {
            color
            content
        }
    }
}

extension View {
    func conditionalBackgroundColor(_ condition: Bool, color: Color) -> some View {
        modifier(ConditionalBackgroundColorModifier(color: condition ? color : .clear))
    }
}


struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let quizData = [
            Quiz(questionTitle: "Question 1", option1: "Option 1", option2: "Option 2", option3: "Option 3", option4: "Option 4", correctAns: "Option 1"),
            Quiz(questionTitle: "Question 2", option1: "Option 1", option2: "Option 2", option3: "Option 3", option4: "Option 4", correctAns: "Option 2"),
            Quiz(questionTitle: "Question 3", option1: "Option 1", option2: "Option 2", option3: "Option 3", option4: "Option 4", correctAns: "Option 3")
        ]
        
        return QuizView(quiz: quizData)
            .environmentObject(QuizModelClass())
    }
}

