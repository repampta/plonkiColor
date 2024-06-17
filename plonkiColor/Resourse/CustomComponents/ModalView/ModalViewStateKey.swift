import Foundation
import SwiftUI

struct ModalViewStateKey: EnvironmentKey {
    static var defaultValue: ModalViewState = ModalViewState()
}

extension EnvironmentValues {
    var isModalPresented: ModalViewState {
        get { self[ModalViewStateKey.self] }
        set { self[ModalViewStateKey.self] = newValue }
    }
}

class ModalViewState: ObservableObject {
    @Published var isModalShowing = false
}
