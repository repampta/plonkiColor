import SwiftUI

struct GameWinModalView: View {
    var goToHome: () -> () = { }
    var nextLevel: () -> () = { }
    
    var body: some View {
        ZStack {
            Image(.gameWinModal)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack {
                Text("Congratulations!")
                    .font(.custom("KleeOne-SemiBold", size: 36))
                    .foregroundStyle(.cGradOne)
                
                Spacer()
                
                VStack(spacing: 24) {
                    Text("You distributed all the colors correctly and earned 50 coins and 50 points")
                        .font(.custom("Chivo-Regular", size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.light)
                    
                    HStack(spacing: 16) {
                        Button("GO TO HOME") {
                            goToHome()
                        }
                        .buttonStyle(SecondaryButtonStyle(height: 48))
                        
                        Button("NEXT LEVEL") {
                            nextLevel()
                        }
                        .buttonStyle(SecondaryButtonStyle(height: 48, color: .cGradOne))
                    }
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
            .padding(.horizontal, 11)
            .frame(width: 353, height: 570, alignment: .top)
        }
    }
}

#Preview {
    GameWinModalView()
}

extension GameWinModalView {
    func goHome(_ handler: @escaping () -> ()) -> GameWinModalView {
        var new = self
        new.goToHome = handler
        return new
    }
    
    func next(_ handler: @escaping () -> ()) -> GameWinModalView {
        var new = self
        new.nextLevel = handler
        return new
    }
}
