//
//  UIApplication.swift
//  testAppMovie
//
//  Created by apple on 2/5/21.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
