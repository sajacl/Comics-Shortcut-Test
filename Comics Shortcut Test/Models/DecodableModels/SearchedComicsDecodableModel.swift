//
//  SearchedComicsDecodableModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation

// MARK: - Searching Comics, Need A Representation Custom Model
// MARK: - Model For Searching Comics

struct SearchedComicsDecodableModel: Decodable {
    let num: Int?
    let path: String?
}

struct SearchComicModel: Identifiable {
    let id: Int
    let path: String
}

extension SearchComicModel {
    init(decodableModel: SearchedComicsDecodableModel) {
        self.id = decodableModel.num ?? -1
        self.path = decodableModel.path ?? ""
    }
}
