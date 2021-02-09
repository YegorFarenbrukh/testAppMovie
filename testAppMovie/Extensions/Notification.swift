//
//  Notification.swift
//  testAppMovie
//
//  Created by apple on 2/5/21.
//

import UIKit

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
