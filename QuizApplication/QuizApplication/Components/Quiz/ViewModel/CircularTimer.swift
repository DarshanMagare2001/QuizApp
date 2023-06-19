//
//  CircularTimer.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

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
                .font(.custom("Avenir Next", size: 18))
                .fontWeight(.black)
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

struct ProgressTrackForCircularProgressbarForQuiz: View {
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 80, height: 80)
            .overlay(
                Circle().stroke(Color.black, lineWidth: 12)
            )
    }
}

struct ProgressBarForCircularProgressbarForQuiz: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 80, height: 80)
            .overlay(
                Circle().trim(from: 0, to: progress())
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round,
                            lineJoin: .round
                        )
                )
                .foregroundColor(
                    counter <= 20 ?  Color.green  : Color.red
                )
                .animation(.easeInOut(duration: 0.2))
        )
    }
    
    func progress() -> CGFloat {
        return CGFloat(counter) / CGFloat(countTo)
    }
}

