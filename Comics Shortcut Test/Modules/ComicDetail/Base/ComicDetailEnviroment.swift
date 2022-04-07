//
//  ComicDetailEnviroment.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation
import Combine

final class ComicDetailEnviroment: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()

    @Published var title: String = String(.comicDetail) {
       willSet {
            self.objectWillChange.send()
        }
    }
}
