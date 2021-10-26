//
//  SearchBar.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/5/21.
//

import SwiftUI

// Credit: Matteo Pacini
// Implementation adapted from StackOverflow.
// URL: https://stackoverflow.com/a/56611503/16366491

struct SearchBar: UIViewRepresentable {

    let placeholder: String?
    @Binding var text: String

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.keyboardType = .numberPad
        searchBar.returnKeyType = .search
        searchBar.backgroundImage = UIImage() // Removes the top and bottom divider
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
}
