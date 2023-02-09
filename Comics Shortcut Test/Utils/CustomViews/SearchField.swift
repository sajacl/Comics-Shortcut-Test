//
//  SearchField.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import Foundation
import SwiftUI
import Combine

struct SearchField: View {
    private let searchedString: Binding<String>
    
    /// TextField's place holder.
    private let placeholder: String
    
    /// Text update completion handler.
    /// - Warning: This completion is debounced for a constant  time. (0.5 second)
    private let updateTextCompletion: ((String) -> Void)?
    
    /// Scheduler to receive text changed notifications.
    private let textChangePublisher: Publishers.Debounce<NotificationCenter.Publisher, DispatchQueue>
    
    init(
        searchedString: Binding<String>,
        placeholder: String,
        notificationCenter: NotificationCenter = .default,
        updateTextCompletion: ((String) -> Void)? = nil
    ) {
        self.searchedString = searchedString
        self.placeholder = placeholder
        
        textChangePublisher = notificationCenter
            .publisher(for: UITextField.textDidChangeNotification)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
        
        self.updateTextCompletion = updateTextCompletion
    }
    
    var body: some View {
        TextField(placeholder, text: searchedString)
            .modifier(
                SearchFieldModifier()
            )
            .onReceive(
                textChangePublisher,
                perform: { _ in
                    updateTextCompletion?(
                        searchedString.wrappedValue
                    )
                }
            )
    }
}

private struct SearchFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                searchImage
            )
    }
    
    private var searchImage: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(.gray)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
    }
}

#if DEBUG
struct SearchField_Previews : PreviewProvider {
    static var previews: some View {
        SearchField(
            searchedString: .constant("Searched text"),
            placeholder: "Search anything"
        )
    }
}
#endif
