//
//  QuizApplicationApp.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

import SwiftUI

@main
struct QuizApplicationApp: App {
    
  @State var viewModel = QuizModelClass()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }.environmentObject(viewModel)
        }
    }
}
