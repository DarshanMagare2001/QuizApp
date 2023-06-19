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
        VStack {
            Text("Quiz Finished")
                .font(.title)
                .padding(.top, 20)
            
            Spacer()
            
            Text("Score: \(score)/\(totalQuestions)")
                .font(.headline)
            
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
    
    private func dismissSheet() {
        self.presentationMode.wrappedValue.dismiss()
    }
}
