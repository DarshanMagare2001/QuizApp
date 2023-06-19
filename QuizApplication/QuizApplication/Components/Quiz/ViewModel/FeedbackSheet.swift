//
//  FeedbackSheet.swift
//  QuizApplication
//
//  Created by IPS-161 on 19/06/23.
//

import Foundation
import SwiftUI

struct FeedbackSheet: View {
    @Environment(\.presentationMode) var presentationMode
    var score: Int
    var totalQuestions: Int
    
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
            
            VStack {
                
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
                
                Button(action: {
                    // Dismiss the feedback sheet and go back
                    dismissSheet()
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
}




struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}

struct CircularProgressBar: View {
    var score: Int
    var totalQuestions: Int
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 10)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(Color.blue, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0))
                
                Text("\(score)/\(totalQuestions)")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(width: 100, height: 100)
        }
        .onAppear {
            let progressValue = CGFloat(score) / CGFloat(totalQuestions)
            withAnimation {
                progress = progressValue
            }
        }
    }
}

