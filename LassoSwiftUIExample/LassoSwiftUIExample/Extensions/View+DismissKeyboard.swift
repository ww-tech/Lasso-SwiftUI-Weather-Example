//
//  View+DismissKeyboard.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/5/21.
//

// Credit: Paul Hudson
// Implementation adapted from Hacking with Swift.
// URL: https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield

import UIKit

enum KeyboardManager {
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
