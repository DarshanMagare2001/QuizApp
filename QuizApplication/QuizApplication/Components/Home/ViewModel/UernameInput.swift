//
//  UernameInput.swift
//  QuizApplication
//
//  Created by IPS-161 on 20/06/23.
//

import SwiftUI

struct UernameInput: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("Darshan")
                    .foregroundColor(.white)
                Spacer()
            }
            .background(Color.black)
            Spacer()
        }
        .background(Color.clear)
        .padding(.horizontal, 10)
    }
}


struct UernameInput_Previews: PreviewProvider {
    static var previews: some View {
        UernameInput()
    }
}
