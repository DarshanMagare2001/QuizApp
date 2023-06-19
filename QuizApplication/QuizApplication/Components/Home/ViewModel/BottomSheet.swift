//
//  BottomSheet.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

//This is Bottom sheet

import SwiftUI

struct BottomSheet: View {
  var body: some View {
      VStack{
          HStack{
              Spacer()
              Text("Rules")
                  .font(.largeTitle)
                  .foregroundColor(.red)
                  .padding(.vertical , 5)
                  .padding(.horizontal , 50)
                  .background(Color(.systemGray5))
                  .cornerRadius(20)
                  .shadow(color: .black, radius: 15)
              Spacer()
          }.padding(.vertical , 5)
          
          //Rules for quiz game
          
          HStack{
              Spacer()
              VStack(alignment:.leading , spacing: 5){
                  HStack{
                      Text("1)")
                      Text("Each question have timer so attend questions according it.")
                          .font(.caption)
                      Spacer()
                  }
                  HStack{
                      Text("2)")
                      Text("You cant submit quiz without attending all questions.")
                          .font(.caption)
                      Spacer()
                  }
                  HStack{
                      Text("3)")
                      Text("This is MCQ's based quiz so you have four option from which you have to choose one correct option.")
                          .font(.caption)
                      Spacer()
                  }
                  HStack{
                      Text("4)")
                      Text("Questions will coming randomly one at a time.")
                          .font(.caption)
                      Spacer()
                  }
                  HStack{
                      Text("5)")
                      Text("Feedback will be provided after submission of quiz.")
                          .font(.caption)
                      Spacer()
                  }
                  
                  
                  
              }
              Spacer()
          }
             
          Spacer()
           
      }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
            .environmentObject(QuizModelClass())
    }
}
