//
//  BottomSheet.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

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
