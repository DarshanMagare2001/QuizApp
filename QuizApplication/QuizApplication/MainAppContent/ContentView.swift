//
//  ContentView.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : QuizModelClass
    
    var body: some View {
        VStack{
            // Home view
            HomeView()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(QuizModelClass())
    }
}
