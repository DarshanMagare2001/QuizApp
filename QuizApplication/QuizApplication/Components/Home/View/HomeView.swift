
//This is home view

import SwiftUI


struct HomeView: View {
    @State private var isShown = false
    @State private var height: CGFloat = 250
    @State private var requestedSize: CGFloat = 250
    @State private var isDifficultyViewShow = false
    @State private var isPopupShow = false
    
    @State private var username: String = ""
    
    var body: some View {
        ZStack {
            BubbleView()
            if isPopupShow && UserDefaults.standard.string(forKey: "Username") == nil {
                Userinput(isShowing: $isPopupShow, isDifficultyViewShow: $isDifficultyViewShow)
            } else {
                VStack {
                    HStack {
                        Spacer()
                        Text("Quiz")
                            .italic()
                            .font(.largeTitle)
                            .bold()
                            .padding(5)
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(20)
                    .opacity(0.7)
                    .shadow(color: .white, radius: 10)
                    .padding(10)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("Let's Play!")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .italic()
                            .font(.largeTitle)
                            .bold()
                            .shadow(color: .red, radius: 20)
                        Spacer()
                    }
                    
                    VStack {
                        Button(action: {
                            isPopupShow.toggle()
                            if isPopupShow && UserDefaults.standard.string(forKey: "Username") == nil {
                               
                            }else{
                                isDifficultyViewShow.toggle()
                            }
                            
                        }) {
                            HStack {
                                Spacer()
                                Text("Play Now")
                                    .foregroundColor(.black)
                                    .font(.title)
                                    .bold()
                                Spacer()
                            }
                            .padding()
                            .background(.green)
                            .cornerRadius(20)
                            .opacity(0.7)
                            .shadow(color: .white, radius: 10)
                        }
                      
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                   
                }
            }
            
            NavigationLink(destination: DifficultyView(), isActive: $isDifficultyViewShow){
                
            }
        }
        .onAppear {
            if let storedUsername = UserDefaults.standard.string(forKey: "Username") {
                username = storedUsername
            }
        }
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

