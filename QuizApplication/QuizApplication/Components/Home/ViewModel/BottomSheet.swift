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
              Spacer()
          }
          
          Spacer()
          
          
      }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}
