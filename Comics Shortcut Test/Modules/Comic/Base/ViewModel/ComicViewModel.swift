//
//  ComicViewModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Combine
import SwiftUI

extension ComicView {
    class ViewModel: ObservableObject {
        @Published var comics: [ComicModel] = [] {
           willSet {
                self.objectWillChange.send()
            }
        }
        
        var items: [ComicIdHolderModel] = {
            (1...100).map { ComicIdHolderModel(id: "\($0)") }
        }()
        
        func populateMoreComics() {
            items.append(contentsOf:
                            ((items.count + 1)...(items.count + 100)).map { ComicIdHolderModel(id: "\($0)") }
            )
        }
    }
}
