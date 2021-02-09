//
//  View.swift
//  testAppMovie
//
//  Created by apple on 2/5/21.
//

import SwiftUI
import Combine

// MARK: - Keyboard Adaptive
struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight - 250)
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
