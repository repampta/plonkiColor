import SwiftUI
import Combine

struct LoadingScreen: View {
    @ObservedObject var loadignViewModel: LoadingViewModel
    @State private var loadingProgress: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Hello to Ball Color")
                .font(Font.custom("KleeOne-Regular", size: 28))
                .foregroundStyle(.light)
            ProgressBarView(currentProgress: loadingProgress, maxProgress: 280)
        }
        .padding(.bottom, 100)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .backgroundImage(image: .bgLoad)
        .onChange(of: loadignViewModel.isAnimating) { animating in
            if animating {
                withAnimation(.linear(duration: 2)) {
                    loadingProgress = 280
                }
            }
        }
    }
}

#Preview {
    LoadingScreen(loadignViewModel: LoadingViewModel())
}
