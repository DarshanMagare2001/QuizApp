import SwiftUI
import SwiftUIBottomSheet
struct HomeView: View {
    @State private var isShown = false
    @State private var height: CGFloat = 250
    @State private var requestedSize: CGFloat = 250
    @State private var isDifficultyViewShow = false
    
    var body: some View {
        ZStack {
            BubbleView()
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
                        isDifficultyViewShow.toggle()
                    }) {
                        HStack {
                            Spacer()
                            Text("Play Now")
                                .foregroundColor(.white)
                                .font(.title)
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                    }
                    
                    Button(action: {
                        isShown = true
                    }) {
                        HStack {
                            Spacer()
                            Text("Rules")
                                .foregroundColor(.white)
                                .font(.title)
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .bottomSheet(isPresented: $isShown, config: .init(sizeChangeRequest: $requestedSize)) {
                    BottomSheet()
                        .frame(height: height)
                }
                .onValueChange(requestedSize) { sz in
                    if height < 220 && sz > 220 {
                        height = 250
                    } else if height > 580 && sz < 580 {
                        height = 250
                    }
                }
            }
            
            NavigationLink(destination: DifficultyView(), isActive: $isDifficultyViewShow){
                
            }
              
        }
     }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

