//
//  SearchComicModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 2/9/23.
//

import Foundation

struct SearchComicModel: Identifiable {
    let id: Int
    let path: String
    
    init(from model: SearchedComicsDecodableModel) {
        self.id = model.num ?? -1
        self.path = model.path ?? ""
    }
}
