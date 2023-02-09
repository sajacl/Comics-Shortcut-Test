//
//  SearchedComicsDecodableModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation

/// Decodable representation of searched `Comic`.
struct SearchedComicsDecodableModel: Decodable {
    let num: Int?
    let path: String?
}
