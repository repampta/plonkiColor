import SwiftUI

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    func readPosition(onChange: @escaping (CGRect) -> Void) -> some View {
        background(alignment: .center) {
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: PositionPreferenceKey.self, value: geometryProxy.frame(in: .global))
            }
        }
        .onPreferenceChange(PositionPreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

private struct PositionPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

extension View {
    func backgroundImage(image: ImageResource, blur: CGFloat = 0) -> some View {
        ZStack {
            Rectangle().fill(.clear)
                .background {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .blur(radius: blur)
                }
                .ignoresSafeArea(.keyboard)
            self
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

