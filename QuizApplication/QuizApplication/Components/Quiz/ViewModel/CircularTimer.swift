//
//  CircularTimer.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

//Circular timer for quiz
import Foundation
import SwiftUI

let timerForCircularProgressbarForQuiz = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

struct ClockForCircularProgressbarForQuiz: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        VStack {
            Text(counterToMinutes())
               
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

//Circular progressbar
struct ProgressTrackForCircularProgressbarForQuiz: View {
    var body: some View {
        Circle()
            .fill(Color.clear)
             .overlay(
                Circle().stroke(Color.black)
            )
    }
}

struct ProgressBarForCircularProgressbarForQuiz: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Circle()
            .fill(Color.clear)
          
            .overlay(
                Circle().trim(from: 0, to: progress())
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round,
                            lineJoin: .round
                        )
                )
                .foregroundColor(
                    counter <= 10 ?  Color.green  : Color.red
                )
                .animation(.easeInOut(duration: 0.2))
        )
    }
    
    func progress() -> CGFloat {
        return CGFloat(counter) / CGFloat(countTo)
    }
}

