//
//  HorizontalProgressBAr.swift
//  QuizApplication
//
//  Created by IPS-161 on 19/06/23.
//

import Foundation
import SwiftUI

struct HorizontalProgressBar: View {
    var currentQuestionIndex: Int
    var totalQuestions: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: geometry.size.width, height: 10)
                
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: calculateProgressWidth(geometry: geometry), height: 10)
            }
        }
    }
    
    private func calculateProgressWidth(geometry: GeometryProxy) -> CGFloat {
        let maxWidth = geometry.size.width
        let questionProgress = CGFloat(currentQuestionIndex) / CGFloat(totalQuestions)
        return maxWidth * questionProgress
    }
}
