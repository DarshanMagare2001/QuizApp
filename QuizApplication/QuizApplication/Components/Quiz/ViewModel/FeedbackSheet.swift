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
                          .offset(x: -100, y : -50)
                      
                      Circle()
                          .fill(Color.red)
                          .frame(width: 12, height: 12)
                          .modifier(ParticlesModifier())
                          .offset(x: 60, y : 70)
                  }
            
            
            VStack {
                VStack{
                    Text("Quiz Finished")
                        .font(.title)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    Text("Score: \(score)/\(totalQuestions)")
                        .font(.headline)
                    
                    Spacer()
                }
              
                
                Spacer()
                
                Text("Suggestions for Improvement:")
                    .font(.headline)
                    .padding(.bottom, 10)
                
                Text("1. Provide more challenging questions.")
                    .padding(.bottom, 5)
                Text("2. Include explanations for correct answers.")
                    .padding(.bottom, 5)
                Text("3. Add a timer for each question.")
                    .padding(.bottom, 5)
                
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
