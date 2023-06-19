import SwiftUI

struct FeedbackSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: QuizModelClass
    var score: Int
    var totalQuestions: Int
    
    // UserDefaults keys
    let scoreKey = "QuizScore"
    let highestScoreKey = "HighestQuizScore"
    
    @State private var highestScore: Int = 0 // Track the highest score
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack {
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
                    
                    Spacer()
                    
                    VStack {
                        Text("Leaderboard")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
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
                }
                .padding()
            }
          
        }
        .foregroundColor(.yellow)
        .onAppear {
            // Load the highest score from UserDefaults
            highestScore = UserDefaults.standard.integer(forKey: highestScoreKey)
            
            // Update the highest score if the current score is higher
            if score > highestScore {
                // Remove the previous highest score from UserDefaults
                UserDefaults.standard.removeObject(forKey: highestScoreKey)
                
                highestScore = score
                UserDefaults.standard.set(highestScore, forKey: highestScoreKey)
            }
        }
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
}



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

