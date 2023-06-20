import SwiftUI
//Feedback sheet
struct FeedbackSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: QuizModelClass
    var score: Int
    var totalQuestions: Int
    
    // UserDefaults keys
    let scoreKey = "QuizScore"
    let highestScoreKey = "HighestQuizScore"
    
    @State private var highestScore: Int = 0 // Track the highest score
    @State private var username: String = ""
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack{
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: -100, y: -50)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: 60, y: 70)
            }
            
            ScrollView{
                VStack(spacing:20) {
                    VStack(spacing:20){
                        Spacer()
                        
                        Text("Quiz Finished")
                            .font(.title)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        VStack {
                            CircularProgressBar(score: score, totalQuestions: totalQuestions)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text(feedbackMessage(score: score))
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Leaderboard")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        if !username.isEmpty {
                            Text(username)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        
                        Text("Highest Score: \(highestScore)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Dismiss the feedback sheet and go back
                        dismissSheet()
                        viewModel.dismiss.toggle()
                    }) {
                        Text("Close")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Tips for Improvement")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        Text(tipsForImprovement(score: score))
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                // Load the highest score from UserDefaults
                highestScore = UserDefaults.standard.integer(forKey: highestScoreKey)
                
                // Load the username from UserDefaults
                if let storedUsername = UserDefaults.standard.string(forKey: "Username") {
                    username = storedUsername
                }
                
                // Update the highest score if the current score is higher
                if score > highestScore {
                    // Remove the previous highest score from UserDefaults
                    UserDefaults.standard.removeObject(forKey: highestScoreKey)
                    
                    highestScore = score
                    UserDefaults.standard.set(highestScore, forKey: highestScoreKey)
                }
            }
        }
        .foregroundColor(.yellow)
    }
    
    private func dismissSheet() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func feedbackMessage(score: Int) -> String {
        switch score {
        case 0..<5:
            return "Keep practicing! You can do better."
        case 5..<8:
            return "Good job! You're getting there."
        case 8..<10:
            return "Great work! You're almost a pro."
        case 10:
            return "Perfect score! You're a Quiz Master!"
        default:
            return ""
        }
    }
    
    private func tipsForImprovement(score: Int) -> String {
        switch score {
        case 0..<5:
            return "Here are some tips to improve your score:\n\n1. Study the quiz topics in more detail.\n2. Review the questions you answered incorrectly.\n3. Take more practice quizzes to reinforce your knowledge."
        case 5..<8:
            return "You're doing well! To further improve:\n\n1. Focus on the topics where you scored lower.\n2. Analyze the questions you answered incorrectly.\n3. Keep practicing and aim for a higher score next time."
        case 8..<10:
            return "Great job! You're almost there:\n\n1. Review the questions you answered incorrectly.\n2. Dive deeper into the quiz topics for a better understanding.\n3. Keep practicing and aim for a perfect score."
        case 10:
            return "Congratulations on a perfect score!\n\n1. Share your achievement with others.\n2. Challenge yourself with more advanced quizzes.\n3. Continue expanding your knowledge in the subject."
        default:
            return ""
        }
    }
    
}

struct FeedbackSheet_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackSheet(score: 8, totalQuestions: 10)
            .environmentObject(QuizModelClass())
    }
}



//Fireworks animation

struct FireworkParticlesGeometryEffect: GeometryEffect {
    var time: Double
    var speed = Double.random(in: 20...200)
    var direction = Double.random(in: -Double.pi...Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation = CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct ParticlesModifier: ViewModifier {
    @State private var time = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    func body(content: Content) -> some View {
        content
            .onReceive(timer) { _ in
                time += 0.1
            }
            .modifier(FireworkParticlesGeometryEffect(time: time))
    }
}

// This is circular progrssbar for feedbackView

struct CircularProgressBar: View {
    var score: Int
    var totalQuestions: Int
    
    private var progress: Double {
        return Double(score) / Double(totalQuestions)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15)
                .opacity(0.3)
                .foregroundColor(Color.white)
            
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear)
            
            Text("\(score)/\(totalQuestions)")
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(width: 150, height: 150)
    }
}

