//
//  ComicEnvironment.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import Foundation
import Combine

final class ComicEnvironment: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()

    @Published var title: String = String(.appTitle) {
       willSet {
            self.objectWillChange.send()
        }
    }
}
