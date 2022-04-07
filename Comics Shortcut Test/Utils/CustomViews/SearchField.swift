//
//  SearchField.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import Foundation
import SwiftUI

struct SearchField : View {
    @Binding var searchedString: String
    let placeholder: String
    let onUpdateSearchText: (String) -> Void
    
    func onKeyStroke() {
        onUpdateSearchText(searchedString)
    }
    
    var body: some View {
        TextField(placeholder, text: $searchedString)
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                })
            .multilineTextAlignment(.center)
            .onReceive(NotificationCenter.default
                        .publisher(for: UITextField.textDidChangeNotification, object: nil)
                .debounce(for: 0.5,
                          scheduler: DispatchQueue.main),
                       perform: { _ in
                onKeyStroke()
            })
    }
}

#if DEBUG
struct SearchField_Previews : PreviewProvider {
    static var previews: some View {
        SearchField(searchedString: .constant("Searched text"),
                    placeholder: "Search anything",
                    onUpdateSearchText: {text in
            
        })
    }
}
#endif
