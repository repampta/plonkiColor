import SwiftUI

struct ModalView<Content: View>: View {
    @Binding var isShowingModalView: Bool
    
    let content: Content
    
    init(isShowingModalView: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._isShowingModalView = isShowingModalView
        self.content = content()
    }
    
    var body: some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.cGradOne, lineWidth: 2)
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: Color(hex: "#FFE500").opacity(0.8), radius: 5, x: 0, y: 0)
            .shadow(color: Color(hex: "#8400BD").opacity(0.4), radius: 12, x: 0, y: 0)
            .shadow(color: Color(hex: "#8400BD"), radius: 20, x: 0, y: 0)
    }
}

#Preview {
    ModalView(isShowingModalView: .constant(true)) {
        Text("Some text")
    }
}


struct ModalViewModifer<T: View>: ViewModifier {
    @Environment(\.isModalPresented) private var isModalPresented
    
    @Binding var isShowingModalView: Bool
    
    let modalView: T
    
    init(isShowingModelView: Binding<Bool>, modelView: T) {
        self._isShowingModalView = isShowingModelView
        self.modalView = modelView
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .center) {
                if isShowingModalView {
                    ModalView(isShowingModalView: $isShowingModalView) {
                        modalView
                    }
                    .transition(.scale)
                }
            }
            .onChange(of: isShowingModalView) { value in
                isModalPresented.isModalShowing = value
            }
    }
}

struct ModalViewDim: ViewModifier {
    @Environment(\.isModalPresented) private var isModalPresented
    @State private var viewIsDimmed = false
    
    let actions: () -> ()
    
    func body(content: Content) -> some View {
        content
            .onReceive(isModalPresented.$isModalShowing) { value in
                self.viewIsDimmed = value
            }
            .overlay {
                if viewIsDimmed {
                    Color.black.opacity(0.6).ignoresSafeArea()
                        .onTapGesture {
                            actions()
                        }
                }
            }
    }
}

extension View {
    func modalView<Content: View>(
        isShowingModalView: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        modifier(
            ModalViewModifer(
                isShowingModelView: isShowingModalView,
                modelView: content()
            )
        )
    }
    
    func modalViewDim(actions: @escaping () -> ()) -> some View {
        modifier(ModalViewDim { actions() })
    }
}
